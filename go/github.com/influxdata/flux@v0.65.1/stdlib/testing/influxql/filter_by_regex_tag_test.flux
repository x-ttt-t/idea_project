package influxql_test

import "testing"
import "internal/influxql"

inData = "
#datatype,string,long,dateTime:RFC3339,string,string,string,double
#group,false,false,false,true,true,true,false
#default,0,,,,,,
,result,table,_time,_measurement,t,_field,_value
,,0,1970-01-01T00:00:00Z,hex,0x0,n,0
,,1,1970-01-01T00:00:00.000000001Z,hex,0x1,n,1
,,2,1970-01-01T00:00:00.000000016Z,hex,0x10,n,16
,,3,1970-01-01T00:00:00.000000017Z,hex,0x11,n,17
,,4,1970-01-01T00:00:00.000000018Z,hex,0x12,n,18
,,5,1970-01-01T00:00:00.000000019Z,hex,0x13,n,19
,,6,1970-01-01T00:00:00.00000002Z,hex,0x14,n,20
,,7,1970-01-01T00:00:00.000000021Z,hex,0x15,n,21
,,8,1970-01-01T00:00:00.000000022Z,hex,0x16,n,22
,,9,1970-01-01T00:00:00.000000023Z,hex,0x17,n,23
,,10,1970-01-01T00:00:00.000000024Z,hex,0x18,n,24
,,11,1970-01-01T00:00:00.000000025Z,hex,0x19,n,25
,,12,1970-01-01T00:00:00.000000026Z,hex,0x1a,n,26
,,13,1970-01-01T00:00:00.000000027Z,hex,0x1b,n,27
,,14,1970-01-01T00:00:00.000000028Z,hex,0x1c,n,28
,,15,1970-01-01T00:00:00.000000029Z,hex,0x1d,n,29
,,16,1970-01-01T00:00:00.00000003Z,hex,0x1e,n,30
,,17,1970-01-01T00:00:00.000000031Z,hex,0x1f,n,31
,,18,1970-01-01T00:00:00.000000002Z,hex,0x2,n,2
,,19,1970-01-01T00:00:00.000000032Z,hex,0x20,n,32
,,20,1970-01-01T00:00:00.000000033Z,hex,0x21,n,33
,,21,1970-01-01T00:00:00.000000034Z,hex,0x22,n,34
,,22,1970-01-01T00:00:00.000000035Z,hex,0x23,n,35
,,23,1970-01-01T00:00:00.000000036Z,hex,0x24,n,36
,,24,1970-01-01T00:00:00.000000037Z,hex,0x25,n,37
,,25,1970-01-01T00:00:00.000000038Z,hex,0x26,n,38
,,26,1970-01-01T00:00:00.000000039Z,hex,0x27,n,39
,,27,1970-01-01T00:00:00.00000004Z,hex,0x28,n,40
,,28,1970-01-01T00:00:00.000000041Z,hex,0x29,n,41
,,29,1970-01-01T00:00:00.000000042Z,hex,0x2a,n,42
,,30,1970-01-01T00:00:00.000000043Z,hex,0x2b,n,43
,,31,1970-01-01T00:00:00.000000044Z,hex,0x2c,n,44
,,32,1970-01-01T00:00:00.000000045Z,hex,0x2d,n,45
,,33,1970-01-01T00:00:00.000000046Z,hex,0x2e,n,46
,,34,1970-01-01T00:00:00.000000047Z,hex,0x2f,n,47
,,35,1970-01-01T00:00:00.000000003Z,hex,0x3,n,3
,,36,1970-01-01T00:00:00.000000048Z,hex,0x30,n,48
,,37,1970-01-01T00:00:00.000000049Z,hex,0x31,n,49
,,38,1970-01-01T00:00:00.00000005Z,hex,0x32,n,50
,,39,1970-01-01T00:00:00.000000051Z,hex,0x33,n,51
,,40,1970-01-01T00:00:00.000000052Z,hex,0x34,n,52
,,41,1970-01-01T00:00:00.000000053Z,hex,0x35,n,53
,,42,1970-01-01T00:00:00.000000054Z,hex,0x36,n,54
,,43,1970-01-01T00:00:00.000000055Z,hex,0x37,n,55
,,44,1970-01-01T00:00:00.000000056Z,hex,0x38,n,56
,,45,1970-01-01T00:00:00.000000057Z,hex,0x39,n,57
,,46,1970-01-01T00:00:00.000000058Z,hex,0x3a,n,58
,,47,1970-01-01T00:00:00.000000059Z,hex,0x3b,n,59
,,48,1970-01-01T00:00:00.00000006Z,hex,0x3c,n,60
,,49,1970-01-01T00:00:00.000000061Z,hex,0x3d,n,61
,,50,1970-01-01T00:00:00.000000062Z,hex,0x3e,n,62
,,51,1970-01-01T00:00:00.000000063Z,hex,0x3f,n,63
,,52,1970-01-01T00:00:00.000000004Z,hex,0x4,n,4
,,53,1970-01-01T00:00:00.000000064Z,hex,0x40,n,64
,,54,1970-01-01T00:00:00.000000065Z,hex,0x41,n,65
,,55,1970-01-01T00:00:00.000000066Z,hex,0x42,n,66
,,56,1970-01-01T00:00:00.000000067Z,hex,0x43,n,67
,,57,1970-01-01T00:00:00.000000068Z,hex,0x44,n,68
,,58,1970-01-01T00:00:00.000000069Z,hex,0x45,n,69
,,59,1970-01-01T00:00:00.00000007Z,hex,0x46,n,70
,,60,1970-01-01T00:00:00.000000071Z,hex,0x47,n,71
,,61,1970-01-01T00:00:00.000000072Z,hex,0x48,n,72
,,62,1970-01-01T00:00:00.000000073Z,hex,0x49,n,73
,,63,1970-01-01T00:00:00.000000074Z,hex,0x4a,n,74
,,64,1970-01-01T00:00:00.000000075Z,hex,0x4b,n,75
,,65,1970-01-01T00:00:00.000000076Z,hex,0x4c,n,76
,,66,1970-01-01T00:00:00.000000077Z,hex,0x4d,n,77
,,67,1970-01-01T00:00:00.000000078Z,hex,0x4e,n,78
,,68,1970-01-01T00:00:00.000000079Z,hex,0x4f,n,79
,,69,1970-01-01T00:00:00.000000005Z,hex,0x5,n,5
,,70,1970-01-01T00:00:00.00000008Z,hex,0x50,n,80
,,71,1970-01-01T00:00:00.000000081Z,hex,0x51,n,81
,,72,1970-01-01T00:00:00.000000082Z,hex,0x52,n,82
,,73,1970-01-01T00:00:00.000000083Z,hex,0x53,n,83
,,74,1970-01-01T00:00:00.000000084Z,hex,0x54,n,84
,,75,1970-01-01T00:00:00.000000085Z,hex,0x55,n,85
,,76,1970-01-01T00:00:00.000000086Z,hex,0x56,n,86
,,77,1970-01-01T00:00:00.000000087Z,hex,0x57,n,87
,,78,1970-01-01T00:00:00.000000088Z,hex,0x58,n,88
,,79,1970-01-01T00:00:00.000000089Z,hex,0x59,n,89
,,80,1970-01-01T00:00:00.00000009Z,hex,0x5a,n,90
,,81,1970-01-01T00:00:00.000000091Z,hex,0x5b,n,91
,,82,1970-01-01T00:00:00.000000092Z,hex,0x5c,n,92
,,83,1970-01-01T00:00:00.000000093Z,hex,0x5d,n,93
,,84,1970-01-01T00:00:00.000000094Z,hex,0x5e,n,94
,,85,1970-01-01T00:00:00.000000095Z,hex,0x5f,n,95
,,86,1970-01-01T00:00:00.000000006Z,hex,0x6,n,6
,,87,1970-01-01T00:00:00.000000096Z,hex,0x60,n,96
,,88,1970-01-01T00:00:00.000000097Z,hex,0x61,n,97
,,89,1970-01-01T00:00:00.000000098Z,hex,0x62,n,98
,,90,1970-01-01T00:00:00.000000099Z,hex,0x63,n,99
,,91,1970-01-01T00:00:00.0000001Z,hex,0x64,n,100
,,92,1970-01-01T00:00:00.000000101Z,hex,0x65,n,101
,,93,1970-01-01T00:00:00.000000102Z,hex,0x66,n,102
,,94,1970-01-01T00:00:00.000000103Z,hex,0x67,n,103
,,95,1970-01-01T00:00:00.000000104Z,hex,0x68,n,104
,,96,1970-01-01T00:00:00.000000105Z,hex,0x69,n,105
,,97,1970-01-01T00:00:00.000000106Z,hex,0x6a,n,106
,,98,1970-01-01T00:00:00.000000107Z,hex,0x6b,n,107
,,99,1970-01-01T00:00:00.000000108Z,hex,0x6c,n,108
,,100,1970-01-01T00:00:00.000000109Z,hex,0x6d,n,109
,,101,1970-01-01T00:00:00.00000011Z,hex,0x6e,n,110
,,102,1970-01-01T00:00:00.000000111Z,hex,0x6f,n,111
,,103,1970-01-01T00:00:00.000000007Z,hex,0x7,n,7
,,104,1970-01-01T00:00:00.000000112Z,hex,0x70,n,112
,,105,1970-01-01T00:00:00.000000113Z,hex,0x71,n,113
,,106,1970-01-01T00:00:00.000000114Z,hex,0x72,n,114
,,107,1970-01-01T00:00:00.000000115Z,hex,0x73,n,115
,,108,1970-01-01T00:00:00.000000116Z,hex,0x74,n,116
,,109,1970-01-01T00:00:00.000000117Z,hex,0x75,n,117
,,110,1970-01-01T00:00:00.000000118Z,hex,0x76,n,118
,,111,1970-01-01T00:00:00.000000119Z,hex,0x77,n,119
,,112,1970-01-01T00:00:00.00000012Z,hex,0x78,n,120
,,113,1970-01-01T00:00:00.000000121Z,hex,0x79,n,121
,,114,1970-01-01T00:00:00.000000122Z,hex,0x7a,n,122
,,115,1970-01-01T00:00:00.000000123Z,hex,0x7b,n,123
,,116,1970-01-01T00:00:00.000000124Z,hex,0x7c,n,124
,,117,1970-01-01T00:00:00.000000125Z,hex,0x7d,n,125
,,118,1970-01-01T00:00:00.000000126Z,hex,0x7e,n,126
,,119,1970-01-01T00:00:00.000000127Z,hex,0x7f,n,127
,,120,1970-01-01T00:00:00.000000008Z,hex,0x8,n,8
,,121,1970-01-01T00:00:00.000000128Z,hex,0x80,n,128
,,122,1970-01-01T00:00:00.000000129Z,hex,0x81,n,129
,,123,1970-01-01T00:00:00.00000013Z,hex,0x82,n,130
,,124,1970-01-01T00:00:00.000000131Z,hex,0x83,n,131
,,125,1970-01-01T00:00:00.000000132Z,hex,0x84,n,132
,,126,1970-01-01T00:00:00.000000133Z,hex,0x85,n,133
,,127,1970-01-01T00:00:00.000000134Z,hex,0x86,n,134
,,128,1970-01-01T00:00:00.000000135Z,hex,0x87,n,135
,,129,1970-01-01T00:00:00.000000136Z,hex,0x88,n,136
,,130,1970-01-01T00:00:00.000000137Z,hex,0x89,n,137
,,131,1970-01-01T00:00:00.000000138Z,hex,0x8a,n,138
,,132,1970-01-01T00:00:00.000000139Z,hex,0x8b,n,139
,,133,1970-01-01T00:00:00.00000014Z,hex,0x8c,n,140
,,134,1970-01-01T00:00:00.000000141Z,hex,0x8d,n,141
,,135,1970-01-01T00:00:00.000000142Z,hex,0x8e,n,142
,,136,1970-01-01T00:00:00.000000143Z,hex,0x8f,n,143
,,137,1970-01-01T00:00:00.000000009Z,hex,0x9,n,9
,,138,1970-01-01T00:00:00.000000144Z,hex,0x90,n,144
,,139,1970-01-01T00:00:00.000000145Z,hex,0x91,n,145
,,140,1970-01-01T00:00:00.000000146Z,hex,0x92,n,146
,,141,1970-01-01T00:00:00.000000147Z,hex,0x93,n,147
,,142,1970-01-01T00:00:00.000000148Z,hex,0x94,n,148
,,143,1970-01-01T00:00:00.000000149Z,hex,0x95,n,149
,,144,1970-01-01T00:00:00.00000015Z,hex,0x96,n,150
,,145,1970-01-01T00:00:00.000000151Z,hex,0x97,n,151
,,146,1970-01-01T00:00:00.000000152Z,hex,0x98,n,152
,,147,1970-01-01T00:00:00.000000153Z,hex,0x99,n,153
,,148,1970-01-01T00:00:00.000000154Z,hex,0x9a,n,154
,,149,1970-01-01T00:00:00.000000155Z,hex,0x9b,n,155
,,150,1970-01-01T00:00:00.000000156Z,hex,0x9c,n,156
,,151,1970-01-01T00:00:00.000000157Z,hex,0x9d,n,157
,,152,1970-01-01T00:00:00.000000158Z,hex,0x9e,n,158
,,153,1970-01-01T00:00:00.000000159Z,hex,0x9f,n,159
,,154,1970-01-01T00:00:00.00000001Z,hex,0xa,n,10
,,155,1970-01-01T00:00:00.00000016Z,hex,0xa0,n,160
,,156,1970-01-01T00:00:00.000000161Z,hex,0xa1,n,161
,,157,1970-01-01T00:00:00.000000162Z,hex,0xa2,n,162
,,158,1970-01-01T00:00:00.000000163Z,hex,0xa3,n,163
,,159,1970-01-01T00:00:00.000000164Z,hex,0xa4,n,164
,,160,1970-01-01T00:00:00.000000165Z,hex,0xa5,n,165
,,161,1970-01-01T00:00:00.000000166Z,hex,0xa6,n,166
,,162,1970-01-01T00:00:00.000000167Z,hex,0xa7,n,167
,,163,1970-01-01T00:00:00.000000168Z,hex,0xa8,n,168
,,164,1970-01-01T00:00:00.000000169Z,hex,0xa9,n,169
,,165,1970-01-01T00:00:00.00000017Z,hex,0xaa,n,170
,,166,1970-01-01T00:00:00.000000171Z,hex,0xab,n,171
,,167,1970-01-01T00:00:00.000000172Z,hex,0xac,n,172
,,168,1970-01-01T00:00:00.000000173Z,hex,0xad,n,173
,,169,1970-01-01T00:00:00.000000174Z,hex,0xae,n,174
,,170,1970-01-01T00:00:00.000000175Z,hex,0xaf,n,175
,,171,1970-01-01T00:00:00.000000011Z,hex,0xb,n,11
,,172,1970-01-01T00:00:00.000000176Z,hex,0xb0,n,176
,,173,1970-01-01T00:00:00.000000177Z,hex,0xb1,n,177
,,174,1970-01-01T00:00:00.000000178Z,hex,0xb2,n,178
,,175,1970-01-01T00:00:00.000000179Z,hex,0xb3,n,179
,,176,1970-01-01T00:00:00.00000018Z,hex,0xb4,n,180
,,177,1970-01-01T00:00:00.000000181Z,hex,0xb5,n,181
,,178,1970-01-01T00:00:00.000000182Z,hex,0xb6,n,182
,,179,1970-01-01T00:00:00.000000183Z,hex,0xb7,n,183
,,180,1970-01-01T00:00:00.000000184Z,hex,0xb8,n,184
,,181,1970-01-01T00:00:00.000000185Z,hex,0xb9,n,185
,,182,1970-01-01T00:00:00.000000186Z,hex,0xba,n,186
,,183,1970-01-01T00:00:00.000000187Z,hex,0xbb,n,187
,,184,1970-01-01T00:00:00.000000188Z,hex,0xbc,n,188
,,185,1970-01-01T00:00:00.000000189Z,hex,0xbd,n,189
,,186,1970-01-01T00:00:00.00000019Z,hex,0xbe,n,190
,,187,1970-01-01T00:00:00.000000191Z,hex,0xbf,n,191
,,188,1970-01-01T00:00:00.000000012Z,hex,0xc,n,12
,,189,1970-01-01T00:00:00.000000192Z,hex,0xc0,n,192
,,190,1970-01-01T00:00:00.000000193Z,hex,0xc1,n,193
,,191,1970-01-01T00:00:00.000000194Z,hex,0xc2,n,194
,,192,1970-01-01T00:00:00.000000195Z,hex,0xc3,n,195
,,193,1970-01-01T00:00:00.000000196Z,hex,0xc4,n,196
,,194,1970-01-01T00:00:00.000000197Z,hex,0xc5,n,197
,,195,1970-01-01T00:00:00.000000198Z,hex,0xc6,n,198
,,196,1970-01-01T00:00:00.000000199Z,hex,0xc7,n,199
,,197,1970-01-01T00:00:00.000000013Z,hex,0xd,n,13
,,198,1970-01-01T00:00:00.000000014Z,hex,0xe,n,14
,,199,1970-01-01T00:00:00.000000015Z,hex,0xf,n,15
"

outData = "
#datatype,string,long,dateTime:RFC3339,string,double
#group,false,false,false,true,false
#default,0,,,,
,result,table,time,_measurement,n
,,0,1970-01-01T00:00:00.000000003Z,hex,3
,,0,1970-01-01T00:00:00.00000002Z,hex,20
,,0,1970-01-01T00:00:00.000000025Z,hex,25
,,0,1970-01-01T00:00:00.000000041Z,hex,41
,,0,1970-01-01T00:00:00.000000085Z,hex,85
,,0,1970-01-01T00:00:00.000000086Z,hex,86
,,0,1970-01-01T00:00:00.00000009Z,hex,90
,,0,1970-01-01T00:00:00.000000101Z,hex,101
,,0,1970-01-01T00:00:00.000000112Z,hex,112
,,0,1970-01-01T00:00:00.000000123Z,hex,123
,,0,1970-01-01T00:00:00.000000125Z,hex,125
,,0,1970-01-01T00:00:00.000000129Z,hex,129
,,0,1970-01-01T00:00:00.00000013Z,hex,130
,,0,1970-01-01T00:00:00.000000137Z,hex,137
,,0,1970-01-01T00:00:00.00000016Z,hex,160
,,0,1970-01-01T00:00:00.000000163Z,hex,163
,,0,1970-01-01T00:00:00.000000183Z,hex,183
,,0,1970-01-01T00:00:00.000000185Z,hex,185
,,0,1970-01-01T00:00:00.000000193Z,hex,193
,,0,1970-01-01T00:00:00.000000199Z,hex,199
"

// SELECT n FROM hex WHERE t =~ /^(0x7b|0x70|0x55|0x19|0x65|0xa3|0x89|0xc1|0x3|0x14|0x29|0x81|0xb7|0xb9|0x82|0x56|0xa0|0xc7|0x5a|0x7d)$/
t_filter_by_regex_tag = (tables=<-) => tables
	|> range(start: influxql.minTime, stop: influxql.maxTime)
	|> filter(fn: (r) => r._measurement == "hex")
	|> filter(fn: (r) => r._field == "n")
	|> filter(fn: (r) => r.t =~ /^(0x7b|0x70|0x55|0x19|0x65|0xa3|0x89|0xc1|0x3|0x14|0x29|0x81|0xb7|0xb9|0x82|0x56|0xa0|0xc7|0x5a|0x7d)$/)
	|> group(columns: ["_measurement", "_field"])
	|> sort(columns: ["_time"])
	|> keep(columns: ["_time", "_value", "_measurement"])
	|> rename(columns: {_time: "time", _value: "n"})

test _filter_by_regex_tag = () => ({
	input: testing.loadStorage(csv: inData),
	want: testing.loadMem(csv: outData),
	fn: t_filter_by_regex_tag,
})
