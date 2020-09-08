const https = require("https")
const pool = require("./pool")
//请求数据源
https.get("https://c.m.163.com/ug/api/wuhan/app/data/list-total",(res)=>{
    //存储请求回来的数据
    let results = ''
    //请求过程中
    res.on('data',(data)=>{
        //将请求结果拼接
        results += data
    })
    //请求完毕后
    res.on('end',()=>{
        //将请求结果转json
        let result =  JSON.parse(results)

        //获取到country_data表内容
        let country_data = result.data.chinaDayList
        country_data.forEach(item => {
            //插入数据库
            pool.query('INSERT INTO country_data VALUES (?,?,?,?,?,?)',[item.date,item.total.confirm,item.total.suspect,item.total.heal,item.total.dead,item.total.input])
        });

        //获取到region_data表内容
        let region_data = result.data.areaTree[2].children
        //存放整理出来的数据
        let arr = []
        //处理data数据
        region_data.forEach(item => {
            //获取到省份 item.name
            item.children.forEach(childrenItem =>{
                // 获取到关联的城市 items.name 以及关联城市的总数据childrenItem.total
                // 拼接整理
                arr.push({"pname":item.name,"cname":childrenItem.name,"confirm":childrenItem.total.confirm,"suspect":childrenItem.total.suspect,"heal":childrenItem.total.heal,"dead":childrenItem.total.dead})
            })
        });
        //结果
        arr.forEach(item=>{
            //插入数据库
            pool.query('INSERT INTO region_data VALUES (?,?,?,?,?,?)',[item.pname,item.cname,item.confirm,item.suspect,item.heal,item.dead])
        })
    })
})