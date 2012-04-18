import re
import string

whitelist = string.letters + string.digits + ' ' + '/' + '?' + '.' + '!' + '@' + '#' + '$' + '%' + '&' + '*' + '(' + ')' + '_' + '-' + '=' + '+' + ':' + ';' + '|' + '[' + ']' + '{' + '}' + '<' + '>' + '~' + '^' + '`'
date_finder = re.compile('([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4})')

def english_date_to_iso_date(englishDate):
    year = ''
    yearFinder = re.compile('[0-9]{1,2}/[0-9]{1,2}/([0-9]{2,4})')
    monthFinder = re.compile('([0-9]{1,2})/[0-9]{1,2}/[0-9]{2,4}')
    dayFinder = re.compile('[0-9]{1,2}/([0-9]{1,2})/([0-9]{2,4})')
    yearMatch = yearFinder.search(englishDate.group())
    monthMatch = monthFinder.search(englishDate.group())
    dayMatch = dayFinder.search(englishDate.group())
    isoString = yearMatch.group(1) + '-' + monthMatch.group(1).zfill(2) + '-' + dayMatch.group(1).zfill(2)
    return isoString

def clean_string_for_sql(dirty_string):
    clean_string = ''
    string_removed_line_breaks = dirty_string.replace('\n', '')
    string_removed_carriage_returns = string_removed_line_breaks.replace('\r', '')
    string_removed_form_feeds = string_removed_carriage_returns.replace('\f', '')
    string_removed_slash_b = string_removed_form_feeds.replace('\b','')
    string_removed_slash_t = string_removed_slash_b.replace('\t','')
    string_removed_slash_apastrophe = string_removed_slash_t.replace("\'",'')
    string_iso_date = date_finder.sub(english_date_to_iso_date,string_removed_slash_apastrophe)
    string_empty_date = string_iso_date.replace('0/0/0','0000-00-00')
    for character in string_empty_date:
        if character in whitelist:
            clean_string += character
    return clean_string
