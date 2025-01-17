rec {
  # 服务黑名单，如下services不展示日志，以 | 隔离。
  excludeServicesRegex =
    "ModemManager|accounts-daemon|cupsd|dbus-daemon|dbus-send|dhcpcd|dnsmasq|dnsmasq-dhcp|gpg-agent|kernel|nscd|polkitd|wpa_supplicant";

  # 匹配服务日志 
  logRegexSet = {
    jsy-archiver =
      "^${escaping}s*${timeRegexSet.Y-M-D_H-M-S}${escaping}s*${levelRegesSet.lowerLogLevel}${escaping}s*(${jobNameRegexSet.jsy-archiver}${escaping}s*${durationRegexSet.datapipeline}${escaping}s*${conclusionRegexSet.datapipeline})?${any-chars}$";
    jsy-importer =
      "^${escaping}s*${timeRegexSet.Y-M-D_H-M-S}${escaping}s*${levelRegesSet.lowerLogLevel}${escaping}s*(${jobNameRegexSet.jsy-importer}${escaping}s*${durationRegexSet.datapipeline}${escaping}s*${conclusionRegexSet.datapipeline})?${any-chars}$";
    wind-importer =
      "^${escaping}s*${timeRegexSet.Y-M-D_H-M-S}${escaping}s*${levelRegesSet.lowerLogLevel}${escaping}s*(${jobNameRegexSet.wind-importer}${escaping}s*${durationRegexSet.datapipeline}${escaping}s*${conclusionRegexSet.datapipeline})?${any-chars}$";
  };

  # 匹配日志时间 
  timeRegexSet = {
    # 格式： [2021-10-20 15:23:13.027] [info] 'JsyDailyArchiveJob JsyMinBarArchiver 2021-10-20' is completed, duration = 2752Ms, conclusion = OK
    Y-M-D_H-M-S =
      "${escaping}[${escaping}s?(?P<time>${escaping}d{4}-${escaping}d{2}-${escaping}d{2}${escaping}s?${escaping}d{2}:${escaping}d{2}:${escaping}d{2}${escaping}.${escaping}d{3})${escaping}s?${escaping}]";
  };

  # 匹配日志级别 
  levelRegesSet = {
    # 格式： [info] [warning] 
    lowerLogLevel =
      "${escaping}[(?P<level>(info|warning|error|critical|trace|debug))${escaping}]";
    # 格式： INFO WARNING ERROR
    upperLogLevel = "(?P<level>(INFO|WARNING|ERROR|CRITICAL|TRACE|DEBUG))";
  };

  # 匹配任务名称
  jobNameRegexSet = {
    #  格式：'JsyDailyArchiveJob JsyPriceDBArchiver 2021-10-19' is completed, duration = 20996Ms, conclusion = OK'
    jsy-archiver =
      "${escaping}'JsyDailyArchiveJob${escaping}s?(?P<archiver_job>${escaping}S+)${escaping}s?${escaping}d{4}-${escaping}d{2}-${escaping}d{2}${escaping}s?${escaping}'";
    #  格式：'JsyDailyImporterJob JsyTickTradeArcImporter 2021-10-19' is completed, duration = 48448Ms, conclusion = OK'
    jsy-importer =
      "${escaping}'JsyDailyImporterJob${escaping}s?(?P<importer_job>${escaping}S+)${escaping}s?${escaping}d{4}-${escaping}d{2}-${escaping}d{2}${escaping}s?${escaping}'";
    #  格式：'WindDailyImporterJob WindStockRatingImporter 2021-10-19' is completed, duration = 98Ms, conclusion = OK'
    #            'WindBulkImporterJob WindFinancialStatementBulkJob' is completed, duration = 162059Ms, conclusion = OK'
    wind-importer =
      "${escaping}'(WindDailyImporterJob|WindBulkImporterJob)${escaping}s?(?P<importer_job>${escaping}S+)${escaping}s?(${escaping}d{4}-${escaping}d{2}-${escaping}d{2}${escaping}s?)?${escaping}'";
  };

  # 匹配任务运行结果 
  conclusionRegexSet = {
    # 格式：conclusion = OK | conclusion = ALREADY_EXISTS: Output file '/var/lib/wonder/warehouse/archive/price_db/2021/09/24.arc' exists
    datapipeline =
      "${escaping}s?conclusion${escaping}s?=${escaping}s?(?P<conclusion>(OK|${escaping}S+:))${escaping}s?";
  };

  # 匹配任务耗时
  durationRegexSet = {
    datapipeline =
      "${escaping}s?is${escaping}s?completed,${escaping}s?duration${escaping}s?=${escaping}s?(?P<duration>[0-9]*)Ms,${escaping}s?";
  };

  #  匹配任意多个字符
  any-chars = ".*";
  # YAML中需要使用 \\ 进行转义，\\替换到YAML中会被合并为\，因此需要使用  \\\\\\\\
  escaping = "\\\\\\\\";
}
