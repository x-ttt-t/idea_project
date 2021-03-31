package universe_test

import "testing"

option now = () => (2030-01-01T00:00:00Z)

inData = "
#datatype,string,long,dateTime:RFC3339,boolean,string,string
#group,false,false,false,false,true,true
#default,_result,,,,,
,result,table,_time,_value,_field,_measurement
,,0,2018-05-22T19:53:00Z,true,k0,m
,,0,2018-05-22T19:53:01Z,false,k0,m
#datatype,string,long,dateTime:RFC3339,double,string,string
#group,false,false,false,false,true,true
#default,_result,,,,,
,result,table,_time,_value,_field,_measurement
,,1,2018-05-22T19:53:10Z,0,k1,m
,,1,2018-05-22T19:53:11Z,1,k1,m
,,1,2018-05-22T19:53:12Z,1.0,k1,m
,,1,2018-05-22T19:53:13Z,1.1e5,k1,m
,,1,2018-05-22T19:53:14Z,1.1e-5,k1,m
,,1,2018-05-22T19:53:15Z,0.0000024,k1,m
,,1,2018-05-22T19:53:16Z,-23.123456,k1,m
,,1,2018-05-22T19:53:17Z,-922337203.6854775808,k1,m
#datatype,string,long,dateTime:RFC3339,long,string,string
#group,false,false,false,false,true,true
#default,_result,,,,,
,result,table,_time,_value,_field,_measurement
,,2,2018-05-22T19:53:20Z,1,k2,m
,,2,2018-05-22T19:53:21Z,-1,k2,m
,,2,2018-05-22T19:53:22Z,0,k2,m
,,2,2018-05-22T19:53:23Z,2147483647,k2,m
,,2,2018-05-22T19:53:24Z,-2147483648,k2,m
,,2,2018-05-22T19:53:25Z,9223372036854775807,k2,m
,,2,2018-05-22T19:53:26Z,-9223372036854775808,k2,m
#datatype,string,long,dateTime:RFC3339,string,string,string
#group,false,false,false,false,true,true
#default,_result,,,,,
,result,table,_time,_value,_field,_measurement
,,3,2018-05-22T19:53:30Z,0,k3,m
,,3,2018-05-22T19:53:31Z,1,k3,m
,,3,2018-05-22T19:53:32Z,1.0,k3,m
,,3,2018-05-22T19:53:33Z,1.1e5,k3,m
,,3,2018-05-22T19:53:34Z,1.1e-5,k3,m
,,3,2018-05-22T19:53:35Z,0.0000024,k3,m
,,3,2018-05-22T19:53:36Z,-23.123456,k3,m
,,3,2018-05-22T19:53:37Z,-922337203.6854775808,k3,m
#datatype,string,long,dateTime:RFC3339,unsignedLong,string,string
#group,false,false,false,false,true,true
#default,_result,,,,,
,result,table,_time,_value,_field,_measurement
,,4,2018-05-22T19:53:40Z,0,k4,m
,,4,2018-05-22T19:53:41Z,1,k4,m
,,4,2018-05-22T19:53:42Z,18446744073709551615,k4,m
,,4,2018-05-22T19:53:43Z,4294967296,k4,m
,,4,2018-05-22T19:53:44Z,9223372036854775808,k4,m
"

outData = "
#datatype,string,long,dateTime:RFC3339,dateTime:RFC3339,dateTime:RFC3339,string,string,double
#group,false,false,true,true,false,true,true,false
#default,want,,,,,,,
,result,table,_start,_stop,_time,_field,_measurement,_value
,,0,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:00Z,k0,m,1.0
,,0,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:01Z,k0`,m,0.0
,,1,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:10Z,k1,m,0
,,1,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:11Z,k1,m,1
,,1,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:12Z,k1,m,1.0
,,1,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:13Z,k1,m,110000
,,1,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:14Z,k1,m,0.000011
,,1,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:15Z,k1,m,0.0000024
,,1,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:16Z,k1,m,-23.123456
,,1,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:17Z,k1,m,-922337203.6854775808
,,2,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:20Z,k2,m,1
,,2,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:21Z,k2,m,-1
,,2,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:22Z,k2,m,0
,,2,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:23Z,k2,m,2147483647
,,2,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:24Z,k2,m,-2147483648
,,2,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:25Z,k2,m,9223372036854775807
,,2,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:26Z,k2,m,-9223372036854775808
,,3,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:30Z,k3,m,0
,,3,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:31Z,k3,m,1
,,3,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:32Z,k3,m,1.0
,,3,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:33Z,k3,m,110000
,,3,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:34Z,k3,m,0.000011
,,3,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:35Z,k3,m,0.0000024
,,3,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:36Z,k3,m,-23.123456
,,3,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:37Z,k3,m,-922337203.6854775808
,,4,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:40Z,k4,m,0
,,4,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:41Z,k4,m,1
,,4,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:42Z,k4,m,18446744073709551615
,,4,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:43Z,k4,m,4294967296
,,4,2018-05-22T19:52:00Z,2030-01-01T00:00:00Z,2018-05-22T19:53:44Z,k4,m,9223372036854775808
"

t_to_float = (table=<-) =>
	(table
		|> range(start: 2018-05-22T19:52:00Z)
		|> toFloat())

test _to = () =>
	({input: testing.loadStorage(csv: inData), want: testing.loadMem(csv: outData), fn: t_to_float})


