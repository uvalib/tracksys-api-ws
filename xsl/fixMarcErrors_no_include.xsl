<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.loc.gov/MARC21/slim" xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="marc xs" version="2.0">

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <!-- PARAMETERS -->
  <xsl:param name="keep999s" select="'true'"/>

  <!-- GLOBAL VARIABLES -->
  <xsl:variable name="marcDatafieldDesc">
    <!-- marcDesc.xml physically included -->
    <!--<xsl:copy-of select="document('marcDesc.xml')//*:datafield"/>-->
    <datafield tag="010" repeat="NR" desc="Library of congress control number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="LC control number"/>
      <subfield code="b" repeat="R" desc="NUCMC control number"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid LC control number"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="013" repeat="R" desc="Patent control information">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Number"/>
      <subfield code="b" repeat="NR" desc="Country"/>
      <subfield code="c" repeat="NR" desc="Type of number"/>
      <subfield code="d" repeat="R" desc="Date"/>
      <subfield code="e" repeat="R" desc="Status"/>
      <subfield code="f" repeat="R" desc="Party to document"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="015" repeat="R" desc="National bibliography number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="National bibliography number"/>
      <subfield code="q" repeat="R" desc="Qualifying information"/>
      <subfield code="z" repeat="R" desc="Canceled/Invalid national bibliographic number"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="016" repeat="R" desc="National bibliographic agency control number">
      <ind1 values=" 7" desc="National bibliographic agency"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Record control number"/>
      <subfield code="z" repeat="R" desc="Canceled or invalid record control number"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="017" repeat="R" desc="Copyright or legal deposit number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="R" desc="Copyright registration number"/>
      <subfield code="b" repeat="NR" desc="Assigning agency"/>
      <subfield code="d" repeat="NR" desc="Date"/>
      <subfield code="i" repeat="NR" desc="Display Text"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid copyright or legal deposit number"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="018" repeat="NR" desc="Copyright article-fee code">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Copyright article-fee code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="019" repeat="NR" desc="OCLC control number cross-reference">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="OCLC control number of merged and deleted record"/>
    </datafield>
    <datafield tag="020" repeat="R" desc="International standard book number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="International Standard Book Number"/>
      <subfield code="c" repeat="NR" desc="Terms of availability"/>
      <subfield code="q" repeat="R" desc="Qualifier"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid ISBN"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="022" repeat="R" desc="International standard serial number">
      <ind1 values=" 01" desc="Level of international interest"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="l" repeat="NR" desc="ISSN-L"/>
      <subfield code="m" repeat="R" desc="Canceled ISSN-L"/>
      <subfield code="y" repeat="R" desc="Incorrect ISSN"/>
      <subfield code="z" repeat="R" desc="Canceled ISSN"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="024" repeat="R" desc="Other standard identifier">
      <ind1 values="0123478" desc="Type of standard number or code"/>
      <ind2 values=" 01" desc="Difference indicator"/>
      <subfield code="a" repeat="NR" desc="Standard number or code"/>
      <subfield code="c" repeat="NR" desc="Terms of availability"/>
      <subfield code="d" repeat="NR" desc="Additional codes following the standard number or code"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid standard number or code"/>
      <subfield code="q" repeat="R" desc="Qualifying information"/>
      <subfield code="2" repeat="NR" desc="Source of number or code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="025" repeat="R" desc="Overseas acquisition number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Overseas acquisition number"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="026" repeat="R" desc="Fingerprint identifier">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="First and second groups of characters"/>
      <subfield code="b" repeat="R" desc="Third and fourth groups of characters"/>
      <subfield code="c" repeat="NR" desc="Date"/>
      <subfield code="d" repeat="R" desc="Number of volume or part"/>
      <subfield code="e" repeat="NR" desc="Unparsed fingerprint"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="5" repeat="R" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="027" repeat="R" desc="Standard technical report number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Standard technical report number"/>
      <subfield code="q" repeat="R" desc="Qualifying information"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="028" repeat="R" desc="Publisher number">
      <ind1 values="0-6" desc="Type of publisher number"/>
      <ind2 values="0-3" desc="Note/added entry controller"/>
      <subfield code="a" repeat="NR" desc="Publisher number"/>
      <subfield code="b" repeat="NR" desc="Source"/>
      <subfield code="q" repeat="R" desc="Qualifying information"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="029" repeat="R" desc="Other system control number">
      <ind1 values="01" desc="Type of system control number"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="OCLC library identifier"/>
      <subfield code="b" repeat="NR" desc="System control number"/>
      <subfield code="c" repeat="NR" desc="OAI set name"/>
      <subfield code="t" repeat="NR" desc="Content type identifier"/>
    </datafield>
    <datafield tag="030" repeat="R" desc="Coden designation">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Coden"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid CODEN"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="031" repeat="R" desc="Musical incipits information">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Number of work"/>
      <subfield code="b" repeat="NR" desc="Number of movement"/>
      <subfield code="c" repeat="NR" desc="Number of excerpt"/>
      <subfield code="d" repeat="R" desc="Caption or heading"/>
      <subfield code="e" repeat="NR" desc="Role"/>
      <subfield code="g" repeat="NR" desc="Clef"/>
      <subfield code="m" repeat="NR" desc="Voice/instrument"/>
      <subfield code="n" repeat="NR" desc="Key signature"/>
      <subfield code="o" repeat="NR" desc="Time signature"/>
      <subfield code="p" repeat="NR" desc="Musical notation"/>
      <subfield code="q" repeat="R" desc="General note"/>
      <subfield code="r" repeat="NR" desc="Key or mode"/>
      <subfield code="s" repeat="R" desc="Coded validity note"/>
      <subfield code="t" repeat="R" desc="Text incipit"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="y" repeat="R" desc="Link text"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="2" repeat="NR" desc="System code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="032" repeat="R" desc="Postal registration number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Postal registration number"/>
      <subfield code="b" repeat="NR" desc="Source (agency assigning number)"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="033" repeat="R" desc="Date/time and place of an event">
      <ind1 values=" 012" desc="Type of date in subfield $a"/>
      <ind2 values=" 012" desc="Type of event"/>
      <subfield code="a" repeat="R" desc="Formatted date/time"/>
      <subfield code="b" repeat="R" desc="Geographic classification area code"/>
      <subfield code="c" repeat="R" desc="Geographic classification subarea code"/>
      <subfield code="p" repeat="R" desc="Place of event"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="034" repeat="R" desc="Coded cartographic mathematical data">
      <ind1 values="013" desc="Type of scale"/>
      <ind2 values=" 01" desc="Type of ring"/>
      <subfield code="a" repeat="NR" desc="Category of scale"/>
      <subfield code="b" repeat="R" desc="Constant ratio linear horizontal scale"/>
      <subfield code="c" repeat="R" desc="Constant ratio linear vertical scale"/>
      <subfield code="d" repeat="NR" desc="Coordinates — westernmost longitude"/>
      <subfield code="e" repeat="NR" desc="Coordinates — easternmost longitude"/>
      <subfield code="f" repeat="NR" desc="Coordinates — northernmost latitude"/>
      <subfield code="g" repeat="NR" desc="Coordinates — southernmost latitude"/>
      <subfield code="h" repeat="R" desc="Angular scale"/>
      <subfield code="j" repeat="NR" desc="Declination — northern limit"/>
      <subfield code="k" repeat="NR" desc="Declination — southern limit"/>
      <subfield code="m" repeat="NR" desc="Right ascension — eastern limit"/>
      <subfield code="n" repeat="NR" desc="Right ascension — western limit"/>
      <subfield code="p" repeat="NR" desc="Equinox"/>
      <subfield code="r" repeat="NR" desc="Distance from earth"/>
      <subfield code="s" repeat="R" desc="G-ring latitude"/>
      <subfield code="t" repeat="R" desc="G-ring longitude"/>
      <subfield code="x" repeat="NR" desc="Beginning date"/>
      <subfield code="y" repeat="NR" desc="Ending date"/>
      <subfield code="z" repeat="NR" desc="Name of extraterrestial body"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="035" repeat="R" desc="System control number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="System control number" occurs="M"/>
      <!-- OCLC permits subfield b that LC does not. -->
      <!-- The OCLC symbol of the institution that assigned the number. Use subfield ǂb for each subfield ǂa and each 
      subfield ǂz. Enter subfield ǂb after the appropriate subfield. If you are following LC practice, do not use 
      subfield ǂb. (https://www.oclc.org/bibformats/en/0xx/035.html) -->
      <subfield code="b" repeat="R" desc="Institution symbol"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid control number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="036" repeat="NR" desc="Original study number for computer data files">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Original study number"/>
      <subfield code="b" repeat="NR" desc="Source (agency assigning number)"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="037" repeat="R" desc="Source of acquisition">
      <ind1 values=" 23" desc="Source of acquisition sequence"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Stock number"/>
      <subfield code="b" repeat="NR" desc="Source of stock number/acquisition"/>
      <subfield code="c" repeat="R" desc="Terms of availability"/>
      <subfield code="f" repeat="R" desc="Form of issue"/>
      <subfield code="g" repeat="R" desc="Additional format characteristics"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="R" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="038" repeat="NR" desc="Record content licensor">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Record content licensor"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="040" repeat="NR" desc="Cataloging source">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Original cataloging agency"/>
      <!-- https://www.oclc.org/bibformats/en/0xx/040.html says $b is mandatory -->
      <subfield code="b" repeat="NR" desc="Language of cataloging">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $b must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="c" repeat="NR" desc="Transcribing agency"/>
      <subfield code="d" repeat="R" desc="Modifying agency"/>
      <subfield code="e" repeat="R" desc="Description conventions"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="041" repeat="R" desc="Language code">
      <ind1 values=" 01" desc="Translation indication"/>
      <ind2 values=" 7" desc="Source of code"/>
      <subfield code="a" repeat="R" desc="Language code of text/sound track or separate title">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $a must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="b" repeat="R" desc="Language code of summary or abstract">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $b must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="d" repeat="R" desc="Language code of sung or spoken text">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $d must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="e" repeat="R" desc="Language code of librettos">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $e must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="f" repeat="R" desc="Language code of table of contents">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $f must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="g" repeat="R" desc="Language code of accompanying material other than librettos">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $g must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="h" repeat="R" desc="Language code of original and/or intermediate translations of text">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $h must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="i" repeat="R" desc="Language code of intertitles">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $i must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="j" repeat="R" desc="Language code of subtitles or captions">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $j must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="k" repeat="R" desc="Language code of intermediate translations">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $k must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="m" repeat="R" desc="Language code of original accompanying materials other than librettos">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $m must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="n" repeat="R" desc="Language code of original libretto">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $n must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="p" repeat="R" desc="Language code of captions">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $p must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="q" repeat="R" desc="Language code of accessible audio">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $q must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="r" repeat="R" desc="Language code of accessible visual language (non-textual)">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $r must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="t" repeat="R" desc="Language code of accompanying transcripts for audiovisual materials">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $t must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="2" repeat="NR" desc="Source of code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <pattern xmlns="http://purl.oclc.org/dsdl/schematron">
        <title>041 First $a or $d</title>
        <rule
          context="*:datafield[@tag = '041' and @ind2 != '7'][not(matches(substring(ancestor::*:record/*:controlfield[@tag = '008'], 36, 3), 'mul|zxx'))]/*:subfield[matches(@code, '[ad]')][1]">
          <let name="record001" value="ancestor::*:record/*:controlfield[@tag = '001']"/>
          <let name="lang008"
            value="substring(ancestor::*:record/*:controlfield[@tag = '008'], 36, 3)"/>
          <assert test=". = $lang008" role="warning">
            <value-of select="concat($record001, ' :: ')"/>
            <value-of select="concat('Datafield ', ../@tag)"/> first subfield $<value-of
              select="@code"/> should match language code in 008/35-37.</assert>
        </rule>
      </pattern>
      <pattern xmlns="http://purl.oclc.org/dsdl/schematron">
        <title>041 Translation</title>
        <rule
          context="*:datafield[@tag = '041' and @ind1 = '1'] | *:datafield[@tag = '880' and @ind1 = '1'][matches(*:subfield[@code = '6'], '^041')]">
          <let name="record001" value="ancestor::*:record/*:controlfield[@tag = '001']"/>
          <assert test="*:subfield[matches(@code, '[hjmn]')]" role="warning">
            <value-of select="concat($record001, ' :: ')"/>
            <value-of select="concat('Datafield ', @tag)"/> subfield $h, $j, $m, or $n is
            recommended when @ind1 = '1'. </assert>
          <assert test="count(distinct-values(*:subfield[matches(@code, '[a-z]')])) &gt; 1">
            <value-of select="concat($record001, ' :: ')"/>
            <value-of select="concat('Datafield ', @tag)"/> at least 2 unique subfield values are
            required when @ind1 = '1'. </assert>
        </rule>
        <rule
          context="*:datafield[@tag = '041' and *:subfield[matches(@code, '[hmn]')]] | *:datafield[@tag = '880' and *:subfield[matches(@code, '[hn]')]][matches(*:subfield[@code = '6'], '^041')]">
          <let name="record001" value="ancestor::*:record/*:controlfield[@tag = '001']"/>
          <assert test="@ind1 = '1'" role="warning">
            <value-of select="concat($record001, ' :: ')"/>
            <value-of select="concat('Datafield ', @tag)"/> when subfield $h, $m, or $n is present,
            @ind1 should equal '1'. </assert>
        </rule>
      </pattern>
    </datafield>
    <datafield tag="042" repeat="NR" desc="Authentication code">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Authentication code"/>
    </datafield>
    <datafield tag="043" repeat="R" desc="Geographic area code">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Geographic area code"/>
      <subfield code="b" repeat="R" desc="Local GAC code"/>
      <subfield code="c" repeat="R" desc="ISO code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="R" desc="Source of local code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="044" repeat="NR" desc="Country of publishing/producing entity code">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="MARC country code">
			<assert test="matches(., $marcCountryCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $a must match a valid country code.</assert>
		</subfield>
      <subfield code="b" repeat="R" desc="Local subentity code"/>
      <subfield code="c" repeat="R" desc="ISO country code"/>
      <subfield code="2" repeat="R" desc="Source of local subentity code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="045" repeat="NR" desc="Time period of content">
      <ind1 values=" 012" desc="Type of time period in subfield $b or $c"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Time period code"/>
      <subfield code="b" repeat="R" desc="Formatted 9999 B.C. through C.E. time period"/>
      <subfield code="c" repeat="R" desc="Formatted pre-9999 B.C. time period"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="046" repeat="R" desc="Special coded dates">
      <ind1 values=" 123" desc="Type of entity"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Type of date code"/>
      <subfield code="b" repeat="NR" desc="Date 1 (B.C. date)"/>
      <subfield code="c" repeat="NR" desc="Date 1 (C.E. date)"/>
      <subfield code="d" repeat="NR" desc="Date 2 (B.C. date)"/>
      <subfield code="e" repeat="NR" desc="Date 2 (C.E. date)"/>
      <subfield code="j" repeat="NR" desc="Date resource modified"/>
      <subfield code="k" repeat="NR" desc="Beginning or single date created"/>
      <subfield code="l" repeat="NR" desc="Ending date created"/>
      <subfield code="m" repeat="NR" desc="Beginning of date valid"/>
      <subfield code="n" repeat="NR" desc="End of date valid"/>
      <subfield code="o" repeat="NR" desc="Single or starting date for aggregated content"/>
      <subfield code="p" repeat="NR" desc="Ending date for aggregated content"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="2" repeat="NR" desc="Source of date"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="047" repeat="R" desc="Form of musical composition code">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" 7" desc="Source of code"/>
      <subfield code="a" repeat="R" desc="Form of musical composition code"/>
      <subfield code="2" repeat="NR" desc="Source of code"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="048" repeat="R" desc="Number of musical instruments or voices code">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" 7" desc="Source specified in subfield $2"/>
      <subfield code="a" repeat="R" desc="Performer or ensemble"/>
      <subfield code="b" repeat="R" desc="Soloist"/>
      <subfield code="2" repeat="NR" desc="Source of code"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="049" repeat="NR" desc="Local holdings">
      <ind1 values=" 012" desc="Controls printing"/>
      <ind2 values=" 01" desc="Indicates the completeness of holdings data"/>
      <subfield code="a" repeat="R" desc="Holding library" occurs="M"/>
      <subfield code="c" repeat="R" desc="Copy statement"/>
      <subfield code="d" repeat="R" desc="Definition of bibliographic subdivisions"/>
      <subfield code="l" repeat="R" desc="Local processing data"/>
      <subfield code="m" repeat="R" desc="Missing elements"/>
      <subfield code="n" repeat="NR" desc="Notes about holdings"/>
      <subfield code="o" repeat="R" desc="Local processing data"/>
      <subfield code="p" repeat="R" desc="Secondary bibliographic subdivision"/>
      <subfield code="q" repeat="R" desc="Third bibliographic subdivision"/>
      <subfield code="r" repeat="R" desc="Fourth bibliographic subdivision"/>
      <subfield code="s" repeat="R" desc="Fifth bibliographic subdivision"/>
      <subfield code="t" repeat="R" desc="Sixth bibliographic subdivision"/>
      <subfield code="u" repeat="R" desc="Seventh bibliographic subdivision"/>
      <subfield code="v" repeat="R" desc="Primary bibliographic subdivision"/>
      <subfield code="y" repeat="NR" desc="Inclusive dates of publication or coverage"/>
    </datafield>
    <datafield tag="050" repeat="R" desc="Library of congress call number">
      <ind1 values=" 01" desc="Existence in LC collection"/>
      <!-- Second indicator was defined in 1982. Prior to that change, 050 was an agency-assigned field 
      and contained only call numbers assigned by the Library of Congress. LC records created before the 
      definition of this indicator may contain a blank (#) meaning undefined in this position. -->
      <ind2 values=" 04" desc="Source of call number"/>
      <subfield code="a" repeat="R" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="u" repeat="R" desc="Locally defined"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <assert test="
          matches(normalize-space(string-join(*:subfield, ' ')),
          '^[A-Z]+\s?\d+(\s?\.\d+)?(\s\d[^\s]+)?(\s?\.[A-Z]+\d+)?(\s\d+[^\s]+)?(\s[A-Z]\d+)?(\s[^\s]+)*$')"
        role="warning">
        <value-of select="concat($record001, ' :: ')"/>
        <value-of select="concat('Datafield ', @tag)"/> suspect value.</assert>
    </datafield>
    <datafield tag="051" repeat="R" desc="Library of congress copy, issue, offprint statement">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="c" repeat="NR" desc="Copy information"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="052" repeat="R" desc="Geographic classification">
      <ind1 values=" 17" desc="Code source"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Geographic classification area code"/>
      <subfield code="b" repeat="R" desc="Geographic classification subarea code"/>
      <subfield code="d" repeat="R" desc="Populated place name"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Code source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="055" repeat="R" desc="Classification numbers assigned in canada">
      <ind1 values=" 01" desc="Existence in LAC collection"/>
      <ind2 values="0-9" desc="Type, completeness, source of class/call number"/>
      <subfield code="a" repeat="NR" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of call/class number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="060" repeat="R" desc="National library of medicine call number">
      <ind1 values=" 01" desc="Existence in NLM collection"/>
      <!-- Second indicator was defined in 1982. Prior to that change, 060 was an agency-assigned 
      field and contained only call numbers assigned by the National Library of Medicine. NLM 
      records created before the definition of this indicator may contain a blank (#) meaning 
      undefined in the second indicator position. -->
      <ind2 values=" 04" desc="Source of call number"/>
      <subfield code="a" repeat="R" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="061" repeat="R" desc="National library of medicine copy statement">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="c" repeat="NR" desc="Copy information"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="066" repeat="NR" desc="Character sets present">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Primary G0 character set"/>
      <subfield code="b" repeat="NR" desc="Primary G1 character set"/>
      <subfield code="c" repeat="R" desc="Alternate G0 or G1 character set"/>
    </datafield>
    <datafield tag="070" repeat="R" desc="National agricultural library call number">
      <ind1 values=" 01" desc="Existence in NAL collection"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="071" repeat="R" desc="National agricultural library copy statement">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="c" repeat="NR" desc="Copy information"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="072" repeat="R" desc="Subject category code">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" 07" desc="Source specified in subfield $2"/>
      <subfield code="a" repeat="NR" desc="Subject category code"/>
      <subfield code="x" repeat="R" desc="Subject category code subdivision"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="074" repeat="R" desc="Gpo item number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="GPO item number"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid GPO item number"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="080" repeat="R" desc="Universal decimal classification number">
      <ind1 values=" 01" desc="Type of edition"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Universal Decimal Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="x" repeat="R" desc="Common auxiliary subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Edition identifier"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="082" repeat="R" desc="Dewey decimal classification number">
      <!-- Code '#' (No edition information recorded) was valid 1979-1987. Records created before the 
      definition of the first indicator in 1979 may contain a blank (#) meaning undefined in this 
      indicator position. Code '2' was made obsolete in 1989. The U.S. Library of Congress
      discontinued assigning class numbers from the abridged NST version to items included in New
      Serial Titles as of 1981. -->
      <ind1 values=" 0217" desc="Type of edition"/>
      <!-- Code # (No information provided) was valid 1982-1987. Records created before the definition
      of the second indicator in 1982 may contain a blank (#) meaning undefined in this indicator 
      position. -->
      <ind2 values=" 04" desc="Source of classification number"/>
      <subfield code="a" repeat="R" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="m" repeat="NR" desc="Standard or optional designation"/>
      <subfield code="q" repeat="NR" desc="Assigning agency"/>
      <subfield code="2" repeat="NR" desc="Edition information"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="083" repeat="R" desc="Additional dewey decimal classification number">
      <!-- Code # (No edition information recorded) was valid 1979-1987. Records created before the 
      definition of the first indicator in 1979 may contain a blank (#) meaning undefined in this 
      indicator position. -->
      <ind1 values=" 017" desc="Type of edition"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Classification number"/>
      <subfield code="c" repeat="R" desc="Classification number — Ending number of span"/>
      <subfield code="m" repeat="NR" desc="Standard or optional designation"/>
      <subfield code="q" repeat="NR" desc="Assigning agency"/>
      <subfield code="y" repeat="R" desc="Table sequence number for internal subarrangement or add table"/>
      <subfield code="z" repeat="R" desc="Table identification"/>
      <subfield code="2" repeat="NR" desc="Edition information"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="084" repeat="R" desc="Other classification number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Classification number"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="q" repeat="NR" desc="Assigning agency"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="085" repeat="R" desc="Synthesized classification number components">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Number where instructions are found-single number or beginning number of span"/>
      <subfield code="b" repeat="R" desc="Base number"/>
      <subfield code="c" repeat="R" desc="Classification number-ending number of span"/>
      <subfield code="f" repeat="R" desc="Facet designator"/>
      <subfield code="r" repeat="R" desc="Root number"/>
      <subfield code="s" repeat="R" desc="Digits added from classification number in schedule or external table"/>
      <subfield code="t" repeat="R" desc="Digits added from internal subarrangement or add table"/>
      <subfield code="u" repeat="R" desc="Number being analyzed"/>
      <subfield code="v" repeat="R" desc="Number in internal subarrangement or add table where instructions are found"/>
      <subfield code="w" repeat="R" desc="Table identification-Internal subarrangement or add table"/>
      <subfield code="y" repeat="R" desc="Table sequence number for internal subarrangement or add table"/>
      <subfield code="z" repeat="R" desc="Table identification"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="086" repeat="R" desc="Government document classification number">
      <ind1 values=" 01" desc="Number source"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Classification number"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid classification number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Number source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="088" repeat="R" desc="Report number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Report number"/>
      <subfield code="z" repeat="R" desc="Canceled/invalid report number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="090" repeat="R" desc="Locally assigned LC-type call number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Classification number" occurs="M"/>
      <subfield code="b" repeat="NR" desc="Local cutter number"/>
      <subfield code="e" repeat="NR" desc="Feature heading"/>
      <subfield code="f" repeat="NR" desc="Filing suffix"/>
      <subfield code="m" repeat="NR" desc="Insttitution code"/>
      <subfield code="q" repeat="NR" desc="Library"/>
      <assert test="
          matches(normalize-space(string-join(*:subfield, ' ')),
          '^[A-Z]+\s?\d+(\s?\.\d+)?(\s\d[^\s]+)?(\s?\.[A-Z]+\d+)?(\s\d+[^\s]+)?(\s[A-Z]\d+)?(\s[^\s]+)*$')"
        role="warning">
        <value-of select="concat($record001, ' :: ')"/>
        <value-of select="concat('Datafield ', @tag)"/> suspect value.</assert>
    </datafield>
    <datafield tag="092" repeat="R" desc="Locally assigned dewey call number">
      <ind1 values=" 01" desc="DDC edition"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Classification number" occurs="M"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="e" repeat="NR" desc="Feature heading"/>
      <subfield code="f" repeat="NR" desc="Filing suffix"/>
      <subfield code="2" repeat="NR" desc="Edition number"/>
      <!-- $2 appears to be optional rather than recommended -->
      <!--<subfield code="2" repeat="NR" desc="Edition number" occurs="R"/>-->
    </datafield>
    <datafield tag="096" repeat="R" desc="Locally assigned nlm-type call number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Classification number" occurs="M"/>
      <subfield code="b" repeat="NR" desc="Item number"/>
      <subfield code="e" repeat="NR" desc="Feature heading"/>
      <subfield code="f" repeat="NR" desc="Filing suffix"/>
    </datafield>
    <datafield tag="098" repeat="R" desc="Other classification schemes">
      <ind1 values="0-9" desc="OCLC defined"/>
      <ind2 values="0-9" desc="OCLC defined"/>
      <subfield code="a" repeat="R" desc="Classification number" occurs="M"/>
      <subfield code="e" repeat="NR" desc="Feature heading"/>
      <subfield code="f" repeat="NR" desc="Filing suffix"/>
    </datafield>
    <datafield tag="099" repeat="R" desc="Local free-text call number">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" 019" desc="Source of call number"/>
      <subfield code="a" repeat="R" desc="Classification number" occurs="M"/>
      <subfield code="e" repeat="NR" desc="Feature heading"/>
      <subfield code="f" repeat="NR" desc="Filing suffix"/>
    </datafield>
    <datafield tag="100" repeat="NR" desc="Main entry — personal name">
      <ind1 values="013" desc="Type of personal name entry element"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Personal name"/>
      <subfield code="b" repeat="NR" desc="Numeration"/>
      <subfield code="c" repeat="R" desc="Titles and other words associated with a name"/>
      <subfield code="d" repeat="NR" desc="Dates associated with a name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="j" repeat="R" desc="Attribution qualifier"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Fuller form of name"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="110" repeat="NR" desc="Main entry — corporate name">
      <ind1 values="012" desc="Type of corporate name entry element"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Corporate name or jurisdiction name as entry element"/>
      <subfield code="b" repeat="R" desc="Subordinate unit"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="R" desc="Date of meeting or treaty signing"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="111" repeat="NR" desc="Main entry — meeting name">
      <ind1 values="012" desc="Type of meeting name entry element"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Meeting name or jurisdiction name as entry element"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="R" desc="Date of meeting"/>
      <subfield code="e" repeat="R" desc="Subordinate unit"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="j" repeat="R" desc="Relator term"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Name of meeting following jurisdiction name entry element"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="130" repeat="NR" desc="Main entry — uniform title">
      <ind1 values="0-9" desc="Nonfiling characters"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Uniform title"/>
      <subfield code="d" repeat="R" desc="Date of treaty signing"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="210" repeat="R" desc="Abbreviated title">
      <ind1 values="01" desc="Title added entry"/>
      <ind2 values=" 0" desc="Type"/>
      <subfield code="a" repeat="NR" desc="Abbreviated title"/>
      <subfield code="b" repeat="NR" desc="Qualifying information"/>
      <subfield code="2" repeat="R" desc="Source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="222" repeat="R" desc="Key title">
      <ind1 values=" " desc="Specifies whether variant title and/or added entry is required"/>
      <ind2 values="0-9" desc="Nonfiling characters"/>
      <subfield code="a" repeat="NR" desc="Key title"/>
      <subfield code="b" repeat="NR" desc="Qualifying information"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="240" repeat="NR" desc="Uniform title">
      <ind1 values="01" desc="Uniform title printed or displayed"/>
      <ind2 values="0-9" desc="Nonfiling characters"/>
      <subfield code="a" repeat="NR" desc="Uniform title"/>
      <subfield code="d" repeat="R" desc="Date of treaty signing"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="242" repeat="R" desc="Translation of title by cataloging agency">
      <ind1 values="01" desc="Title added entry"/>
      <ind2 values="0-9" desc="Nonfiling characters"/>
      <subfield code="a" repeat="NR" desc="Title"/>
      <subfield code="b" repeat="NR" desc="Remainder of title"/>
      <subfield code="c" repeat="NR" desc="Statement of responsibility, etc."/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="y" repeat="NR" desc="Language code of translated title">
			<assert test="matches(., $marcLangCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $y must match a valid MARC language code.</assert>
		</subfield>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="243" repeat="NR" desc="Collective uniform title">
      <ind1 values="01" desc="Uniform title printed or displayed"/>
      <ind2 values="0-9" desc="Nonfiling characters"/>
      <subfield code="a" repeat="NR" desc="Uniform title"/>
      <subfield code="d" repeat="R" desc="Date of treaty signing"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="245" repeat="NR" occurs="M" desc="Title statement">
      <ind1 values="01" desc="Title added entry"/>
      <ind2 values="0-9" desc="Nonfiling characters"/>
      <subfield code="a" repeat="NR" desc="Title" occurs="M"/>
      <subfield code="b" repeat="NR" desc="Remainder of title"/>
      <subfield code="c" repeat="NR" desc="Statement of responsibility, etc."/>
      <subfield code="f" repeat="NR" desc="Inclusive dates"/>
      <subfield code="g" repeat="NR" desc="Bulk dates"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="246" repeat="R" desc="Varying form of title">
      <ind1 values="0-3" desc="Note/added entry controller"/>
      <ind2 values=" 012345678" desc="Type of title"/>
      <subfield code="a" repeat="NR" desc="Title proper/short title"/>
      <subfield code="b" repeat="NR" desc="Remainder of title"/>
      <subfield code="f" repeat="NR" desc="Date or sequential designation"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="i" repeat="NR" desc="Display text"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <pattern>
        <rule context="*:datafield[@tag = '246' and @ind2 = '0']/*:subfield[@code = 'a']">
          <let name="record001" value="ancestor::*:record/*:controlfield[@tag = '001']"/>
          <let name="title245"
            value="string-join(ancestor::*:record/*:datafield[@tag = '245'][1]/*:subfield[not(matches(@code, '[h5678]'))], ' ')"/>
          <let name="title245norm" value="
          normalize-space(replace(replace($title245, '\p{Z}', ' '),
          '[\p{P}:\$\+\*\|\(\)\[\]]', ''))"/>
          <let name="subfieldAnorm" value="
          normalize-space(replace(replace(., '\p{Z}', ' '),
          '[\p{P}:\$\+\*\|\(\)\[\]]', ''))"/>
          <assert test="matches($title245norm, $subfieldAnorm, 'i')"><value-of
              select="concat($record001, ' :: ')"/><value-of select="@tag"/> When @ind2='0',
            subfield $a must be a substring of datafield 245.</assert>
        </rule>
      </pattern>
    </datafield>
    <datafield tag="247" repeat="R" desc="Former title">
      <ind1 values="01" desc="Title added entry"/>
      <ind2 values="01" desc="Note controller"/>
      <subfield code="a" repeat="NR" desc="Title"/>
      <subfield code="b" repeat="NR" desc="Remainder of title"/>
      <subfield code="f" repeat="NR" desc="Date or sequential designation"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="250" repeat="R" desc="Edition statement">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Edition statement"/>
      <subfield code="b" repeat="NR" desc="Remainder of edition statement"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="251" repeat="R" desc="Version information">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Version"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="254" repeat="NR" desc="Musical presentation statement">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Musical presentation statement"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="255" repeat="R" desc="Cartographic mathematical data">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Statement of scale"/>
      <subfield code="b" repeat="NR" desc="Statement of projection"/>
      <subfield code="c" repeat="NR" desc="Statement of coordinates"/>
      <subfield code="d" repeat="NR" desc="Statement of zone"/>
      <subfield code="e" repeat="NR" desc="Statement of equinox"/>
      <subfield code="f" repeat="NR" desc="Outer G-ring coordinate pairs"/>
      <subfield code="g" repeat="NR" desc="Exclusion G-ring coordinate pairs"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="256" repeat="NR" desc="Computer file characteristics">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Computer file characteristics"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="257" repeat="R" desc="Country of producing entity for archival films">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Country of producing entity"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="258" repeat="R" desc="Philatelic issue date">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Issuing jurisdiction"/>
      <subfield code="b" repeat="NR" desc="Denomination"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="260" repeat="R" desc="Publication, distribution, etc. (imprint)">
      <ind1 values=" 23" desc="Sequence of publishing statements"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Place of publication, distribution, etc."/>
      <subfield code="b" repeat="R" desc="Name of publisher, distributor, etc."/>
      <subfield code="c" repeat="R" desc="Date of publication, distribution, etc."/>
      <!-- Subfield $d is obsolete -->
      <subfield code="d" repeat="NR" desc="Plate or publisher's number for music (Pre-AACR 2)"/>
      <subfield code="e" repeat="R" desc="Place of manufacture"/>
      <subfield code="f" repeat="R" desc="Manufacturer"/>
      <subfield code="g" repeat="R" desc="Date of manufacture"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <rule context="*:datafield[@tag = '260' and matches(substring(../*:leader, 8, 1), '[am]') and
      not(../*:datafield[@tag = '502'])]">
        <let name="record001" value="../*:controlfield[@tag = '001']"/>
        <assert test="*:subfield[@code = 'a']" role="warning"><value-of
            select="concat($record001, ' :: ')"/><value-of select="@tag"/> subfield $a is
          recommended. </assert>
        <assert test="*:subfield[@code = 'b']" role="warning"><value-of
            select="concat($record001, ' :: ')"/><value-of select="@tag"/> subfield $b is
          recommended. </assert>
        <assert test="*:subfield[@code = 'c']" role="warning"><value-of
            select="concat($record001, ' :: ')"/><value-of select="@tag"/> subfield $c is
          recommended. </assert>
      </rule>
    </datafield>
    <!-- Datafield 261 is obsolete -->
    <datafield tag="261" repeat="NR" desc="IMPRINT STATEMENT FOR FILMS (Pre-AACR 1 Revised)">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Producing company"/>
      <subfield code="b" repeat="R" desc="Releasing company (primary distributor)"/>
      <subfield code="d" repeat="R" desc="Date of production, release, etc."/>
      <subfield code="e" repeat="R" desc="Contractual producer"/>
      <subfield code="f" repeat="R" desc="Place of production, release, etc."/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <!-- Datafield 262 is obsolete -->
    <datafield tag="262" repeat="NR" desc="IMPRINT STATEMENT FOR SOUND RECORDINGS (Pre-AACR 2)">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Place of production, release, etc."/>
      <subfield code="b" repeat="NR" desc="Publisher or trade name"/>
      <subfield code="c" repeat="NR" desc="Date of production, release, etc."/>
      <subfield code="k" repeat="NR" desc="Serial identification"/>
      <subfield code="l" repeat="NR" desc="Matrix and/or take number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="263" repeat="NR" desc="Projected publication date">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Projected publication date"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="264" repeat="R" desc="Production, publication, distribution, manufacture, and
    copyright notice">
      <ind1 values=" 23" desc="Sequence of statements"/>
      <ind2 values="0-4" desc="Function of entity"/>
      <subfield code="a" repeat="R" desc="Place of production, publication, distribution, manufacture"/>
      <subfield code="b" repeat="R" desc="Name of producer, publisher, distributor, manufacturer"/>
      <subfield code="c" repeat="R" desc="Date of production, publication, distribution, manufacture, or copyright notice"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="270" repeat="R" desc="Address">
      <ind1 values=" 12" desc="Level"/>
      <ind2 values=" 07" desc="Type of address"/>
      <subfield code="a" repeat="R" desc="Address"/>
      <subfield code="b" repeat="NR" desc="City"/>
      <subfield code="c" repeat="NR" desc="State or province"/>
      <subfield code="d" repeat="NR" desc="Country"/>
      <subfield code="e" repeat="NR" desc="Postal code"/>
      <subfield code="f" repeat="NR" desc="Terms preceding attention name"/>
      <subfield code="g" repeat="NR" desc="Attention name"/>
      <subfield code="h" repeat="NR" desc="Attention position"/>
      <subfield code="i" repeat="NR" desc="Type of address"/>
      <subfield code="j" repeat="R" desc="Specialized telephone number"/>
      <subfield code="k" repeat="R" desc="Telephone number"/>
      <subfield code="l" repeat="R" desc="Fax number"/>
      <subfield code="m" repeat="R" desc="Electronic mail address"/>
      <subfield code="n" repeat="R" desc="TDD or TTY number"/>
      <subfield code="p" repeat="R" desc="Contact person"/>
      <subfield code="q" repeat="R" desc="Title of contact person"/>
      <subfield code="r" repeat="R" desc="Hours"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="300" repeat="R" desc="Physical description">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Extent"/>
      <subfield code="b" repeat="NR" desc="Other physical details"/>
      <subfield code="c" repeat="R" desc="Dimensions"/>
      <subfield code="e" repeat="NR" desc="Accompanying material"/>
      <subfield code="f" repeat="R" desc="Type of unit"/>
      <subfield code="g" repeat="R" desc="Size of unit"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <rule context="*:datafield[@tag = '300' and  matches(substring(../*:leader, 7, 1), '[at]') and
      matches(substring(../*:leader, 8, 1), '[am]')]">
        <let name="record001" value="../*:controlfield[@tag = '001']"/>
        <assert test="*:subfield[@code = 'a']" role="warning"><value-of
            select="concat($record001, ' :: ')"/><value-of select="@tag"/> subfield $a is
          recommended. </assert>
        <assert test="*:subfield[@code = 'c']" role="warning"><value-of
            select="concat($record001, ' :: ')"/><value-of select="@tag"/> subfield $c is
          recommended. </assert>
      </rule>
    </datafield>
    <datafield tag="306" repeat="NR" desc="Playing time">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Playing time"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="307" repeat="R" desc="Hours, etc.">
      <ind1 values=" 8" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Hours"/>
      <subfield code="b" repeat="NR" desc="Additional information"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="310" repeat="R" desc="Current publication frequency">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Current publication frequency"/>
      <subfield code="b" repeat="NR" desc="Date of current publication frequency"/>
      <subfield code="0" repeat="NR" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="321" repeat="R" desc="Former publication frequency">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Former publication frequency"/>
      <subfield code="b" repeat="NR" desc="Dates of former publication frequency" occurs="R"/>
      <subfield code="0" repeat="NR" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="334" reoeat="R" desc="Mode of issuance">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Mode of issuance term"/>
      <subfield code="b" repeat="NR" desc="Mode of issuance code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="336" repeat="R" desc="Content type">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Content type term"/>
      <subfield code="b" repeat="R" desc="Content type code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="337" repeat="R" desc="Media type">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Media type term"/>
      <subfield code="b" repeat="R" desc="Media type code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="338" repeat="R" desc="Carrier type">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Carrier type term"/>
      <subfield code="b" repeat="R" desc="Carrier type code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="340" repeat="R" desc="Physical medium">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Material base and configuration"/>
      <subfield code="b" repeat="R" desc="Dimensions"/>
      <subfield code="c" repeat="R" desc="Materials applied to surface"/>
      <subfield code="d" repeat="R" desc="Information recording technique"/>
      <subfield code="e" repeat="R" desc="Support"/>
      <subfield code="f" repeat="R" desc="Production rate/ratio"/>
      <subfield code="g" repeat="R" desc="Color content"/>
      <subfield code="h" repeat="R" desc="Location within medium"/>
      <subfield code="i" repeat="R" desc="Technical specifications of medium"/>
      <subfield code="j" repeat="R" desc="Generation"/>
      <subfield code="k" repeat="R" desc="Layout"/>
      <subfield code="l" repeat="R" desc="Binding"/>
      <subfield code="m" repeat="R" desc="Book format"/>
      <subfield code="n" repeat="R" desc="Font size"/>
      <subfield code="o" repeat="R" desc="Polarity"/>
      <subfield code="p" repeat="R" desc="Illustrative content"/>
      <subfield code="q" repeat="R" desc="Reduction ratio designator"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="341" repeat="R" desc="Accessibility content">
      <ind1 values="01" desc="Application"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Content access mode"/>
      <subfield code="b" repeat="R" desc="Textual assistive features"/>
      <subfield code="c" repeat="R" desc="Visual assistive features"/>
      <subfield code="d" repeat="R" desc="Auditory assistive features"/>
      <subfield code="e" repeat="R" desc="Tactile assistive features"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="342" repeat="R" desc="Geospatial reference data">
      <ind1 values="01" desc="Geospatial reference dimension"/>
      <ind2 values="0-8" desc="Geospatial reference method"/>
      <subfield code="a" repeat="NR" desc="Name"/>
      <subfield code="b" repeat="NR" desc="Coordinate or distance units"/>
      <subfield code="c" repeat="NR" desc="Latitude resolution"/>
      <subfield code="d" repeat="NR" desc="Longitude resolution"/>
      <subfield code="e" repeat="R" desc="Standard parallel or oblique line latitude"/>
      <subfield code="f" repeat="R" desc="Oblique line longitude"/>
      <subfield code="g" repeat="NR" desc="Longitude of central meridian or projection center"/>
      <subfield code="h" repeat="NR" desc="Latitude of projection origin or projection center"/>
      <subfield code="i" repeat="NR" desc="False easting"/>
      <subfield code="j" repeat="NR" desc="False northing"/>
      <subfield code="k" repeat="NR" desc="Scale factor"/>
      <subfield code="l" repeat="NR" desc="Height of perspective point above surface"/>
      <subfield code="m" repeat="NR" desc="Azimuthal angle"/>
      <subfield code="o" repeat="NR" desc="Landsat number and path number"/>
      <subfield code="p" repeat="NR" desc="Zone identifier"/>
      <subfield code="q" repeat="NR" desc="Ellipsoid name"/>
      <subfield code="r" repeat="NR" desc="Semi-major axis"/>
      <subfield code="s" repeat="NR" desc="Denominator of flattening ratio"/>
      <subfield code="t" repeat="NR" desc="Vertical resolution"/>
      <subfield code="u" repeat="NR" desc="Vertical encoding method"/>
      <subfield code="v" repeat="NR" desc="Local planar, local, or other projection or grid description"/>
      <subfield code="w" repeat="NR" desc="Local planar or local georeference information"/>
      <subfield code="2" repeat="NR" desc="Reference method used"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="343" repeat="R" desc="Planar coordinate data">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Planar coordinate encoding method"/>
      <subfield code="b" repeat="NR" desc="Planar distance units"/>
      <subfield code="c" repeat="NR" desc="Abscissa resolution"/>
      <subfield code="d" repeat="NR" desc="Ordinate resolution"/>
      <subfield code="e" repeat="NR" desc="Distance resolution"/>
      <subfield code="f" repeat="NR" desc="Bearing resolution"/>
      <subfield code="g" repeat="NR" desc="Bearing units"/>
      <subfield code="h" repeat="NR" desc="Bearing reference direction"/>
      <subfield code="i" repeat="NR" desc="Bearing reference meridian"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="344" repeat="R" desc="Sound characteristics">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Type of recording"/>
      <subfield code="b" repeat="R" desc="Recording medium"/>
      <subfield code="c" repeat="R" desc="Playing speed"/>
      <subfield code="d" repeat="R" desc="Groove characteristics"/>
      <subfield code="e" repeat="R" desc="Track configuration"/>
      <subfield code="f" repeat="R" desc="Tape configuration"/>
      <subfield code="g" repeat="R" desc="Configuration of playback channels"/>
      <subfield code="h" repeat="R" desc="Special playback characteristics"/>
      <subfield code="i" repeat="R" desc="Sound content"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="345" repeat="R" desc="Projection characteristics of moving image">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Presentation format"/>
      <subfield code="b" repeat="R" desc="Projection speed"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="346" repeat="R" desc="Video characteristics">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Video format"/>
      <subfield code="b" repeat="R" desc="Broadcast standard"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="347" repeat="R" desc="Digital file characteristics">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="File type"/>
      <subfield code="b" repeat="R" desc="Encoding format"/>
      <subfield code="c" repeat="R" desc="File size"/>
      <subfield code="d" repeat="R" desc="Resolution"/>
      <subfield code="e" repeat="R" desc="Regional encoding"/>
      <subfield code="f" repeat="R" desc="Transmission speed"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="348" repeat="R" desc="Notated music characteristics">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Format of notated music term"/>
      <subfield code="b" repeat="R" desc="Format of notated music code"/>
      <subfield code="c" repeat="R" desc="Form of musical notation term"/>
      <subfield code="d" repeat="R" desc="Form of musical notation code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="351" repeat="R" desc="Organization and arrangement of materials">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Organization"/>
      <subfield code="b" repeat="R" desc="Arrangement"/>
      <subfield code="c" repeat="NR" desc="Hierarchical level"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="352" repeat="R" desc="Digital graphic representation">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Direct reference method"/>
      <subfield code="b" repeat="R" desc="Object type"/>
      <subfield code="c" repeat="R" desc="Object count"/>
      <subfield code="d" repeat="NR" desc="Row count"/>
      <subfield code="e" repeat="NR" desc="Column count"/>
      <subfield code="f" repeat="NR" desc="Vertical count"/>
      <subfield code="g" repeat="NR" desc="VPF topology level"/>
      <subfield code="i" repeat="NR" desc="Indirect reference description"/>
      <subfield code="q" repeat="R" desc="Format of the digital image"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="353" repeat="R" desc="Supplementary content characteristics">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Supplementary content term"/>
      <subfield code="b" repeat="R" desc="Supplementary content code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="355" repeat="R" desc="Security classification control">
      <ind1 values="0123458" desc="Controlled element"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Security classification"/>
      <subfield code="b" repeat="R" desc="Handling instructions"/>
      <subfield code="c" repeat="R" desc="External dissemination information"/>
      <subfield code="d" repeat="NR" desc="Downgrading or declassification event"/>
      <subfield code="e" repeat="NR" desc="Classification system"/>
      <subfield code="f" repeat="NR" desc="Country of origin code">
			<assert test="matches(., $marcCountryCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $b must match a valid country code.</assert>
		</subfield>
      <subfield code="g" repeat="NR" desc="Downgrading date"/>
      <subfield code="h" repeat="NR" desc="Declassification date"/>
      <subfield code="j" repeat="R" desc="Authorization"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="357" repeat="NR" desc="Originator dissemination control">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Originator control term"/>
      <subfield code="b" repeat="R" desc="Originating agency"/>
      <subfield code="c" repeat="R" desc="Authorized recipients of material"/>
      <subfield code="g" repeat="R" desc="Other restrictions"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="362" repeat="R" desc="Dates of publication and/or sequential designation">
      <ind1 values="01" desc="Format of date"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Dates of publication and/or sequential designation"/>
      <subfield code="z" repeat="NR" desc="Source of information"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="363" repeat="R" desc="Normalized date and sequential designation">
      <ind1 values=" 01" desc="Start/End designator"/>
      <ind2 values=" 01" desc="State of issuanceUndefined"/>
      <subfield code="a" repeat="NR" desc="First level of enumeration"/>
      <subfield code="b" repeat="NR" desc="Second level of enumeration"/>
      <subfield code="c" repeat="NR" desc="Third level of enumeration"/>
      <subfield code="d" repeat="NR" desc="Fourth level of enumeration"/>
      <subfield code="e" repeat="NR" desc="Fifth level of enumeration"/>
      <subfield code="f" repeat="NR" desc="Sixth level of enumeration"/>
      <subfield code="g" repeat="NR" desc="Alternative numbering scheme, first level of enumeration"/>
      <subfield code="h" repeat="NR" desc="Alternative numbering scheme, second level of enumeration"/>
      <subfield code="i" repeat="NR" desc="First level of chronology"/>
      <subfield code="j" repeat="NR" desc="Second level of chronology"/>
      <subfield code="k" repeat="NR" desc="Third level of chronology"/>
      <subfield code="l" repeat="NR" desc="Fourth level of chronology"/>
      <subfield code="m" repeat="NR" desc="Alternative numbering scheme, chronology"/>
      <subfield code="u" repeat="NR" desc="First level textual designation"/>
      <subfield code="v" repeat="NR" desc="First level of chronology, issuance"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="NR" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="365" repeat="R" desc="Trade price">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Price type code"/>
      <subfield code="b" repeat="NR" desc="Price amount"/>
      <subfield code="c" repeat="NR" desc="Currency code"/>
      <subfield code="d" repeat="NR" desc="Unit of pricing"/>
      <subfield code="e" repeat="NR" desc="Price note"/>
      <subfield code="f" repeat="NR" desc="Price effective from"/>
      <subfield code="g" repeat="NR" desc="Price effective until"/>
      <subfield code="h" repeat="NR" desc="Tax rate 1"/>
      <subfield code="i" repeat="NR" desc="Tax rate 2"/>
      <subfield code="j" repeat="NR" desc="ISO country code"/>
      <subfield code="k" repeat="NR" desc="MARC country code">
			<assert test="matches(., $marcCountryCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $k must match a valid MARC country code.</assert>
		</subfield>
      <subfield code="m" repeat="NR" desc="Identification of pricing entity"/>
      <subfield code="2" repeat="NR" desc="Source of price type code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="366" repeat="R" desc="Trade availability information">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Publishers' compressed title identification"/>
      <subfield code="b" repeat="NR" desc="Detailed date of publication"/>
      <subfield code="c" repeat="NR" desc="Availability status code"/>
      <subfield code="d" repeat="NR" desc="Expected next availability date"/>
      <subfield code="e" repeat="NR" desc="Note"/>
      <subfield code="f" repeat="NR" desc="Publishers' discount category"/>
      <subfield code="g" repeat="NR" desc="Date made out of print"/>
      <subfield code="j" repeat="NR" desc="ISO country code"/>
      <subfield code="k" repeat="NR" desc="MARC country code">
			<assert test="matches(., $marcCountryCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $k must match a valid MARC country code.</assert>
		</subfield>
      <subfield code="m" repeat="NR" desc="Identification of agency"/>
      <subfield code="2" repeat="NR" desc="Source of availability status code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="370" repeat="R" desc="Associated place">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="c" repeat="R" desc="Associated country"/>
      <subfield code="f" repeat="R" desc="Other associated place"/>
      <subfield code="g" repeat="R" desc="Place of origin of work"/>
      <subfield code="i" repeat="R" desc="Relationship information"/>
      <subfield code="s" repeat="NR" desc="Start period"/>
      <subfield code="t" repeat="NR" desc="End period"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="v" repeat="R" desc="Source of information"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="377" repeat="R" desc="Associated language">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" 7" desc="Source of code"/>
      <subfield code="a" repeat="R" desc="Language code"/>
      <subfield code="l" repeat="R" desc="Language term"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="380" repeat="R" desc="Form of work">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Form of work"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="381" repeat="R"
      desc="Other distinguishing characteristics of work or expression">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Other distinguishing characteristics"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="v" repeat="R" desc="Source of information"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="382" repeat="R" desc="Medium of performance">
      <ind1 values=" 01" desc="Display constant controller"/>
      <ind2 values=" 01" desc="Access control"/>
      <subfield code="a" repeat="R" desc="Medium of performance"/>
      <subfield code="b" repeat="R" desc="Soloist"/>
      <subfield code="d" repeat="R" desc="Doubling instrument"/>
      <subfield code="e" repeat="R" desc="Number of ensembles of the same type"/>
      <subfield code="n" repeat="R" desc="Number of performers of the same medium"/>
      <subfield code="p" repeat="R" desc="Alternative medium performance"/>
      <subfield code="r" repeat="NR" desc="Total number of individuals performing alongside ensembles"/>
      <subfield code="s" repeat="NR" desc="Total number of performers"/>
      <subfield code="t" repeat="NR" desc="Total number of ensembles"/>
      <subfield code="v" repeat="R" desc="Note"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="383" repeat="R" desc="Numeric designation of musical work">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Serial number"/>
      <subfield code="b" repeat="R" desc="Opus number"/>
      <subfield code="c" repeat="R" desc="Thematic index number"/>
      <subfield code="d" repeat="NR" desc="Thematic index code"/>
      <subfield code="e" repeat="NR" desc="Publisher associated with opus number"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="384" repeat="NR" desc="Key">
      <ind1 values=" 01" desc="Key type"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Key"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="385" repeat="R" desc="Audience characteristics">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Audience term"/>
      <subfield code="b" repeat="R" desc="Audience code"/>
      <subfield code="m" repeat="NR" desc="Demographic group term"/>
      <subfield code="n" repeat="NR" desc="Demographic group code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="386" repeat="R" desc="Creator/contributor characteristics">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Creator/contributor term"/>
      <subfield code="b" repeat="R" desc="Creator/contributor code"/>
      <subfield code="i" repeat="R" desc="Relationship information"/>
      <subfield code="m" repeat="NR" desc="Demographic group term"/>
      <subfield code="n" repeat="NR" desc="Demographic group code"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="388" repeat="R" desc="Time period of creation">
      <ind1 values=" 12" desc="Type of time period"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Time period of creation term"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <!-- Datafield 400 is obsolete -->
    <datafield tag="400" repeat="R" desc="Series statement/added entry — personal name (pre rda)">
      <ind1 values="013" desc="Type of personal name entry element"/>
      <ind2 values="01" desc="Pronoun represents main entry"/>
      <subfield code="a" repeat="NR" desc="Personal name"/>
      <subfield code="b" repeat="NR" desc="Numeration"/>
      <subfield code="c" repeat="R" desc="Titles and other words associated with a name"/>
      <subfield code="d" repeat="NR" desc="Dates associated with a name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="NR" desc="Volume number/sequential designation "/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number "/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number "/>
    </datafield>
    <!-- Datafield 410 is obsolete -->
    <datafield tag="410" repeat="R" desc="Series statement/added entry — corporate name (pre rda)">
      <ind1 values="012" desc="Type of corporate name entry element"/>
      <ind2 values="01" desc="Pronoun represents main entry"/>
      <subfield code="a" repeat="NR" desc="Corporate name or jurisdiction name as entry element"/>
      <subfield code="b" repeat="R" desc="Subordinate unit"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="R" desc="Date of meeting or treaty signing"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="NR" desc="Volume number/sequential designation "/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <!-- Datafield 411 is obsolete -->
    <datafield tag="411" repeat="R" desc="Series statement/added entry — meeting name (pre rda)">
      <ind1 values="012" desc="Type of meeting name entry element"/>
      <ind2 values="01" desc="Pronoun represents main entry"/>
      <subfield code="a" repeat="NR" desc="Meeting name or jurisdiction name as entry element"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="NR" desc="Date of meeting"/>
      <subfield code="e" repeat="R" desc="Subordinate unit"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Name of meeting following jurisdiction name entry element"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="NR" desc="Volume number/sequential designation "/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <!-- Datafield 440 is obsolete -->
    <datafield tag="440" repeat="R" desc="Series statement/added entry — title [obsolete]">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values="0-9" desc="Nonfiling characters"/>
      <subfield code="a" repeat="NR" desc="Title"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="v" repeat="NR" desc="Volume number/sequential designation "/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="w" repeat="R" desc="Bibliographic record control number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="490" repeat="R" desc="Series statement">
      <ind1 values="01" desc="Series tracing policy"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Series statement"/>
      <subfield code="l" repeat="NR" desc="Library of Congress call number"/>
      <subfield code="v" repeat="R" desc="Volume number/sequential designation "/>
      <!-- https://www.oclc.org/bibformats/en/4xx/490.html says $x is repeatable -->
      <subfield code="x" repeat="R" desc="International Standard Serial Number"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <pattern xmlns="http://purl.oclc.org/dsdl/schematron">
        <title>Co-constraint with 8xx</title>
        <rule context="*:datafield[@tag = '490' and @ind1 = '1']">
          <let name="record001" value="../*:controlfield[@tag = '001']"/>
          <assert test="../*:datafield[matches(@tag, '800|810|811|830')]"><value-of
              select="concat($record001, ' :: ')"/> When<value-of select="@tag"/>@ind1 = "1", a
            corresponding 8xx field is required. </assert>
        </rule>
      </pattern>
    </datafield>
    <datafield tag="500" repeat="R" desc="General note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="General note"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="501" repeat="R" desc="With note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="With note"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="502" repeat="R" desc="Dissertation note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Dissertation note"/>
      <subfield code="b" repeat="NR" desc="Degree type"/>
      <subfield code="c" repeat="NR" desc="Name of granting institution"/>
      <subfield code="d" repeat="NR" desc="Year of degree granted"/>
      <subfield code="g" repeat="R" desc="Miscellaneous information"/>
      <subfield code="o" repeat="R" desc="Dissertation identifier"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="504" repeat="R" desc="Bibliography, etc. note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Bibliography, etc. note"/>
      <subfield code="b" repeat="NR" desc="Number of references"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="505" repeat="R" desc="Formatted contents note">
      <ind1 values="0128" desc="Display constant controller"/>
      <ind2 values=" 0" desc="Level of content designation"/>
      <subfield code="a" repeat="NR" desc="Formatted contents note"/>
      <subfield code="g" repeat="R" desc="Miscellaneous information"/>
      <subfield code="r" repeat="R" desc="Statement of responsibility"/>
      <subfield code="t" repeat="R" desc="Title"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <rule context="*:datafield[@tag = '505'][@ind2 eq '0']">
        <let name="record001" value="../*:controlfield[@tag = '001']"/>
        <report test="*:subfield[matches(@code, 'a')]"><value-of select="concat($record001, ' :: ')"
            /><value-of select="@tag"/> subfield $a is not permitted in extended contents note
        </report>
      </rule>
    </datafield>
    <datafield tag="506" repeat="R" desc="Restrictions on access note">
      <ind1 values=" 01" desc="Restriction"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Terms governing access"/>
      <subfield code="b" repeat="R" desc="Jurisdiction"/>
      <subfield code="c" repeat="R" desc="Physical access provisions"/>
      <subfield code="d" repeat="R" desc="Authorized users"/>
      <subfield code="e" repeat="R" desc="Authorization"/>
      <subfield code="f" repeat="R" desc="Standard terminology for access restiction"/>
      <subfield code="g" repeat="R" desc="Availability date"/>
      <subfield code="q" repeat="NR" desc="Supplying agency"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="507" repeat="NR" desc="Scale note for graphic material">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Representative fraction of scale note"/>
      <subfield code="b" repeat="NR" desc="Remainder of scale note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="508" repeat="R" desc="Creation/production credits note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Creation/production credits note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="510" repeat="R" desc="Citation/references note">
      <ind1 values="0-4" desc="Coverage/location in source"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Name of source"/>
      <subfield code="b" repeat="NR" desc="Coverage of source"/>
      <subfield code="c" repeat="NR" desc="Location within source"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="511" repeat="R" desc="Participant or performer note">
      <ind1 values="01" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Participant or performer note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="513" repeat="R" desc="Type of report and period covered note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Type of report"/>
      <subfield code="b" repeat="NR" desc="Period covered"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="514" repeat="NR" desc="Data quality note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Attribute accuracy report"/>
      <subfield code="b" repeat="R" desc="Attribute accuracy value"/>
      <subfield code="c" repeat="R" desc="Attribute accuracy explanation"/>
      <subfield code="d" repeat="NR" desc="Logical consistency report"/>
      <subfield code="e" repeat="NR" desc="Completeness report"/>
      <subfield code="f" repeat="NR" desc="Horizontal position accuracy report"/>
      <subfield code="g" repeat="R" desc="Horizontal position accuracy value"/>
      <subfield code="h" repeat="R" desc="Horizontal position accuracy explanation"/>
      <subfield code="i" repeat="NR" desc="Vertical positional accuracy report"/>
      <subfield code="j" repeat="R" desc="Vertical positional accuracy value"/>
      <subfield code="k" repeat="R" desc="Vertical positional accuracy explanation"/>
      <subfield code="m" repeat="NR" desc="Cloud cover"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="z" repeat="R" desc="Display note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="515" repeat="R" desc="Numbering peculiarities note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Numbering peculiarities note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="516" repeat="R" desc="Type of computer file or data note">
      <ind1 values=" 8" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Type of computer file or data note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="518" repeat="R" desc="Date/time and place of an event note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Date/time and place of an event note"/>
      <subfield code="d" repeat="R" desc="Date of event"/>
      <subfield code="o" repeat="R" desc="Other event information"/>
      <subfield code="p" repeat="R" desc="Place of event"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="R" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="520" repeat="R" desc="Summary, etc.">
      <ind1 values=" 012348" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Summary, etc. note"/>
      <subfield code="b" repeat="NR" desc="Expansion of summary note"/>
      <subfield code="c" repeat="NR" desc="Assigning agency"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="2" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="521" repeat="R" desc="Target audience note">
      <ind1 values=" 012348" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Target audience note"/>
      <subfield code="b" repeat="NR" desc="Source"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="522" repeat="R" desc="Geographic coverage note">
      <ind1 values=" 8" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Geographic coverage note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="524" repeat="R" desc="Preferred citation of described materials note">
      <ind1 values=" 8" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Preferred citation of described materials note"/>
      <subfield code="2" repeat="NR" desc="Source of schema used"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="525" repeat="R" desc="Supplement note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Supplement note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="526" repeat="R" desc="Study program information note">
      <ind1 values="08" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Program name"/>
      <subfield code="b" repeat="NR" desc="Interest level"/>
      <subfield code="c" repeat="NR" desc="Reading level"/>
      <subfield code="d" repeat="NR" desc="Title point value"/>
      <subfield code="i" repeat="NR" desc="Display text"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="530" repeat="R" desc="Additional physical form available note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Additional physical form available note"/>
      <subfield code="b" repeat="NR" desc="Availability source"/>
      <subfield code="c" repeat="NR" desc="Availability conditions"/>
      <subfield code="d" repeat="NR" desc="Order number"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="532" repeat="R" desc="Accessibility note">
      <ind1 values="0128" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Summary of accessibility"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="533" repeat="R" desc="Reproduction note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Type of reproduction"/>
      <subfield code="b" repeat="R" desc="Place of reproduction"/>
      <subfield code="c" repeat="R" desc="Agency responsible for reproduction"/>
      <subfield code="d" repeat="NR" desc="Date of reproduction"/>
      <subfield code="e" repeat="NR" desc="Physical description of reproduction"/>
      <subfield code="f" repeat="R" desc="Series statement of reproduction"/>
      <subfield code="m" repeat="R" desc="Dates and/or sequential designation of issues reproduced"/>
      <subfield code="n" repeat="R" desc="Note about reproduction"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Fixed-length data elements of reproduction"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="534" repeat="R" desc="Original version note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Main entry of original"/>
      <subfield code="b" repeat="NR" desc="Edition statement of original"/>
      <subfield code="c" repeat="NR" desc="Publication, distribution, etc. of original"/>
      <subfield code="e" repeat="NR" desc="Physical description, etc. of original"/>
      <subfield code="f" repeat="R" desc="Series statement of original"/>
      <subfield code="k" repeat="R" desc="Key title of original"/>
      <subfield code="l" repeat="NR" desc="Location of original"/>
      <subfield code="m" repeat="NR" desc="Material specific details"/>
      <subfield code="n" repeat="R" desc="Note about original"/>
      <subfield code="o" repeat="R" desc="Other resource identifier"/>
      <subfield code="p" repeat="NR" desc="Introductory phrase"/>
      <subfield code="t" repeat="NR" desc="Title statement of original"/>
      <subfield code="x" repeat="R" desc="International Standard Serial Number"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="535" repeat="R" desc="Location of originals/duplicates note">
      <ind1 values="12" desc="Additional information about custodian"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Custodian"/>
      <subfield code="b" repeat="R" desc="Postal address"/>
      <subfield code="c" repeat="R" desc="Country"/>
      <subfield code="d" repeat="R" desc="Telecommunications address"/>
      <subfield code="g" repeat="NR" desc="Repository location code"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="536" repeat="R" desc="Funding information note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Text of note"/>
      <subfield code="b" repeat="R" desc="Contract number"/>
      <subfield code="c" repeat="R" desc="Grant number"/>
      <subfield code="d" repeat="R" desc="Undifferentiated number"/>
      <subfield code="e" repeat="R" desc="Program element number"/>
      <subfield code="f" repeat="R" desc="Project number"/>
      <subfield code="g" repeat="R" desc="Task number"/>
      <subfield code="h" repeat="R" desc="Work unit number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="538" repeat="R" desc="System details note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="System details note"/>
      <subfield code="i" repeat="NR" desc="Display text"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="3" repeat="NR" desc="Materials specified "/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="539" repeat="R" desc="Fixed-length data elements of reproduction note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Type of date/publication status" occurs="R"/>
      <subfield code="b" repeat="NR" desc="Date 1/beginning date of publication" occurs="R"/>
      <subfield code="c" repeat="NR" desc="Date 2/ending date of publication" occurs="R"/>
      <subfield code="d" repeat="NR" desc="Place of publication, production, or execution" occurs="R"/>
      <subfield code="e" repeat="NR" desc="Frequency" occurs="R"/>
      <subfield code="f" repeat="NR" desc="Regularity" occurs="R"/>
      <subfield code="g" repeat="NR" desc="Form of item"/>
    </datafield>
    <datafield tag="540" repeat="R" desc="Terms governing use and reproduction note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Terms governing use and reproduction"/>
      <subfield code="b" repeat="NR" desc="Jurisdiction"/>
      <subfield code="c" repeat="NR" desc="Authorization"/>
      <subfield code="d" repeat="NR" desc="Authorized users"/>
      <subfield code="f" repeat="R" desc="Use and reproduction rights"/>
      <subfield code="g" repeat="R" desc="Availability date"/>
      <subfield code="q" repeat="NR" desc="Supplying agency"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="541" repeat="R" desc="Immediate source of acquisition note">
      <ind1 values=" 01" desc="Privacy"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Source of acquisition"/>
      <subfield code="b" repeat="NR" desc="Address"/>
      <subfield code="c" repeat="NR" desc="Method of acquisition"/>
      <subfield code="d" repeat="NR" desc="Date of acquisition"/>
      <subfield code="e" repeat="NR" desc="Accession number"/>
      <subfield code="f" repeat="NR" desc="Owner"/>
      <subfield code="h" repeat="NR" desc="Purchase price"/>
      <subfield code="n" repeat="R" desc="Extent"/>
      <subfield code="o" repeat="R" desc="Type of unit"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="542" repeat="R" desc="Information relating to copyright status">
      <ind1 values=" 01" desc="Privacy"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Personal creator"/>
      <subfield code="b" repeat="NR" desc="Personal creator death date"/>
      <subfield code="c" repeat="NR" desc="Corporate creator"/>
      <subfield code="d" repeat="R" desc="Copyright holder"/>
      <subfield code="e" repeat="R" desc="Copyright holder contact information"/>
      <subfield code="f" repeat="R" desc="Copyright statement"/>
      <subfield code="g" repeat="NR" desc="Copyright date"/>
      <subfield code="h" repeat="R" desc="Copyright renewal date"/>
      <subfield code="i" repeat="NR" desc="Publication date"/>
      <subfield code="j" repeat="NR" desc="Creation date"/>
      <subfield code="k" repeat="R" desc="Publisher"/>
      <subfield code="l" repeat="NR" desc="Copyright status"/>
      <subfield code="m" repeat="NR" desc="Publication status"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="NR" desc="Research date"/>
      <subfield code="p" repeat="R" desc="Country of publication or creation"/>
      <subfield code="q" repeat="NR" desc="Assigning agency"/>
      <subfield code="r" repeat="NR" desc="Jurisdiction of copyright assessment"/>
      <subfield code="s" repeat="NR" desc="Source of information"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="544" repeat="R" desc="Location of other archival materials note">
      <ind1 values=" 01" desc="Relationship"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Custodian"/>
      <subfield code="b" repeat="R" desc="Address"/>
      <subfield code="c" repeat="R" desc="Country"/>
      <subfield code="d" repeat="R" desc="Title"/>
      <subfield code="e" repeat="R" desc="Provenance"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="545" repeat="R" desc="Biographical or historical data">
      <ind1 values=" 01" desc="Type of data"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Biographical or historical note"/>
      <subfield code="b" repeat="NR" desc="Expansion"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="546" repeat="R" desc="Language note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Language note"/>
      <subfield code="b" repeat="R" desc="Information code or alphabet"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="547" repeat="R" desc="Former title complexity note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Former title complexity note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="550" repeat="R" desc="Issuing body note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Issuing body note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="552" repeat="R" desc="Entity and attribute information note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Entity type label"/>
      <subfield code="b" repeat="NR" desc="Entity type definition and source"/>
      <subfield code="c" repeat="NR" desc="Attribute label"/>
      <subfield code="d" repeat="NR" desc="Attribute definition and source"/>
      <subfield code="e" repeat="R" desc="Enumerated domain value"/>
      <subfield code="f" repeat="R" desc="Enumerated domain value definition and source"/>
      <subfield code="g" repeat="NR" desc="Range domain minimum and maximum"/>
      <subfield code="h" repeat="NR" desc="Codeset name and source"/>
      <subfield code="i" repeat="NR" desc="Unrepresentable domain"/>
      <subfield code="j" repeat="NR" desc="Attribute units of measurement and resolution"/>
      <subfield code="k" repeat="NR" desc="Beginning date and ending date of attribute values"/>
      <subfield code="l" repeat="NR" desc="Attribute value accuracy"/>
      <subfield code="m" repeat="NR" desc="Attribute value accuracy explanation"/>
      <subfield code="n" repeat="NR" desc="Attribute measurement frequency"/>
      <subfield code="o" repeat="R" desc="Entity and attribute overview"/>
      <subfield code="p" repeat="R" desc="Entity and attribute detail citation"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="z" repeat="R" desc="Display note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="555" repeat="R" desc="Cumulative index/finding aids note">
      <ind1 values=" 08" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Cumulative index/finding aids note"/>
      <subfield code="b" repeat="R" desc="Availability source"/>
      <subfield code="c" repeat="NR" desc="Degree of control"/>
      <subfield code="d" repeat="NR" desc="Bibliographic reference"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="556" repeat="R" desc="Information about documentation note">
      <ind1 values=" 8" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Information about documentation note"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="561" repeat="R" desc="Ownership and custodial history">
      <ind1 values=" 01" desc="Privacy"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="History"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="562" repeat="R" desc="Copy and version identification note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Identifying markings"/>
      <subfield code="b" repeat="R" desc="Copy identification"/>
      <subfield code="c" repeat="R" desc="Version identification"/>
      <subfield code="d" repeat="R" desc="Presentation format"/>
      <subfield code="e" repeat="R" desc="Number of copies"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="563" repeat="R" desc="Binding information">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Binding note"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="565" repeat="R" desc="Case file characteristics note">
      <ind1 values=" 08" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Number of cases/variables"/>
      <subfield code="b" repeat="R" desc="Name of variable"/>
      <subfield code="c" repeat="R" desc="Unit of analysis"/>
      <subfield code="d" repeat="R" desc="Universe of data"/>
      <subfield code="e" repeat="R" desc="Filing scheme or code"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="567" repeat="R" desc="Methodology note">
      <ind1 values=" 8" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Methodology note"/>
      <subfield code="b" repeat="R" desc="Controlled term"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="R" desc="Source of term"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="580" repeat="R" desc="Linking entry complexity note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Linking entry complexity note"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="581" repeat="R" desc="Publications about described materials note">
      <ind1 values=" 8" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Publications about described materials note"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="583" repeat="R" desc="Action note">
      <ind1 values=" 01" desc="Privacy"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Action"/>
      <subfield code="b" repeat="R" desc="Action identification"/>
      <subfield code="c" repeat="R" desc="Time/date of action"/>
      <subfield code="d" repeat="R" desc="Action interval"/>
      <subfield code="e" repeat="R" desc="Contingency for action"/>
      <subfield code="f" repeat="R" desc="Authorization"/>
      <subfield code="h" repeat="R" desc="Jurisdiction"/>
      <subfield code="i" repeat="R" desc="Method of action"/>
      <subfield code="j" repeat="R" desc="Site of action"/>
      <subfield code="k" repeat="R" desc="Action agent"/>
      <subfield code="l" repeat="R" desc="Status"/>
      <subfield code="n" repeat="R" desc="Extent"/>
      <subfield code="o" repeat="R" desc="Type of unit"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="584" repeat="R" desc="Accumulation and frequency of use note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Accumulation"/>
      <subfield code="b" repeat="R" desc="Frequency of use"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="585" repeat="R" desc="Exhibitions note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Exhibitions note"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="586" repeat="R" desc="Awards note">
      <ind1 values=" 8" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Awards note"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="588" repeat="R" desc="Source of description note">
      <ind1 values=" 01" desc="Display constant controller"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Source of description note"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="590" repeat="R" desc="Local note">
      <ind1 values=" 01" desc="Privacy"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Local note" occurs="M"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="591" repeat="R" desc="Local note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
    </datafield>
    <datafield tag="592" repeat="R" desc="Local note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
    </datafield>
    <datafield tag="593" repeat="R" desc="Local note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
    </datafield>
    <datafield tag="594" repeat="R" desc="Local note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
    </datafield>
    <datafield tag="595" repeat="R" desc="Local note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
    </datafield>
    <datafield tag="596" repeat="R" desc="Local note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
    </datafield>
    <datafield tag="597" repeat="R" desc="Local note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
    </datafield>
    <datafield tag="598" repeat="R" desc="Local note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
    </datafield>
    <datafield tag="599" repeat="R" desc="Differentiable local note">
      <ind1 values=" 0-9" desc="Locally defined"/>
      <ind2 values=" 0-9" desc="Locally defined"/>
      <!-- Spec says subfields not repeatable, data doesn't conform -->
      <subfield code="a" repeat="R" desc="Local note"/>
      <subfield code="b" repeat="R" desc="Local note"/>
      <subfield code="c" repeat="R" desc="Local note"/>
      <subfield code="d" repeat="R" desc="Local note"/>
      <subfield code="e" repeat="R" desc="Local note"/>
      <subfield code="f" repeat="R" desc="Local note"/>
      <subfield code="g" repeat="R" desc="Local note"/>
      <subfield code="h" repeat="R" desc="Local note"/>
      <subfield code="i" repeat="R" desc="Local note"/>
      <subfield code="j" repeat="R" desc="Local note"/>
      <subfield code="k" repeat="R" desc="Local note"/>
      <subfield code="l" repeat="R" desc="Local note"/>
      <subfield code="m" repeat="R" desc="Local note"/>
      <subfield code="n" repeat="R" desc="Local note"/>
      <subfield code="o" repeat="R" desc="Local note"/>
      <subfield code="p" repeat="R" desc="Local note"/>
      <subfield code="q" repeat="R" desc="Local note"/>
      <subfield code="r" repeat="R" desc="Local note"/>
      <subfield code="s" repeat="R" desc="Local note"/>
      <subfield code="t" repeat="R" desc="Local note"/>
      <subfield code="u" repeat="R" desc="Local note"/>
      <subfield code="v" repeat="R" desc="Local note"/>
      <subfield code="w" repeat="R" desc="Local note"/>
      <subfield code="x" repeat="R" desc="Local note"/>
      <subfield code="y" repeat="R" desc="Local note"/>
      <subfield code="z" repeat="R" desc="Local note"/>
      <subfield code="6" repeat="R" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="600" repeat="R" desc="Subject added entry — personal name">
      <ind1 values="013" desc="Type of personal name entry element"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Personal name"/>
      <subfield code="b" repeat="NR" desc="Numeration"/>
      <subfield code="c" repeat="R" desc="Titles and other words associated with a name"/>
      <subfield code="d" repeat="NR" desc="Dates associated with a name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="j" repeat="R" desc="Attribution qualifier"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Fuller form of name"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="610" repeat="R" desc="Subject added entry — corporate name">
      <ind1 values="012" desc="Type of corporate name entry element"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Corporate name or jurisdiction name as entry element"/>
      <subfield code="b" repeat="R" desc="Subordinate unit"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="R" desc="Date of meeting or treaty signing"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="611" repeat="R" desc="Subject added entry — meeting name">
      <ind1 values="012" desc="Type of meeting name entry element"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Meeting name or jurisdiction name as entry element"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="NR" desc="Date of meeting"/>
      <subfield code="e" repeat="R" desc="Subordinate unit"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="j" repeat="R" desc="Relator term"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Name of meeting following jurisdiction name entry element"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="630" repeat="R" desc="Subject added entry — uniform title">
      <ind1 values="0-9" desc="Nonfiling characters"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Uniform title"/>
      <subfield code="d" repeat="R" desc="Date of treaty signing"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="647" repeat="R" desc="Subject added entry — named event">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Named event"/>
      <subfield code="c" repeat="R" desc="Location of named event"/>
      <subfield code="d" repeat="NR" desc="Date of named event"/>
      <subfield code="g" repeat="R" desc="Miscellaneous information"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="648" repeat="R" desc="Subject added entry — chronological term">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Chronological term"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="650" repeat="R" desc="Subject added entry — topical term">
      <ind1 values=" 012" desc="Level of subject"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Topical term or geographic name as entry element"/>
      <subfield code="b" repeat="NR" desc="Topical term following geographic name as entry element"/>
      <subfield code="c" repeat="NR" desc="Location of event"/>
      <subfield code="d" repeat="NR" desc="Active dates"/>
      <subfield code="e" repeat="NR" desc="Relator term"/>
      <subfield code="g" repeat="R" desc="Miscellaneous information"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="651" repeat="R" desc="Subject added entry — geographic name">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Geographic name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="g" repeat="R" desc="Miscellaneous information"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="653" repeat="R" desc="Index term — uncontrolled">
      <ind1 values=" 012" desc="Level of index term"/>
      <ind2 values=" 0123456" desc="Type of term or name"/>
      <subfield code="a" repeat="R" desc="Uncontrolled term"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="654" repeat="R" desc="Subject added entry — faceted topical terms">
      <ind1 values=" 012" desc="Level of subject"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Focus term"/>
      <subfield code="b" repeat="R" desc="Non-focus term"/>
      <subfield code="c" repeat="R" desc="Facet/hierarchy designation"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="655" repeat="R" desc="Index term — genre/form">
      <ind1 values=" 0" desc="Type of heading"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Genre/form data or focus term"/>
      <subfield code="b" repeat="R" desc="Non-focus term"/>
      <subfield code="c" repeat="R" desc="Facet/hierarchy designation"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="656" repeat="R" desc="Index term — occupation">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values="7" desc="Source of term"/>
      <subfield code="a" repeat="NR" desc="Occupation"/>
      <subfield code="k" repeat="NR" desc="Form"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term" occurs="M"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="657" repeat="R" desc="Index term — function">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values="7" desc="Source of term"/>
      <subfield code="a" repeat="NR" desc="Function"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term" occurs="M"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="658" repeat="R" desc="Index term — curriculum objective">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Main curriculum objective"/>
      <subfield code="b" repeat="R" desc="Subordinate curriculum objective"/>
      <subfield code="c" repeat="NR" desc="Curriculum code"/>
      <subfield code="d" repeat="NR" desc="Correlation factor"/>
      <subfield code="2" repeat="NR" desc="Source of term or code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="662" repeat="R" desc="Subject added entry — hierarchical place name">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Country or larger entity"/>
      <subfield code="b" repeat="NR" desc="First-order political jurisdiction"/>
      <subfield code="c" repeat="R" desc="Intermediate political jurisdiction"/>
      <subfield code="d" repeat="NR" desc="City"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="R" desc="City subsection"/>
      <subfield code="g" repeat="R" desc="Other nonjurisdictional geographic region and feature"/>
      <subfield code="h" repeat="R" desc="Extraterrestrial area"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="690" repeat="R" desc="Local subject added entry — topical term">
      <ind1 values=" 012" desc="Level of subject"/>
      <ind2 values=" 01234567" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Topical term or geographic name as entry element"/>
      <subfield code="b" repeat="NR" desc="Topical term following geographic name as entry element"/>
      <subfield code="c" repeat="NR" desc="Location of event"/>
      <subfield code="d" repeat="NR" desc="Active dates"/>
      <subfield code="e" repeat="NR" desc="Relator term"/>
      <subfield code="g" repeat="R" desc="Miscellaneous information"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <subfield code="9" repeat="NR" desc="Special entry"/>
    </datafield>
    <datafield tag="691" repeat="R" desc="Local subject added entry — geographic name">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" 01234567" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Geographic name"/>
      <subfield code="b" repeat="NR" desc="Geographic element following geographic name"/>
      <subfield code="g" repeat="R" desc="Miscellaneous information"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <subfield code="9" repeat="NR" desc="Special entry"/>
    </datafield>
    <datafield tag="695" repeat="R" desc="Added class number">
      <ind1 values=" 012" desc="Type of edition"/>
      <ind2 values="0123459" desc="Classification scheme"/>
      <subfield code="a" repeat="NR" desc="Added class number" occurs="M"/>
      <subfield code="b" repeat="R" desc="Item number"/>
      <subfield code="e" repeat="R" desc="Heading"/>
      <subfield code="f" repeat="R" desc="Filing suffix"/>
      <subfield code="2" repeat="NR" desc="Edition number"/>
    </datafield>
    <datafield tag="696" repeat="R" desc="Local subject added entry — personal name">
      <ind1 values="013" desc="Type of personal name entry element"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Personal name"/>
      <subfield code="b" repeat="NR" desc="Numeration"/>
      <subfield code="c" repeat="R" desc="Titles and other words associated with a name"/>
      <subfield code="d" repeat="NR" desc="Dates associated with a name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="j" repeat="R" desc="Attribution qualifier"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Fuller form of name"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <subfield code="9" repeat="NR" desc="Special entry"/>
    </datafield>
    <datafield tag="697" repeat="R" desc="Local subject added entry — corporate name">
      <ind1 values="012" desc="Type of corporate name entry element"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Corporate name or jurisdiction name as entry element"/>
      <subfield code="b" repeat="R" desc="Subordinate unit"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="R" desc="Date of meeting or treaty signing"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <subfield code="9" repeat="NR" desc="Special entry"/>
    </datafield>
    <datafield tag="698" repeat="R" desc="Local subject added entry — meeting name">
      <ind1 values="012" desc="Type of meeting name entry element"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Meeting name or jurisdiction name as entry element"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="NR" desc="Date of meeting"/>
      <subfield code="e" repeat="R" desc="Subordinate unit"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="j" repeat="R" desc="Relator term"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Name of meeting following jurisdiction name entry element"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <subfield code="9" repeat="NR" desc="Special entry"/>
    </datafield>
    <datafield tag="699" repeat="R" desc="Local subject added entry — uniform title">
      <ind1 values="0-9" desc="Nonfiling characters"/>
      <ind2 values="0-7" desc="Thesaurus"/>
      <subfield code="a" repeat="NR" desc="Uniform title"/>
      <subfield code="d" repeat="R" desc="Date of treaty signing"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="v" repeat="R" desc="Form subdivision"/>
      <subfield code="x" repeat="R" desc="General subdivision"/>
      <subfield code="y" repeat="R" desc="Chronological subdivision"/>
      <subfield code="z" repeat="R" desc="Geographic subdivision"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
      <subfield code="9" repeat="NR" desc="Special entry"/>
    </datafield>
    <datafield tag="700" repeat="R" desc="Added entry — personal name">
      <ind1 values="013" desc="Type of personal name entry element"/>
      <ind2 values=" 2" desc="Type of added entry"/>
      <subfield code="a" repeat="NR" desc="Personal name"/>
      <subfield code="b" repeat="NR" desc="Numeration"/>
      <subfield code="c" repeat="R" desc="Titles and other words associated with a name"/>
      <subfield code="d" repeat="NR" desc="Dates associated with a name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="i" repeat="R" desc="Relationship information"/>
      <subfield code="j" repeat="R" desc="Attribution qualifier"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Fuller form of name"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="710" repeat="R" desc="Added entry — corporate name">
      <ind1 values="012" desc="Type of corporate name entry element"/>
      <ind2 values=" 2" desc="Type of added entry"/>
      <subfield code="a" repeat="NR" desc="Corporate name or jurisdiction name as entry element"/>
      <subfield code="b" repeat="R" desc="Subordinate unit"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="R" desc="Date of meeting or treaty signing"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="i" repeat="R" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="711" repeat="R" desc="Added entry — meeting name">
      <ind1 values="012" desc="Type of meeting name entry element"/>
      <ind2 values=" 2" desc="Type of added entry"/>
      <subfield code="a" repeat="NR" desc="Meeting name or jurisdiction name as entry element"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="NR" desc="Date of meeting"/>
      <subfield code="e" repeat="R" desc="Subordinate unit"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="i" repeat="R" desc="Relationship information"/>
      <subfield code="j" repeat="R" desc="Relator term"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Name of meeting following jurisdiction name entry element"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="720" repeat="R" desc="Added entry — uncontrolled name">
      <ind1 values=" 12" desc="Type of name"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="4" repeat="R" desc="Relator code"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="730" repeat="R" desc="Added entry — uniform title">
      <ind1 values="0-9" desc="Nonfiling characters"/>
      <ind2 values=" 2" desc="Type of added entry"/>
      <subfield code="a" repeat="NR" desc="Uniform title"/>
      <subfield code="d" repeat="R" desc="Date of treaty signing"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="i" repeat="R" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="740" repeat="R" desc="Added entry — uncontrolled related/analytical title">
      <ind1 values="0-9" desc="Nonfiling characters"/>
      <ind2 values=" 2" desc="Type of added entry"/>
      <subfield code="a" repeat="NR" desc="Uncontrolled related/analytical title"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="751" repeat="R" desc="Added entry — geographic name">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Geographic name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="752" repeat="R" desc="Added entry — hierarchical place name">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Country or larger entity"/>
      <subfield code="b" repeat="NR" desc="First-order political jurisdiction"/>
      <subfield code="c" repeat="NR" desc="Intermediate political jurisdiction"/>
      <subfield code="d" repeat="NR" desc="City"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="R" desc="City subsection"/>
      <subfield code="g" repeat="R" desc="Other nonjurisdictional geographic region and feature"/>
      <subfield code="h" repeat="R" desc="Extraterrestrial area"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="753" repeat="R" desc="System details access to computer files">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Make and model of machine"/>
      <subfield code="b" repeat="NR" desc="Programming language"/>
      <subfield code="c" repeat="NR" desc="Operating system"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="754" repeat="R" desc="Added entry — taxonomic identification">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Taxonomic name"/>
      <subfield code="c" repeat="R" desc="Taxonomic category"/>
      <subfield code="d" repeat="R" desc="Common or alternative name"/>
      <subfield code="x" repeat="R" desc="Non-public note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of taxonomic identification"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="758" repeat="R" desc="Resource identifier">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Label"/>
      <subfield code="i" repeat="R" desc="Relationship information"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="760" repeat="R" desc="Main series entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="762" repeat="R" desc="Subseries entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="765" repeat="R" desc="Original language entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="767" repeat="R" desc="Translation entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="770" repeat="R" desc="Supplement/special issue entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="772" repeat="R" desc="Supplement parent entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 08" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Stan dard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="773" repeat="R" desc="Host item entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="p" repeat="NR" desc="Abbreviated title"/>
      <subfield code="q" repeat="NR" desc="Enumeration and first page"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="774" repeat="R" desc="Constituent unit entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="775" repeat="R" desc="Other edition entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="e" repeat="NR" desc="Language code"/>
      <subfield code="f" repeat="NR" desc="Country code"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="776" repeat="R" desc="Additional physical form entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="777" repeat="R" desc="Issued with entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="780" repeat="R" desc="Preceding entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values="0-7" desc="Type of relationship"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="785" repeat="R" desc="Succeeding entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values="0-8" desc="Type of relationship"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standa rd Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="786" repeat="R" desc="Data source entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="j" repeat="NR" desc="Period of content"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="p" repeat="NR" desc="Abbreviated title"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="v" repeat="NR" desc="Source Contribution"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="787" repeat="R" desc="Nonspecific relationship entry">
      <ind1 values="01" desc="Note controller"/>
      <ind2 values=" 8" desc="Display constant controller"/>
      <subfield code="a" repeat="NR" desc="Main entry heading"/>
      <subfield code="b" repeat="NR" desc="Edition"/>
      <subfield code="c" repeat="NR" desc="Qualifying information"/>
      <subfield code="d" repeat="NR" desc="Place, publisher, and date of publication"/>
      <subfield code="g" repeat="R" desc="Relationship information"/>
      <subfield code="h" repeat="NR" desc="Physical description"/>
      <subfield code="i" repeat="NR" desc="Relationship information"/>
      <subfield code="k" repeat="R" desc="Series data for related item"/>
      <subfield code="m" repeat="NR" desc="Material-specific details"/>
      <subfield code="n" repeat="R" desc="Note"/>
      <subfield code="o" repeat="R" desc="Other item identifier"/>
      <subfield code="r" repeat="R" desc="Report number"/>
      <subfield code="s" repeat="NR" desc="Uniform title"/>
      <subfield code="t" repeat="NR" desc="Title"/>
      <subfield code="u" repeat="NR" desc="Standard Technical Report Number"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="y" repeat="NR" desc="CODEN designation"/>
      <subfield code="z" repeat="R" desc="International Standard Book Number"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="800" repeat="R" desc="Series added entry — personal name">
      <ind1 values="013" desc="Type of personal name entry element"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Personal name"/>
      <subfield code="b" repeat="NR" desc="Numeration"/>
      <subfield code="c" repeat="R" desc="Titles and other words associated with a name"/>
      <subfield code="d" repeat="NR" desc="Dates associated with a name"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="j" repeat="R" desc="Attribution qualifier"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work "/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Fuller form of name"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="NR" desc="Volume/sequential designation "/>
      <subfield code="w" repeat="R" desc="Bibliographic record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="810" repeat="R" desc="Series added entry — corporate name">
      <ind1 values="012" desc="Type of corporate name entry element"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Corporate name or jurisdiction name as entry element"/>
      <subfield code="b" repeat="R" desc="Subordinate unit"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="R" desc="Date of meeting or treaty signing"/>
      <subfield code="e" repeat="R" desc="Relator term"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="NR" desc="Volume/sequential designation"/>
      <subfield code="w" repeat="R" desc="Bibliographic record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="811" repeat="R" desc="Series added entry — meeting name">
      <ind1 values="012" desc="Type of meeting name entry element"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Meeting name or jurisdiction name as entry element"/>
      <subfield code="c" repeat="NR" desc="Location of meeting"/>
      <subfield code="d" repeat="NR" desc="Date of meeting"/>
      <subfield code="e" repeat="R" desc="Subordinate unit"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="j" repeat="R" desc="Relator term"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="n" repeat="R" desc="Number of part/section/meeting"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="q" repeat="NR" desc="Name of meeting following jurisdiction name entry element"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="u" repeat="NR" desc="Affiliation"/>
      <subfield code="v" repeat="NR" desc="Volume/sequential designation"/>
      <subfield code="w" repeat="R" desc="Bibliographic record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="830" repeat="R" desc="Series added entry — uniform title">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values="0-9" desc="Nonfiling characters"/>
      <subfield code="a" repeat="NR" desc="Uniform title"/>
      <subfield code="d" repeat="R" desc="Date of treaty signing"/>
      <subfield code="f" repeat="NR" desc="Date of a work"/>
      <subfield code="g" repeat="NR" desc="Miscellaneous information"/>
      <subfield code="h" repeat="NR" desc="Medium"/>
      <subfield code="k" repeat="R" desc="Form subheading"/>
      <subfield code="l" repeat="NR" desc="Language of a work"/>
      <subfield code="m" repeat="R" desc="Medium of performance for music"/>
      <subfield code="n" repeat="R" desc="Number of part/section of a work"/>
      <subfield code="o" repeat="NR" desc="Arranged statement for music"/>
      <subfield code="p" repeat="R" desc="Name of part/section of a work"/>
      <subfield code="r" repeat="NR" desc="Key for music"/>
      <subfield code="s" repeat="NR" desc="Version"/>
      <subfield code="t" repeat="NR" desc="Title of a work"/>
      <subfield code="v" repeat="NR" desc="Volume/sequential designation"/>
      <subfield code="w" repeat="R" desc="Bibliographic record control number"/>
      <subfield code="x" repeat="NR" desc="International Standard Serial Number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="1" repeat="R" desc="Real World Object URI"/>
      <subfield code="2" repeat="NR" desc="Source of heading or term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="4" repeat="R" desc="Relationship"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Control subfield"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <!-- Datafields 841-845 typically occur in holdings, not bibliographic records -->
    <datafield tag="841" repeat="NR" desc="Holdings coded data values">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Type of record"/>
      <subfield code="b" repeat="NR" desc="Fixed-length data elements"/>
      <subfield code="e" repeat="NR" desc="Encoding level"/>
    </datafield>
    <datafield tag="842" repeat="NR" desc="Textual physical form designator">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Textual physical form designator"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="843" repeat="R" desc="Reproduction note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Type of reproduction"/>
      <subfield code="b" repeat="R" desc="Place of reproduction"/>
      <subfield code="c" repeat="R" desc="Agency responsible for reproduction"/>
      <subfield code="d" repeat="NR" desc="Date of reproduction"/>
      <subfield code="e" repeat="NR" desc="Physical description of reproduction"/>
      <subfield code="f" repeat="R" desc="Series statement of reproduction"/>
      <subfield code="m" repeat="R" desc="Dates and/or sequential designation of issues reproduced"/>
      <subfield code="n" repeat="R" desc="Note about reproduction"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="NR" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Fixed-length data elements of reproduction"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="844" repeat="NR" desc="Name of unit">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Name of unit"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="845" repeat="R" desc="Terms governing use and reproduction note">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Terms governing use and reproduction"/>
      <subfield code="b" repeat="NR" desc="Jurisdiction"/>
      <subfield code="c" repeat="NR" desc="Authorization"/>
      <subfield code="d" repeat="NR" desc="Authorized users"/>
      <subfield code="f" repeat="R" desc="Use and reproduction rights"/>
      <subfield code="g" repeat="R" desc="Availability date"/>
      <subfield code="q" repeat="NR" desc="Supplying agency"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="2" repeat="NR" desc="Source of term"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="5" repeat="R" desc="Institution to which field applies"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="850" repeat="R" desc="Holding institution">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Holding institution"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="852" repeat="R" desc="Location">
      <ind1 values=" 012345678" desc="Shelving scheme"/>
      <ind2 values=" 012" desc="Shelving order"/>
      <subfield code="a" repeat="NR" desc="Location"/>
      <subfield code="b" repeat="R" desc="Sublocation or collection"/>
      <subfield code="c" repeat="R" desc="Shelving location"/>
      <subfield code="d" repeat="R" desc="Former shelving location"/>
      <subfield code="e" repeat="R" desc="Address"/>
      <subfield code="f" repeat="R" desc="Coded location qualifier"/>
      <subfield code="g" repeat="R" desc="Non-coded location qualifier"/>
      <subfield code="h" repeat="NR" desc="Classification part"/>
      <subfield code="i" repeat="R" desc="Item part"/>
      <subfield code="j" repeat="NR" desc="Shelving control number"/>
      <subfield code="k" repeat="R" desc="Call number prefix"/>
      <subfield code="l" repeat="NR" desc="Shelving form of title"/>
      <subfield code="m" repeat="R" desc="Call number suffix"/>
      <subfield code="n" repeat="NR" desc="Country code">
			<assert test="matches(., $marcCountryCodes)"><value-of select="concat('Datafield ', ../@tag)"/> subfield $n must match a valid MARC country code.</assert>
		</subfield>
      <subfield code="p" repeat="NR" desc="Piece designation"/>
      <subfield code="q" repeat="NR" desc="Piece physical condition"/>
      <subfield code="s" repeat="R" desc="Copyright article-fee code"/>
      <subfield code="t" repeat="NR" desc="Copy number"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="2" repeat="NR" desc="Source of classification or shelving scheme"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="NR" desc="Sequence number"/>
    </datafield>
    <!-- Datafields 853-855 typically occur in holdings, not bibliographic records -->
    <datafield tag="853" repeat="R" desc="Captions and pattern — basic bibliographic unit">
      <ind1 values="0123" desc="Compressibility and expandability"/>
      <ind2 values="0123" desc="Caption evaluation"/>
      <subfield code="a" repeat="NR" desc="First level of enumeration"/>
      <subfield code="b" repeat="NR" desc="Second level of enumeration"/>
      <subfield code="c" repeat="NR" desc="Third level of enumeration"/>
      <subfield code="d" repeat="NR" desc="Fourth level of enumeration"/>
      <subfield code="e" repeat="NR" desc="Fifth level of enumeration"/>
      <subfield code="f" repeat="NR" desc="Sixth level of enumeration"/>
      <subfield code="g" repeat="NR" desc="Alternative numbering scheme, first level of enumeration"/>
      <subfield code="h" repeat="NR" desc="Alternative numbering scheme, second level of enumeration"/>
      <subfield code="i" repeat="NR" desc="First level of chronology"/>
      <subfield code="j" repeat="NR" desc="Second level of chronology"/>
      <subfield code="k" repeat="NR" desc="Third level of chronology"/>
      <subfield code="l" repeat="NR" desc="Fourth level of chronology"/>
      <subfield code="m" repeat="NR" desc="Alternative numbering scheme, chronology"/>
      <subfield code="n" repeat="NR" desc="Pattern note"/>
      <subfield code="p" repeat="NR" desc="Number of pieces per issuance"/>
      <subfield code="u" repeat="R" desc="Bibliographic units per next higher level"/>
      <subfield code="v" repeat="R" desc="Numbering continuity"/>
      <subfield code="w" repeat="NR" desc="Frequency"/>
      <subfield code="x" repeat="NR" desc="Calendar change"/>
      <subfield code="y" repeat="R" desc="Regularity pattern"/>
      <subfield code="z" repeat="R" desc="Numbering scheme"/>
      <subfield code="o" repeat="R" desc="Type of unit"/>
      <subfield code="t" repeat="NR" desc="Cp[u"/>
      <subfield code="2" repeat="R" desc="Source of caption abbreviation"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="NR" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="854" repeat="R" desc="Captions and pattern — supplementary material">
      <ind1 values="0123" desc="Compressibility and expandability"/>
      <ind2 values="0123" desc="Caption evaluation"/>
      <subfield code="a" repeat="NR" desc="First level of enumeration"/>
      <subfield code="b" repeat="NR" desc="Second level of enumeration"/>
      <subfield code="c" repeat="NR" desc="Third level of enumeration"/>
      <subfield code="d" repeat="NR" desc="Fourth level of enumeration"/>
      <subfield code="e" repeat="NR" desc="Fifth level of enumeration"/>
      <subfield code="f" repeat="NR" desc="Sixth level of enumeration"/>
      <subfield code="g" repeat="NR" desc="Alternative numbering scheme, first level of enumeration"/>
      <subfield code="h" repeat="NR" desc="Alternative numbering scheme, second level of enumeration"/>
      <subfield code="i" repeat="NR" desc="First level of chronology"/>
      <subfield code="j" repeat="NR" desc="Second level of chronology"/>
      <subfield code="k" repeat="NR" desc="Third level of chronology"/>
      <subfield code="l" repeat="NR" desc="Fourth level of chronology"/>
      <subfield code="m" repeat="NR" desc="Alternative numbering scheme, chronology"/>
      <subfield code="n" repeat="NR" desc="Pattern note"/>
      <subfield code="p" repeat="NR" desc="Number of pieces per issuance"/>
      <subfield code="u" repeat="R" desc="Bibliographic units per next higher level"/>
      <subfield code="v" repeat="R" desc="Numbering continuity"/>
      <subfield code="w" repeat="NR" desc="Frequency"/>
      <subfield code="x" repeat="NR" desc="Calendar change"/>
      <subfield code="y" repeat="R" desc="Regularity pattern"/>
      <subfield code="z" repeat="R" desc="Numbering scheme"/>
      <subfield code="o" repeat="R" desc="Type of unit"/>
      <subfield code="t" repeat="NR" desc="Cp[u"/>
      <subfield code="2" repeat="R" desc="Source of caption abbreviation"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="NR" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="855" repeat="R" desc="Captions and pattern — indexes">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="First level of enumeration"/>
      <subfield code="b" repeat="NR" desc="Second level of enumeration"/>
      <subfield code="c" repeat="NR" desc="Third level of enumeration"/>
      <subfield code="d" repeat="NR" desc="Fourth level of enumeration"/>
      <subfield code="e" repeat="NR" desc="Fifth level of enumeration"/>
      <subfield code="f" repeat="NR" desc="Sixth level of enumeration"/>
      <subfield code="g" repeat="NR" desc="Alternative numbering scheme, first level of enumeration"/>
      <subfield code="h" repeat="NR" desc="Alternative numbering scheme, second level of enumeration"/>
      <subfield code="i" repeat="NR" desc="First level of chronology"/>
      <subfield code="j" repeat="NR" desc="Second level of chronology"/>
      <subfield code="k" repeat="NR" desc="Third level of chronology"/>
      <subfield code="l" repeat="NR" desc="Fourth level of chronology"/>
      <subfield code="m" repeat="NR" desc="Alternative numbering scheme, chronology"/>
      <subfield code="n" repeat="NR" desc="Pattern note"/>
      <subfield code="p" repeat="NR" desc="Number of pieces per issuance"/>
      <subfield code="u" repeat="R" desc="Bibliographic units per next higher level"/>
      <subfield code="v" repeat="R" desc="Numbering continuity"/>
      <subfield code="w" repeat="NR" desc="Frequency"/>
      <subfield code="x" repeat="NR" desc="Calendar change"/>
      <subfield code="y" repeat="R" desc="Regularity pattern"/>
      <subfield code="z" repeat="R" desc="Numbering scheme"/>
      <subfield code="o" repeat="R" desc="Type of unit"/>
      <subfield code="t" repeat="NR" desc="Cp[u"/>
      <subfield code="2" repeat="R" desc="Source of caption abbreviation"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="NR" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="856" repeat="R" desc="Electronic location and access">
      <ind1 values=" 012347" desc="Access method"/>
      <ind2 values=" 012348" desc="Relationship"/>
      <subfield code="a" repeat="R" desc="Host name"/>
      <subfield code="b" repeat="R" desc="Access number"/>
      <subfield code="c" repeat="R" desc="Compression information"/>
      <subfield code="d" repeat="R" desc="Path"/>
      <subfield code="e" repeat="R" desc="Data provenance"/>
      <subfield code="f" repeat="R" desc="Electronic name"/>
      <subfield code="g" repeat="R" desc="Persistent identifier"/>
      <subfield code="h" repeat="R" desc="Processor of request"/>
      <subfield code="i" repeat="R" desc="Instruction"/>
      <subfield code="j" repeat="R" desc="Bits per second"/>
      <subfield code="k" repeat="R" desc="Password"/>
      <subfield code="l" repeat="R" desc="Logon"/>
      <subfield code="m" repeat="R" desc="Contact for access assistance"/>
      <subfield code="n" repeat="R" desc="Name of location of host"/>
      <subfield code="o" repeat="NR" desc="Operating system"/>
      <subfield code="p" repeat="NR" desc="Port"/>
      <subfield code="q" repeat="R" desc="Electronic format type"/>
      <subfield code="r" repeat="R" desc="Settings"/>
      <subfield code="s" repeat="R" desc="File size"/>
      <subfield code="t" repeat="R" desc="Terminal emulation"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier" occurs="R"/>
      <subfield code="v" repeat="R" desc="Hours access method available"/>
      <subfield code="w" repeat="R" desc="Record control number"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="y" repeat="R" desc="Link text"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="2" repeat="NR" desc="Access method"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="7" repeat="NR" desc="Access status"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <!-- Datafields 863-878 do not occur in bibliographic records -->
    <datafield tag="863" repeat="R" desc="Enumeration and chronology — basic bibliographic unit">
      <ind1 values=" 345" desc="Field encoding level" repeat=""/>
      <ind2 values=" 01234" desc="Form of holdings" repeat=""/>
      <subfield code="a" desc="First level of enumeration" repeat="NR"/>
      <subfield code="b" desc="Second level of enumeration" repeat="NR"/>
      <subfield code="c" desc="Third level of enumeration" repeat="NR"/>
      <subfield code="d" desc="Fourth level of enumeration" repeat="NR"/>
      <subfield code="e" desc="Fifth level of enumeration" repeat="NR"/>
      <subfield code="f" desc="Sixth level of enumeration" repeat="NR"/>
      <subfield code="g" desc="Alternative numbering scheme, first level of enumeration" repeat="NR"/>
      <subfield code="h" desc="Alternative numbering scheme, second level of enumeration" repeat="NR"/>
      <subfield code="i" desc="First level of chronology" repeat="NR"/>
      <subfield code="j" desc="Second level of chronology" repeat="NR"/>
      <subfield code="k" desc="Third level of chronology" repeat="NR"/>
      <subfield code="l" desc="Fourth level of chronology" repeat="NR"/>
      <subfield code="m" desc="Alternative numbering scheme, chronology" repeat="NR"/>
      <subfield code="v" desc="Issuing date" repeat="R"/>
      <subfield code="n" desc="Converted Gregorian year" repeat="NR"/>
      <subfield code="o" desc="Title of unit" repeat="R"/>
      <subfield code="p" desc="Piece designation" repeat="NR"/>
      <subfield code="q" desc="Piece physical condition" repeat="NR"/>
      <subfield code="s" desc="Copyright article-fee code" repeat="R"/>
      <subfield code="t" desc="Copy number" repeat="NR"/>
      <subfield code="w" desc="Break indicator" repeat="NR"/>
      <subfield code="x" desc="Nonpublic note" repeat="R"/>
      <subfield code="z" desc="Public note" repeat="R"/>
      <subfield code="6" desc="Linkage" repeat="NR"/>
      <subfield code="8" desc="Field link and sequence number" repeat="NR"/>
    </datafield>
    <datafield tag="864" repeat="R" desc="Enumeration and chronology — supplementary material">
      <ind1 values=" 345" desc="Field encoding level" repeat=""/>
      <ind2 values=" 01234" desc="Form of holdings" repeat=""/>
      <subfield code="a" desc="First level of enumeration" repeat="NR"/>
      <subfield code="b" desc="Second level of enumeration" repeat="NR"/>
      <subfield code="c" desc="Third level of enumeration" repeat="NR"/>
      <subfield code="d" desc="Fourth level of enumeration" repeat="NR"/>
      <subfield code="e" desc="Fifth level of enumeration" repeat="NR"/>
      <subfield code="f" desc="Sixth level of enumeration" repeat="NR"/>
      <subfield code="g" desc="Alternative numbering scheme, first level of enumeration" repeat="NR"/>
      <subfield code="h" desc="Alternative numbering scheme, second level of enumeration" repeat="NR"/>
      <subfield code="i" desc="First level of chronology" repeat="NR"/>
      <subfield code="j" desc="Second level of chronology" repeat="NR"/>
      <subfield code="k" desc="Third level of chronology" repeat="NR"/>
      <subfield code="l" desc="Fourth level of chronology" repeat="NR"/>
      <subfield code="m" desc="Alternative numbering scheme, chronology" repeat="NR"/>
      <subfield code="v" desc="Issuing date" repeat="R"/>
      <subfield code="n" desc="Converted Gregorian year" repeat="NR"/>
      <subfield code="o" desc="Title of unit" repeat="R"/>
      <subfield code="p" desc="Piece designation" repeat="NR"/>
      <subfield code="q" desc="Piece physical condition" repeat="NR"/>
      <subfield code="s" desc="Copyright article-fee code" repeat="R"/>
      <subfield code="t" desc="Copy number" repeat="NR"/>
      <subfield code="w" desc="Break indicator" repeat="NR"/>
      <subfield code="x" desc="Nonpublic note" repeat="R"/>
      <subfield code="z" desc="Public note" repeat="R"/>
      <subfield code="6" desc="Linkage" repeat="NR"/>
      <subfield code="8" desc="Field link and sequence number" repeat="NR"/>
    </datafield>
    <datafield tag="865" repeat="R" desc="Enumeration and chronology — indexes">
      <ind1 values=" 345" desc="Field encoding level" repeat=""/>
      <ind2 values=" 01234" desc="Form of holdings" repeat=""/>
      <subfield code="a" desc="First level of enumeration" repeat="NR"/>
      <subfield code="b" desc="Second level of enumeration" repeat="NR"/>
      <subfield code="c" desc="Third level of enumeration" repeat="NR"/>
      <subfield code="d" desc="Fourth level of enumeration" repeat="NR"/>
      <subfield code="e" desc="Fifth level of enumeration" repeat="NR"/>
      <subfield code="f" desc="Sixth level of enumeration" repeat="NR"/>
      <subfield code="g" desc="Alternative numbering scheme, first level of enumeration" repeat="NR"/>
      <subfield code="h" desc="Alternative numbering scheme, second level of enumeration" repeat="NR"/>
      <subfield code="i" desc="First level of chronology" repeat="NR"/>
      <subfield code="j" desc="Second level of chronology" repeat="NR"/>
      <subfield code="k" desc="Third level of chronology" repeat="NR"/>
      <subfield code="l" desc="Fourth level of chronology" repeat="NR"/>
      <subfield code="m" desc="Alternative numbering scheme, chronology" repeat="NR"/>
      <subfield code="v" desc="Issuing date" repeat="R"/>
      <subfield code="n" desc="Converted Gregorian year" repeat="NR"/>
      <subfield code="o" desc="Title of unit" repeat="R"/>
      <subfield code="p" desc="Piece designation" repeat="NR"/>
      <subfield code="q" desc="Piece physical condition" repeat="NR"/>
      <subfield code="s" desc="Copyright article-fee code" repeat="R"/>
      <subfield code="t" desc="Copy number" repeat="NR"/>
      <subfield code="w" desc="Break indicator" repeat="NR"/>
      <subfield code="x" desc="Nonpublic note" repeat="R"/>
      <subfield code="z" desc="Public note" repeat="R"/>
      <subfield code="6" desc="Linkage" repeat="NR"/>
      <subfield code="8" desc="Field link and sequence number" repeat="NR"/>
    </datafield>
    <datafield tag="866" repeat="R" desc="Textual holdings — basic bibliographic unit">
      <ind1 values=" 345" desc="Field encoding level"/>
      <ind2 values="0127" desc="Type of notation"/>
      <subfield code="a" repeat="NR" desc="Textual holdings"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="2" repeat="NR" desc="Source of notation"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="867" repeat="R" desc="Textual holdings — supplementary material">
      <ind1 values=" 345" desc="Field encoding level"/>
      <ind2 values="0127" desc="Type of notation"/>
      <subfield code="a" repeat="NR" desc="Textual holdings"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="2" repeat="NR" desc="Source of notation"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="868" repeat="R" desc="Textual holdings — indexes">
      <ind1 values=" 345" desc="Field encoding level"/>
      <ind2 values="0127" desc="Type of notation"/>
      <subfield code="a" repeat="NR" desc="Textual holdings"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="2" repeat="NR" desc="Source of notation"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="876" repeat="R" desc="Item information — basic bibliographic unit">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Internal item number"/>
      <subfield code="b" repeat="R" desc="Invalid or conceled internal item number"/>
      <subfield code="c" repeat="R" desc="Cost"/>
      <subfield code="d" repeat="R" desc="Date acquired"/>
      <subfield code="e" repeat="R" desc="Source of acquisition"/>
      <subfield code="h" repeat="R" desc="Use restrictions"/>
      <subfield code="j" repeat="R" desc="Item status"/>
      <subfield code="l" repeat="R" desc="Temporary location"/>
      <subfield code="p" repeat="R" desc="Piece designation"/>
      <subfield code="r" repeat="R" desc="Invalid or canceled piece designation"/>
      <subfield code="t" repeat="NR" desc="Copy number"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="NR" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="877" repeat="R" desc="Item information — supplementary material">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Internal item number"/>
      <subfield code="b" repeat="R" desc="Invalid or conceled internal item number"/>
      <subfield code="c" repeat="R" desc="Cost"/>
      <subfield code="d" repeat="R" desc="Date acquired"/>
      <subfield code="e" repeat="R" desc="Source of acquisition"/>
      <subfield code="h" repeat="R" desc="Use restrictions"/>
      <subfield code="j" repeat="R" desc="Item status"/>
      <subfield code="l" repeat="R" desc="Temporary location"/>
      <subfield code="p" repeat="R" desc="Piece designation"/>
      <subfield code="r" repeat="R" desc="Invalid or canceled piece designation"/>
      <subfield code="t" repeat="NR" desc="Copy number"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="NR" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="878" repeat="R" desc="Item information — indexes">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Internal item number"/>
      <subfield code="b" repeat="R" desc="Invalid or conceled internal item number"/>
      <subfield code="c" repeat="R" desc="Cost"/>
      <subfield code="d" repeat="R" desc="Date acquired"/>
      <subfield code="e" repeat="R" desc="Source of acquisition"/>
      <subfield code="h" repeat="R" desc="Use restrictions"/>
      <subfield code="j" repeat="R" desc="Item status"/>
      <subfield code="l" repeat="R" desc="Temporary location"/>
      <subfield code="p" repeat="R" desc="Piece designation"/>
      <subfield code="r" repeat="R" desc="Invalid or canceled piece designation"/>
      <subfield code="t" repeat="NR" desc="Copy number"/>
      <subfield code="x" repeat="R" desc="Nonpublic note"/>
      <subfield code="z" repeat="R" desc="Public note"/>
      <subfield code="3" repeat="NR" desc="Materials specified"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="NR" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="880" repeat="R" desc="Alternate graphic representation">
      <!-- Field 880 should obey the rules of the field to which it is linked via its
      subfield $6 -->
      <!-- Constraints on the values of ind1 and ind2 are generated by marcDesc2schematron.xsl -->
      <!--<ind1 values=" 0-9" desc="Same as associated field"/>
    <ind2 values=" 0-9" desc="Same as associated field"/>-->
      <subfield code="a-z0-9" repeat="R" desc="Same as associated field"/>
      <subfield code="6" repeat="NR" desc="Linkage" occurs="M"/>
    </datafield>
    <datafield tag="882" repeat="NR" desc="Replacement record information">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Replacement title"/>
      <subfield code="i" repeat="R" desc="Explanatory text"/>
      <subfield code="w" repeat="R" desc="Replacement bibliographic record control number"/>
      <subfield code="6" repeat="NR" desc="Linkage"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="883" repeat="R" desc="Metadata provenance">
      <ind1 values=" 012" desc="Method of assignment"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Creation process"/>
      <subfield code="c" repeat="NR" desc="Confidence value"/>
      <subfield code="d" repeat="NR" desc="Creation date"/>
      <subfield code="q" repeat="NR" desc="Assigning or generating agency"/>
      <subfield code="x" repeat="NR" desc="Validity end date"/>
      <subfield code="u" repeat="NR" desc="Uniform Resource Identifier"/>
      <subfield code="w" repeat="R" desc="Bibliographic record control number"/>
      <subfield code="0" repeat="R" desc="Authority record control number or standard number"/>
      <subfield code="8" repeat="R" desc="Field link and sequence number"/>
    </datafield>
    <datafield tag="884" repeat="R" desc="Description conversion information">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Conversion process"/>
      <subfield code="g" repeat="NR" desc="Conversion date"/>
      <subfield code="k" repeat="NR" desc="Identifier of source metadata"/>
      <subfield code="q" repeat="NR" desc="Conversion agency"/>
      <subfield code="u" repeat="R" desc="Uniform Resource Identifier"/>
    </datafield>
    <datafield tag="886" repeat="R" desc="Foreign MARC information field">
      <ind1 values="012" desc="Type of field"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="R" desc="Tag of the foreign MARC field"/>
      <subfield code="b" repeat="R" desc="Content of the foreign MARC field"/>
      <subfield code="c" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="d" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="e" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="f" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="g" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="h" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="i" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="j" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="k" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="l" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="m" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="n" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="o" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="p" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="q" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="r" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="s" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="t" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="u" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="v" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="w" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="x" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="y" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="z" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="0" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="1" repeat="R" desc="Foreign MARC subfield"/>
      <subfield code="2" repeat="R" desc="Source of data"/>
      <subfield code="3" repeat="R" desc="Source of data"/>
      <subfield code="4" repeat="R" desc="Source of data"/>
      <subfield code="5" repeat="R" desc="Source of data"/>
      <subfield code="6" repeat="R" desc="Source of data"/>
      <subfield code="7" repeat="R" desc="Source of data"/>
      <subfield code="8" repeat="R" desc="Source of data"/>
      <subfield code="9" repeat="R" desc="Source of data"/>
    </datafield>
    <datafield tag="887" repeat="R" desc="Non-MARC information field">
      <ind1 values=" " desc="Undefined"/>
      <ind2 values=" " desc="Undefined"/>
      <subfield code="a" repeat="NR" desc="Content of non-MARC field"/>
      <subfield code="2" repeat="NR" desc="Source of data"/>
    </datafield>
  </xsl:variable>

  <!-- UTILITIES / NAMED TEMPLATES -->
  <!-- Join non-repeatable subfields into a single subfield -->
  <xsl:template name="compressSubfields">
    <xsl:param name="tag"/>
    <xsl:param name="subfieldList"/>
    <!-- First subfield on the "stack" in $subfieldList -->
    <xsl:variable name="left">
      <xsl:value-of select="$subfieldList//*:subfield[1]/@code"/>
    </xsl:variable>
    <!-- Repeatability of the first subfield -->
    <xsl:variable name="repeat">
      <xsl:value-of
        select="$marcDatafieldDesc//*:datafield[@tag = $tag]/*:subfield[@code = $left]/@repeat"/>
    </xsl:variable>
    <xsl:choose>
      <!-- Non-repeatable subfield -->
      <xsl:when test="$repeat = 'NR'">
        <subfield>
          <xsl:attribute name="code">
            <xsl:value-of select="$left"/>
          </xsl:attribute>
          <xsl:variable name="separator">
            <xsl:choose>
              <xsl:when test="$subfieldList//*:subfield[@code = $left][matches(normalize-space(.), '[\.,;:/]$')]">
                <xsl:text>&#32;</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>;&#32;</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:value-of select="string-join($subfieldList//*:subfield[@code = $left], $separator)"/>
        </subfield>
      </xsl:when>
      <!-- Repeatable subfield -->
      <xsl:otherwise>
        <subfield>
          <xsl:attribute name="code">
            <xsl:value-of select="$left"/>
          </xsl:attribute>
          <xsl:value-of select="$subfieldList//*:subfield[1]"/>
        </subfield>
      </xsl:otherwise>
    </xsl:choose>
    <!-- Adjust list of remaining subfields based on repeatability of the subfield just processed -->
    <xsl:variable name="remainingSubfields">
      <xsl:choose>
        <xsl:when test="$repeat = 'NR'">
          <xsl:copy-of select="$subfieldList//*:subfield[position() &gt; 1 and @code != $left]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="$subfieldList//*:subfield[position() &gt; 1]"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- If there are subfields remaining, recurse -->
    <xsl:if test="$remainingSubfields//*:subfield">
      <xsl:call-template name="compressSubfields">
        <xsl:with-param name="tag">
          <xsl:value-of select="$tag"/>
        </xsl:with-param>
        <xsl:with-param name="subfieldList">
          <xsl:copy-of select="$remainingSubfields"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Create 008 based on type of material -->
  <xsl:template name="materialSpecific008">
    <xsl:choose>
      <!-- BK -->
      <xsl:when
        test="matches(substring(../*:leader, 7, 1), '[at]') and matches(substring(../*:leader, 8, 1), '[acdm]')">
        <xsl:variable name="illus">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 19, 4), '\p{Zs}{4}|\|{4}|[a-mop]{4}|[a-mop]{3}\p{Zs}|[a-mop]{2}\p{Zs}{2}|[a-mop]\p{Zs}{3}')">
              <xsl:value-of select="replace(substring(., 19, 4), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 19, 4), '[a-mop]')">
              <xsl:variable name="codes">
                <xsl:value-of select="replace(substring(., 19, 4), '[^a-mop]', '')"/>
              </xsl:variable>
              <xsl:value-of select="substring(concat($codes, '&#32;&#32;&#32;&#32;'), 1, 4)"/>
            </xsl:when>
            <!-- Fill with 'no attempt to code' value -->
            <xsl:otherwise>
              <xsl:text>||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="audience">
          <xsl:choose>
            <!-- Keep compliant value -->
            <xsl:when test="matches(substring(., 23, 1), '[\p{Zs}a-gj\|]')">
              <xsl:value-of select="replace(substring(., 23, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Fill with 'no attempt to code' value -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <xsl:when test="matches(substring(., 24, 1), '[\p{Zs}a-dfoqrs\|]')">
              <xsl:value-of select="replace(substring(., 24, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="contentNature">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 25, 4), '[a-gij-wyz256]{4}|\|{4}|\p{Zs}{4}|[a-gij-wyz256]{3}(\p{Zs}|\|)|[a-gij-wyz256]{2}(\p{Zs}{2}|\|{2})|[a-gij-wyz256](\p{Zs}{3}|\|{3})')">
              <xsl:value-of select="replace(substring(., 25, 4), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 25, 4), '[a-gij-wyz256]')">
              <xsl:variable name="codes">
                <xsl:value-of select="replace(substring(., 25, 4), '[^a-gij-wyz256]', '')"/>
              </xsl:variable>
              <xsl:value-of select="substring(concat($codes, '&#32;&#32;&#32;&#32;'), 1, 4)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <xsl:when test="matches(substring(., 29, 1), '[\p{Zs}acfilmosuz\|]')">
              <xsl:value-of select="replace(substring(., 29, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="confPub">
          <xsl:choose>
            <xsl:when test="matches(substring(., 30, 1), '[01\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 30, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="festschrift">
          <xsl:choose>
            <xsl:when test="matches(substring(., 31, 1), '[01\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 31, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="index">
          <xsl:choose>
            <xsl:when test="matches(substring(., 32, 1), '[01\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 32, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef33">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="litForm">
          <xsl:choose>
            <!-- Purported to be non-fiction -->
            <xsl:when test="matches(substring(., 34, 1), '0')">
              <xsl:choose>
                <!-- When classed in "P" and no 6xx fields, mark as fiction -->
                <xsl:when
                  test="../*:datafield[matches(@tag, '999')]/*:subfield[@code = 'a'][matches(., '^P')] and not(../*:datafield[matches(@tag, '^6')])">
                  <text>1</text>
                </xsl:when>
                <!-- Retain non-fiction designation -->
                <xsl:otherwise>
                  <text>0</text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <!-- Purported to be fiction -->
            <xsl:when test="matches(substring(., 34, 1), '1')">
              <xsl:choose>
                <!-- When not classed in "P" and 6xx fields are present, mark as non-fiction -->
                <xsl:when
                  test="not(../*:datafield[matches(@tag, '999')]/*:subfield[@code = 'a'][matches(., '^P')]) and ../*:datafield[matches(@tag, '^6')]">
                  <text>0</text>
                </xsl:when>
                <!-- Retain fiction designation -->
                <xsl:otherwise>
                  <text>1</text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <!-- Pass through specific litForm values -->
            <xsl:when test="matches(substring(., 34, 1), '[defhijmpsu\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 34, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- "No attempt to code" default value -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="biography">
          <xsl:choose>
            <xsl:when test="matches(substring(., 35, 1), '[\p{Zs}a-d\|]')">
              <xsl:value-of select="replace(substring(., 35, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:value-of
          select="concat($illus, $audience, $itemForm, $contentNature, $govPub, $confPub, $festschrift, $index, $undef33, $litForm, $biography)"
        />
      </xsl:when>
      <!-- CF -->
      <xsl:when test="matches(substring(../*:leader, 7, 1), '[m]')">
        <xsl:variable name="undef19">
          <xsl:text>||||</xsl:text>
        </xsl:variable>
        <xsl:variable name="audience">
          <xsl:choose>
            <xsl:when test="matches(substring(., 23, 1), '[\p{Zs}a-gj\|]')">
              <xsl:value-of select="replace(substring(., 23, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <xsl:when test="matches(substring(., 24, 1), '[\p{Zs}oq\|]')">
              <xsl:value-of select="replace(substring(., 24, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef25">
          <xsl:text>||</xsl:text>
        </xsl:variable>
        <xsl:variable name="fileType">
          <xsl:choose>
            <xsl:when test="matches(substring(., 27, 1), '[a-jmuz\|]')">
              <xsl:value-of select="substring(., 27, 1)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef28">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <xsl:when test="matches(substring(., 29, 1), '[\p{Zs}acfilmosuz\|]')">
              <xsl:value-of select="replace(substring(., 29, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef30">
          <xsl:text>||||||</xsl:text>
        </xsl:variable>
        <xsl:value-of
          select="concat($undef19, $audience, $itemForm, $undef25, $fileType, $undef28, $govPub, $undef30)"
        />
      </xsl:when>
      <!-- MP -->
      <xsl:when test="matches(substring(../*:leader, 7, 1), '[ef]')">
        <xsl:variable name="relief">
          <xsl:choose>
            <xsl:when
              test="matches(substring(., 19, 4), '[a-gijkmz]{4}|\|{4}|\p{Zs}{4}|[a-gijkmz]{3}\p{Zs}|[a-gijkmz]{2}\p{Zs}{2}|[a-gijkmz]\p{Zs}{3}')">
              <xsl:value-of select="replace(substring(., 19, 4), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="projection">
          <xsl:choose>
            <xsl:when
              test="matches(substring(., 23, 2), '(\p{Zs}\p{Zs}|aa|ab|ac|ad|ae|af|ag|am|an|ap|au|az|ba|bb|bc|bd|be|bf|bg|bh|bi|bj|bk|bl|bo|br|bs|bu|bz|ca|cb|cc|ce|cp|cu|cz|da|db|dc|dd|de|df|dg|dh|dl|zz|\|\|)')">
              <xsl:value-of select="replace(substring(., 23, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef25">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="cartographicType">
          <xsl:choose>
            <xsl:when test="matches(substring(., 26, 1), '[a-guz\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 26, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef27">
          <xsl:text>||</xsl:text>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <xsl:when test="matches(substring(., 29, 1), '[\p{Zs}acfilmosuz\|]')">
              <xsl:value-of select="replace(substring(., 29, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <xsl:when test="matches(substring(., 30, 1), '[\p{Zs}a-dfoqrs\|]')">
              <xsl:value-of select="replace(substring(., 30, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef31">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="index">
          <xsl:choose>
            <xsl:when test="matches(substring(., 32, 1), '[01\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 32, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef33">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="specialFormat">
          <xsl:choose>
            <xsl:when
              test="matches(substring(., 34, 2), '[ejklnoprz]{2}|\|{2}|\p{Zs}{2}|[ejklnoprz]{1}\p{Zs}')">
              <xsl:value-of select="replace(substring(., 34, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:value-of
          select="concat($relief, $projection, $undef25, $cartographicType, $undef27, $govPub, $itemForm, $undef31, $index, $undef33, $specialFormat)"
        />
      </xsl:when>
      <!-- MU -->
      <xsl:when test="matches(substring(../*:leader, 7, 1), '[cdij]')">
        <xsl:variable name="compositionForm">
          <xsl:choose>
            <xsl:when
              test="matches(substring(., 19, 2), '(an|bd|bg|bl|bt|ca|cb|cc|cg|ch|cl|cn|co|cp|cr|cs|ct|cy|cz|df|dv|fg|fl|fm|ft|gm|hy|jz|mc|md|mi|mo|mp|mr|ms|mu|mz|nc|nn|op|or|ov|pg|pm|po|pp|pr|ps|pt|pv|rc|rd|rg|ri|rp|rq|sd|sg|sn|sp|st|su|sy|tc|tl|ts|uu|vi|vr|wz|za|zz|\|\||\p{Zs}\p{Zs})')">
              <xsl:value-of select="replace(substring(., 19, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="musicFormat">
          <xsl:choose>
            <xsl:when test="matches(substring(., 21, 1), '[a-eg-npuz\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 21, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="musicParts">
          <xsl:choose>
            <xsl:when test="matches(substring(., 22, 1), '[\p{Zs}defnu\|]')">
              <xsl:value-of select="replace(substring(., 22, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="audience">
          <xsl:choose>
            <xsl:when test="matches(substring(., 23, 1), '[\p{Zs}a-gj\|]')">
              <xsl:value-of select="replace(substring(., 23, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <xsl:when test="matches(substring(., 24, 1), '[\p{Zs}a-dfoqrs\|]')">
              <xsl:value-of select="replace(substring(., 24, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="accMatter">
          <xsl:choose>
            <xsl:when
              test="matches(substring(., 25, 6), '[a-ikrsz]{6}|[\p{Zs}\|]{6}|[a-ikrsz]{5}[\p{Zs}\|]|[a-ikrsz]{4}[\p{Zs}\|]{2}|[a-ikrsz]{3}[\p{Zs}\|]{3}|[a-ikrsz]{2}[\p{Zs}\|]{4}|[a-ikrsz][\p{Zs}\|]{5}')">
              <xsl:value-of select="replace(substring(., 25, 6), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>||||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="literaryText">
          <xsl:choose>
            <xsl:when
              test="matches(substring(., 31, 2), '[a-prstz]{2}|\|{2}|\p{Zs}{2}|[a-prstz]\p{Zs}')">
              <xsl:value-of select="replace(substring(., 31, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef33">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="transpoArrangement">
          <xsl:choose>
            <xsl:when test="matches(substring(., 34, 1), '[\p{Zs}abcnu\|]')">
              <xsl:value-of select="replace(substring(., 34, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef35">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:value-of
          select="concat($compositionForm, $musicFormat, $musicParts, $audience, $itemForm, $accMatter, $literaryText, $undef33, $transpoArrangement, $undef35)"
        />
      </xsl:when>
      <!-- CR -->
      <xsl:when
        test="matches(substring(../*:leader, 7, 1), '[a]') and matches(substring(../*:leader, 8, 1), '[bis]')">
        <xsl:variable name="frequency">
          <xsl:choose>
            <xsl:when test="matches(substring(., 19, 1), '[\p{Zs}a-kmqstuwz\|]')">
              <xsl:value-of select="replace(substring(., 19, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="regularity">
          <xsl:choose>
            <xsl:when test="matches(substring(., 20, 1), '[nrux\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 20, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef21">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="resourceType">
          <xsl:choose>
            <xsl:when test="matches(substring(., 22, 1), '[\p{Zs}dlmnpw\|]')">
              <xsl:value-of select="replace(substring(., 22, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="originalForm">
          <xsl:choose>
            <xsl:when test="matches(substring(., 23, 1), '[\p{Zs}a-foqs\|]')">
              <xsl:value-of select="replace(substring(., 23, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <xsl:when test="matches(substring(., 24, 1), '[\p{Zs}a-dfoqrs\|]')">
              <xsl:value-of select="replace(substring(., 24, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="workNature">
          <xsl:choose>
            <xsl:when test="matches(substring(., 25, 1), '[\p{Zs}a-ik-wyz56\|]')">
              <xsl:value-of select="replace(substring(., 25, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="contentNature">
          <xsl:choose>
            <xsl:when
              test="matches(substring(., 26, 3), '[a-ik-wyz56]{3}|\|{3}|\p{Zs}{3}|[a-ik-wyz56]{2}\p{Zs}|[a-ik-wyz56]\p{Zs}{2}')">
              <xsl:value-of select="replace(substring(., 26, 3), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <xsl:when test="matches(substring(., 29, 1), '[\p{Zs}acfilmosuz\|]')">
              <xsl:value-of select="replace(substring(., 29, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="confPub">
          <xsl:choose>
            <xsl:when test="matches(substring(., 30, 1), '[01\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 30, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef31">
          <xsl:text>|||</xsl:text>
        </xsl:variable>
        <xsl:variable name="alphaScript">
          <xsl:choose>
            <xsl:when test="matches(substring(., 34, 1), '[\p{Zs}a-luz\|]')">
              <xsl:value-of select="replace(substring(., 34, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="entryConvention">
          <xsl:choose>
            <xsl:when test="matches(substring(., 35, 1), '[012\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 35, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:value-of
          select="concat($frequency, $regularity, $undef21, $resourceType, $originalForm, $itemForm, $workNature, $contentNature, $govPub, $confPub, $undef31, $alphaScript, $entryConvention)"
        />
      </xsl:when>
      <!-- VM -->
      <xsl:when test="matches(substring(../*:leader, 7, 1), '[gkor]')">
        <xsl:variable name="runningTime">
          <xsl:choose>
            <xsl:when
              test="matches(substring(., 19, 3), '(nnn|\|\|\||00[0-9]|0[1-9][0-9]|[1-9][0-9][0-9])')">
              <xsl:value-of select="substring(., 19, 3)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef22">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="audience">
          <xsl:choose>
            <xsl:when test="matches(substring(., 23, 1), '[\p{Zs}a-gj\|]')">
              <xsl:value-of select="replace(substring(., 23, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef24">
          <xsl:text>|||||</xsl:text>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <xsl:when test="matches(substring(., 29, 1), '[\p{Zs}acfilmosuz\|]')">
              <xsl:value-of select="replace(substring(., 29, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <xsl:when test="matches(substring(., 30, 1), '[\p{Zs}a-dfoqrs\|]')">
              <xsl:value-of select="replace(substring(., 30, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef31">
          <xsl:text>|||</xsl:text>
        </xsl:variable>
        <xsl:variable name="materialType">
          <xsl:choose>
            <xsl:when test="matches(substring(., 34, 1), '[a-dfgik-tvwz\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 34, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="technique">
          <xsl:choose>
            <xsl:when test="matches(substring(., 35, 1), '[aclnuz\|\p{Zs}]')">
              <xsl:value-of select="replace(substring(., 35, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:value-of
          select="concat($runningTime, $undef22, $audience, $undef24, $govPub, $itemForm, $undef31, $materialType, $technique)"
        />
      </xsl:when>
      <!-- MX -->
      <xsl:when test="matches(substring(../*:leader, 7, 1), '[p]')">
        <xsl:variable name="undef19">
          <xsl:text>|||||</xsl:text>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <xsl:when test="matches(substring(., 24, 1), '[\p{Zs}a-dfoqrs\|]')">
              <xsl:value-of select="replace(substring(., 24, 1), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef26">
          <xsl:text>|||||||||||</xsl:text>
        </xsl:variable>
        <xsl:value-of select="concat($undef19, $itemForm, $undef26)"/>
      </xsl:when>
      <!-- Unknown material -->
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Split over-long 041 subfields into multiple subfields -->
  <xsl:template name="split041subfield">
    <xsl:param name="thisValue"/>
    <xsl:variable name="thisSubfield">
      <xsl:value-of select="@code"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($thisValue) &gt; 3">
        <subfield code="{$thisSubfield}">
          <!-- Fix common incorrect value for English and Japanese -->
          <xsl:value-of select="replace(replace(replace(substring($thisValue, 1, 3), 'jap', 'jpn'), 'ing', 'eng'), 'end', 'eng')"/>
        </subfield>
        <xsl:variable name="remainder">
          <xsl:value-of select="substring($thisValue, 4)"/>
        </xsl:variable>
        <xsl:call-template name="split041subfield">
          <xsl:with-param name="thisValue">
            <xsl:value-of select="$remainder"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <subfield code="{$thisSubfield}">
          <!-- Fix common errors -->
          <xsl:value-of select="replace(replace(replace(replace($thisValue, 'jap', 'jpn'), 'ing', 'eng'), 'end', 'eng'), 'rur', 'rus')"/>
        </subfield>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- MAIN OUTPUT TEMPLATE -->
  <xsl:template match="/">
    <xsl:variable name="phase1">
      <xsl:apply-templates mode="phase1"/>
    </xsl:variable>
    <xsl:variable name="phase2">
      <xsl:apply-templates select="$phase1" mode="phase2"/>
    </xsl:variable>
    <xsl:apply-templates select="$phase2" mode="phase3"/>
  </xsl:template>

  <!-- MATCH TEMPLATES (phase 1) -->
  <xsl:template match="*:record" mode="phase1">
    <!-- Process record if there's a 999/$l not matching 'WITHDRAWN' -->
    <xsl:if
      test="*:datafield[@tag = '999'][not(*:subfield[@code = 'l'])] | *:datafield[@tag = '999']/*:subfield[@code = 'l'][not(matches(., 'WITHDRAWN'))]">
      <xsl:copy>
        <xsl:variable name="pass1">
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates select="*:leader" mode="pass1"/>
          <xsl:apply-templates select="*:controlfield[number(@tag) &lt; 8]" mode="pass1"/>
          <xsl:apply-templates select="*:controlfield[@tag = '008']" mode="pass1"/>
          <!-- If there's no 008, create a minimal one -->
          <xsl:if test="not(*:controlfield[@tag = '008'])">
            <controlfield tag="008">000000|||||||||xx |||||||||||||||||und||</controlfield>
          </xsl:if>
          <xsl:apply-templates select="*:datafield" mode="pass1"/>
        </xsl:variable>
        <xsl:variable name="pass2">
          <xsl:apply-templates select="$pass1" mode="pass2"/>
        </xsl:variable>
        <xsl:variable name="pass3">
          <xsl:apply-templates select="$pass2" mode="pass3"/>
        </xsl:variable>
        <xsl:variable name="pass4">
          <xsl:apply-templates select="$pass3" mode="pass4"/>
        </xsl:variable>
        <xsl:copy-of select="$pass4"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <!-- MATCH TEMPLATES (phase 1, pass 1) -->
  <!-- Leader -->
  <xsl:template match="*:leader" mode="pass1">
    <xsl:variable name="recordLength">
      <xsl:value-of select="substring(., 1, 5)"/>
    </xsl:variable>
    <xsl:variable name="recordStatus">
      <xsl:choose>
        <!-- Replace invalid code -->
        <xsl:when test="not(matches(substring(., 6, 1), '[acdnp]', 'i'))">n</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="lower-case(substring(., 6, 1))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="recordType">
      <xsl:choose>
        <!-- Replace invalid code -->
        <xsl:when test="not(matches(substring(., 7, 1), '[acdefgijkmoprt]', 'i'))">|</xsl:when>
        <!-- Replace inaccurate value -->
        <xsl:when test="
            (../*:datafield[@tag = '099']/*:subfield[@code = 'a'][matches(., '^(MSS |RG)', 'i')] or
            ../*:datafield[@tag = '999']/*:subfield[@code = 'a'][matches(., '^(MSS |RG)', 'i')])">
          <xsl:choose>
            <xsl:when test="matches(substring(., 7, 1), '[^pt]', 'i')">
              <xsl:value-of select="substring(., 7, 1)"/>
            </xsl:when>
            <xsl:when test="number(../*:datafield[@tag = '300'][1]/*:subfield[@code = 'a'][1]) = 1">
              <xsl:text>t</xsl:text>
            </xsl:when>
            <xsl:when
              test="number(../*:datafield[@tag = '300'][1]/*:subfield[@code = 'a'][1]) &gt; 1">
              <xsl:text>p</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="lower-case(substring(., 7, 1))"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Keep current value -->
        <xsl:otherwise>
          <xsl:value-of select="lower-case(substring(., 7, 1))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bibLevel">
      <xsl:choose>
        <!-- Replace inaccurate value -->
        <xsl:when test="
            (../*:datafield[@tag = '099']/*:subfield[@code = 'a'][matches(., '^(MSS |RG)', 'i')] or
            ../*:datafield[@tag = '999']/*:subfield[@code = 'a'][matches(., '^(MSS |RG)', 'i')])">
          <xsl:choose>
            <!-- MSS call number not collection or monograph -->
            <xsl:when test="matches(substring(., 8, 1), '[^cm]', 'i')">
              <!-- Keep the current value -->
              <xsl:value-of select="substring(., 8, 1)"/>
            </xsl:when>
            <!-- Datafield 300/$a indicates there's a single item -->
            <xsl:when test="
                number(../*:datafield[@tag = '300'][1]/*:subfield[@code = 'a'][1]) = 1 or
                number(substring-before(replace(../*:datafield[@tag = '300'][1]/*:subfield[@code = 'a'][1], '^\D*(\d)', '$1'), ' ')) = 1">
              <xsl:text>m</xsl:text>
            </xsl:when>
            <!-- Datafield 300/$a indicates there's more than 1 item -->
            <xsl:when test="
                number(../*:datafield[@tag = '300'][1]/*:subfield[@code = 'a'][1]) &gt; 1 or
                number(substring-before(replace(../*:datafield[@tag = '300'][1]/*:subfield[@code = 'a'][1], '^\D*(\d)', '$1'), ' ')) &gt; 1">
              <xsl:text>c</xsl:text>
            </xsl:when>
            <!-- Keep the current value -->
            <xsl:otherwise>
              <xsl:value-of select="lower-case(substring(., 8, 1))"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Replace invalid code -->
        <xsl:when test="not(matches(substring(., 8, 1), '[abcdims]', 'i'))">|</xsl:when>
        <!-- Keep current value -->
        <xsl:otherwise>
          <xsl:value-of select="lower-case(substring(., 8, 1))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="controlType">
      <xsl:choose>
        <!-- Set to 'a' (archival) when 040/$a = 'appm' or 'dacs' -->
        <xsl:when
          test="../*:datafield[@tag = '040']/*:subfield[@code = 'e'][matches(., '(appm|dacs)', 'i')]">
          <xsl:text>a</xsl:text>
        </xsl:when>
        <!-- Set to ' ' when 040/$a = 'aacr' or 'rda' -->
        <xsl:when
          test="../*:datafield[@tag = '040']/*:subfield[@code = 'e'][matches(., '(aacr|rda)', 'i')]">
          <xsl:text>&#32;</xsl:text>
        </xsl:when>
        <!-- Set to 'a' (archival) when 099/$a or 999/$a matches '^MSS ' -->
        <xsl:when
          test="../*:datafield[@tag = '099' or @tag = '999']/*:subfield[@code = 'a'][matches(., '^MSS ', 'i')]">
          <xsl:text>a</xsl:text>
        </xsl:when>
        <!-- Keep current value -->
        <xsl:otherwise>
          <xsl:value-of select="lower-case(substring(., 9, 1))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="charCodeScheme">
      <xsl:choose>
        <!-- Replace invalid code -->
        <xsl:when test="not(matches(substring(., 10, 1), '[\sa]', 'i'))">
          <xsl:text>a</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="lower-case(substring(., 10, 1))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- Constant -->
    <xsl:variable name="indicatorCount">
      <xsl:text>2</xsl:text>
    </xsl:variable>
    <xsl:variable name="subfieldCodeCount">
      <xsl:text>2</xsl:text>
    </xsl:variable>
    <xsl:variable name="baseAddress">
      <xsl:value-of select="substring(., 13, 5)"/>
    </xsl:variable>
    <xsl:variable name="encodingLevel">
      <xsl:choose>
        <!-- Replace l (lower-case el) with 1 (digit) -->
        <xsl:when test="matches(substring(., 18, 1), 'l')">1</xsl:when>
        <!-- Replace invalid code -->
        <xsl:when test="not(matches(substring(., 18, 1), '[\s1234578uzIJKM]', 'i'))">u</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="translate(substring(., 18, 1), 'UZijkm', 'uzIJKM')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="descriptiveForm">
      <xsl:choose>
        <!-- Replace invalid code -->
        <xsl:when test="not(matches(substring(., 19, 1), '[\sacinu]', 'i'))">u</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="lower-case(substring(., 19, 1))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="multipleResourceLevel">
      <xsl:choose>
        <!-- Replace invalid code -->
        <xsl:when test="not(matches(substring(., 20, 1), '[\sabc]', 'i'))">&#32;</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="lower-case(substring(., 20, 1))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <leader>
      <xsl:value-of select="concat($recordLength, $recordStatus, $recordType, $bibLevel, $controlType, $charCodeScheme, $indicatorCount, $subfieldCodeCount, $baseAddress, $encodingLevel, $descriptiveForm, $multipleResourceLevel, '4500')"/>
    </leader>
  </xsl:template>

  <!-- 005 -->
  <xsl:template match="*:controlfield[@tag = '005']" mode="pass1">
    <controlfield tag="005">
      <xsl:choose>
        <!-- Keep value -->
        <xsl:when test="matches(normalize-space(replace(., '[^\.\d]', '')), '^\d{14}\.\d$')">
          <xsl:value-of select="normalize-space(replace(., '[^\.\d]', ''))"/>
        </xsl:when>
        <!-- Use dummy value -->
        <xsl:otherwise>
          <xsl:text>00000000000000.0</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </controlfield>
  </xsl:template>

  <!-- 006 -->
  <xsl:template match="*:controlfield[@tag = '006']" mode="pass1">
    <xsl:choose>
      <!-- BK -->
      <xsl:when test="matches(substring(., 1, 1), '[at]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="illus">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 2, 4), '\p{Zs}{4}|\|{4}|[a-mop]{4}|[a-mop]{3}\p{Zs}|[a-mop]{2}\p{Zs}{2}|[a-mop]\p{Zs}{3}')">
              <xsl:value-of select="replace(substring(., 2, 4), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 2, 4), '[a-mop]')">
              <xsl:variable name="codes">
                <xsl:value-of select="replace(substring(., 2, 4), '[^a-mop]', '')"/>
              </xsl:variable>
              <xsl:value-of select="substring(concat($codes, '&#32;&#32;&#32;&#32;'), 1, 4)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="audience">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}a-gj\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[\p{Zs}a-dfoqrs\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="contentNature">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 8, 4), '[a-gij-wyz256]{4}|\|{4}|\p{Zs}{4}|[a-gij-wyz256]{3}(\p{Zs}|\|)|[a-gij-wyz256]{2}(\p{Zs}{2}|\|{2})|[a-gij-wyz256](\p{Zs}{3}|\|{3})')">
              <xsl:value-of select="replace(substring(., 8, 4), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 8, 4), '[a-gij-wyz256]')">
              <xsl:variable name="codes">
                <xsl:value-of select="replace(substring(., 8, 4), '[^a-gij-wyz256]', '')"/>
              </xsl:variable>
              <xsl:value-of select="substring(concat($codes, '&#32;&#32;&#32;&#32;'), 1, 4)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[\p{Zs}acfilmosuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 12, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="confPub">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 13, 1), '[01\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 13, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="festschrift">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 14, 1), '[01\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 14, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="index">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 15, 1), '[01\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 15, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef16">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="litForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 17, 1), '[01defhijmpsu\|]', 'i')">
              <xsl:value-of select="lower-case(substring(., 17, 1))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="biography">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 18, 1), '[\p{Zs}a-d\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 18, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $illus, $audience, $itemForm, $contentNature, $govPub, $confPub, $festschrift, $index, $undef16, $litForm, $biography)"/>
        </controlfield>
      </xsl:when>
      <!-- CF -->
      <xsl:when test="matches(substring(., 1, 1), '[m]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef2">
          <xsl:text>||||</xsl:text>
        </xsl:variable>
        <xsl:variable name="audience">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}a-gj\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[\p{Zs}oq\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef8">
          <xsl:text>||</xsl:text>
        </xsl:variable>
        <xsl:variable name="fileType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 10, 1), '[a-jmuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 10, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef11">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[\p{Zs}acfilmosuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 12, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef14">
          <xsl:text>||||||</xsl:text>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $undef2, $audience, $itemForm, $undef8, $fileType, $undef11, $govPub, $undef14)"/>
        </controlfield>
      </xsl:when>
      <!-- MP -->
      <xsl:when test="matches(substring(., 1, 1), '[ef]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="relief">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when
              test="matches(substring(., 2, 4), '[a-gijkmz]{4}|\|{4}|\p{Zs}{4}|[a-gijkmz]{3}\p{Zs}|[a-gijkmz]{2}\p{Zs}{2}|[a-gijkmz]\p{Zs}{3}', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 4), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 2, 4), '[a-gijkmz]', 'i')">
              <xsl:variable name="codes">
                <xsl:value-of select="lower-case(replace(substring(., 2, 4), '[^a-gijkmz]', ''))"/>
              </xsl:variable>
              <xsl:value-of select="substring(concat($codes, '&#32;&#32;&#32;&#32;'), 1, 4)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="projection">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 6, 2), '(\p{Zs}\p{Zs}|aa|ab|ac|ad|ae|af|ag|am|an|ap|au|az|ba|bb|bc|bd|be|bf|bg|bh|bi|bj|bk|bl|bo|br|bs|bu|bz|ca|cb|cc|ce|cp|cu|cz|da|db|dc|dd|de|df|dg|dh|dl|zz|\|\|)')">
              <xsl:value-of select="replace(substring(., 6, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef8">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="cartographicType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 9, 1), '[a-guz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 9, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef10">
          <xsl:text>||</xsl:text>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[\p{Zs}acfilmosuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 12, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 13, 1), '[\p{Zs}a-dfoqrs\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 13, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef14">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="index">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 15, 1), '[01\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 15, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef16">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="specialFormat">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 17, 2), '[ejklnoprz]{2}|\|{2}|\p{Zs}{2}|[ejklnoprz]{1}\p{Zs}')">
              <xsl:value-of select="replace(substring(., 17, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $relief, $projection, $undef8, $cartographicType, $undef10, $govPub, $itemForm, $undef14, $index, $undef16, $specialFormat)"/>
        </controlfield>
      </xsl:when>
      <!-- MU -->
      <xsl:when test="matches(substring(., 1, 1), '[cdij]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="compositionForm">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 2, 2), '(an|bd|bg|bl|bt|ca|cb|cc|cg|ch|cl|cn|co|cp|cr|cs|ct|cy|cz|df|dv|fg|fl|fm|ft|gm|hy|jz|mc|md|mi|mo|mp|mr|ms|mu|mz|nc|nn|op|or|ov|pg|pm|po|pp|pr|ps|pt|pv|rc|rd|rg|ri|rp|rq|sd|sg|sn|sp|st|su|sy|tc|tl|ts|uu|vi|vr|wz|za|zz|\|\||\p{Zs}\p{Zs})')">
              <xsl:value-of select="replace(substring(., 2, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="musicFormat">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[a-eg-npuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="musicParts">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[\p{Zs}defnu\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="audience">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}a-gj\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[\p{Zs}a-dfoqrs\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="accMatter">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 8, 6), '[a-ikrsz]{6}|[\p{Zs}\|]{6}|[a-ikrsz]{5}[\p{Zs}\|]|[a-ikrsz]{4}[\p{Zs}\|]{2}|[a-ikrsz]{3}[\p{Zs}\|]{3}|[a-ikrsz]{2}[\p{Zs}\|]{4}|[a-ikrsz][\p{Zs}\|]{5}')">
              <xsl:value-of select="replace(substring(., 8, 6), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 8, 6), '[a-ikrsz]')">
              <xsl:variable name="codes">
                <xsl:value-of select="replace(substring(., 8, 6), '[^a-ikrsz]', '')"/>
              </xsl:variable>
              <xsl:value-of
                select="substring(concat($codes, '&#32;&#32;&#32;&#32;&#32;&#32;'), 1, 6)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="literaryText">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 14, 2), '[a-prstz]{2}|\|{2}|\p{Zs}{2}|[a-prstz]\p{Zs}')">
              <xsl:value-of select="replace(substring(., 14, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef16">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="transpoArrangement">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 17, 1), '[\p{Zs}abcnu\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 17, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef18">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $compositionForm, $musicFormat, $musicParts, $audience, $itemForm, $accMatter, $literaryText, $undef16, $transpoArrangement, $undef18)"/>
        </controlfield>
      </xsl:when>
      <!-- CR -->
      <xsl:when test="matches(substring(., 1, 1), '[s]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="frequency">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[\p{Zs}a-kmqstuwz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="regularity">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 3, 1), '[nrux\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 3, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef4">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="resourceType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[\p{Zs}dlmnpw\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="originalForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}a-foqs\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[\p{Zs}a-dfoqrs\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="workNature">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 8, 1), '[\p{Zs}a-ik-wyz56\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 8, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="contentNature">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 9, 3), '[a-ik-wyz56]{3}|\|{3}|\p{Zs}{3}|[a-ik-wyz56]{2}\p{Zs}|[a-ik-wyz56]\p{Zs}{2}')">
              <xsl:value-of select="replace(substring(., 9, 3), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 9, 3), '[a-ik-wyz56]')">
              <xsl:variable name="codes">
                <xsl:value-of select="replace(substring(., 9, 3), '[^a-ik-wyz56]', '')"/>
              </xsl:variable>
              <xsl:value-of select="substring(concat($codes, '&#32;&#32;&#32;'), 1, 3)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[\p{Zs}acfilmosuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 12, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="confPub">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 13, 1), '[01\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 13, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef14">
          <xsl:text>|||</xsl:text>
        </xsl:variable>
        <xsl:variable name="alphaScript">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 17, 1), '[\p{Zs}a-luz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 17, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="entryConvention">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 18, 1), '[012\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 18, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $frequency, $regularity, $undef4, $resourceType, $originalForm, $itemForm, $workNature, $contentNature, $govPub, $confPub, $undef14, $alphaScript, $entryConvention)"/>
        </controlfield>
      </xsl:when>
      <!-- VM -->
      <xsl:when test="matches(substring(., 1, 1), '[gkor]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="runningTime">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 2, 3), '(nnn|\|\|\||00[0-9]|0[1-9][0-9]|[1-9][0-9][0-9])')">
              <xsl:value-of select="substring(., 2, 3)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef5">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="audience">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}a-gj\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef7">
          <xsl:text>|||||</xsl:text>
        </xsl:variable>
        <xsl:variable name="govPub">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[\p{Zs}acfilmosuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 12, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 13, 1), '[\p{Zs}a-dfoqrs\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 13, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef14">
          <xsl:text>|||</xsl:text>
        </xsl:variable>
        <xsl:variable name="materialType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 17, 1), '[a-dfgik-tvwz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 17, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="technique">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 18, 1), '[aclnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 18, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $runningTime, $undef5, $audience, $undef7, $govPub, $itemForm, $undef14, $materialType, $technique)"/>
        </controlfield>
      </xsl:when>
      <!-- MX -->
      <xsl:when test="matches(substring(., 1, 1), '[p]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef2">
          <xsl:text>|||||</xsl:text>
        </xsl:variable>
        <xsl:variable name="itemForm">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[\p{Zs}a-dfoqrs\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef8">
          <xsl:text>|||||||||||</xsl:text>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $undef2, $itemForm, $undef8)"/>
        </controlfield>
      </xsl:when>
      <!-- Unknown material; leave in place -->
      <xsl:otherwise>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </controlfield>
        <!--<xsl:variable name="recordIdentifier">
          <xsl:choose>
            <xsl:when test="../*:controlfield[@tag = '001']">
              <xsl:value-of select="../*:controlfield[@tag = '001']"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="position()"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:message>record <xsl:value-of select="$recordIdentifier"/>: Unknown value '<xsl:value-of
            select="substring(., 1, 1)"/>' in 006/00</xsl:message>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 007 -->
  <!-- Delete defective 007 -->
  <xsl:template match="*:controlfield[@tag = '007'][normalize-space(.) = 'ta']" mode="pass1"/>

  <!-- 008 -->
  <xsl:template match="*:controlfield[@tag = '008']" mode="pass1">
    <xsl:variable name="dateEntered">
      <xsl:choose>
        <!-- Codes are valid -->
        <xsl:when test="matches(substring(., 1, 6), '[0-9]{6}')">
          <xsl:value-of select="substring(., 1, 6)"/>
        </xsl:when>
        <!-- Replace non-digit w/ '0' -->
        <xsl:otherwise>
          <xsl:value-of select="replace(substring(., 1, 6), '\D', '0')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="pubStatus">
      <xsl:choose>
        <!-- Replace w/ 'unknown' -->
        <xsl:when
          test="matches(substring(., 8, 4), '[\p{Zs}u\\\|]{4}') and matches(substring(., 12, 4), '[\p{Zs}u\\\|]{4}')">
          <xsl:text>n</xsl:text>
        </xsl:when>
        <!-- Code is valid -->
        <xsl:when test="matches(substring(., 7, 1), '[bcdeikmnpqrstu\|]', 'i')">
          <xsl:value-of select="lower-case(substring(., 7, 1))"/>
        </xsl:when>
        <!-- Replace w/ 'no attempt to code' -->
        <xsl:otherwise>
          <xsl:text>|</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="date1">
      <xsl:choose>
        <!-- Codes are valid -->
        <xsl:when
          test="matches(substring(., 8, 4), '[0-9]{4}|[\p{Zs}u\\\|]{4}|[0-9\p{Zs}u\\\|]{4}', 'i')">
          <xsl:value-of select="replace(lower-case(substring(., 8, 4)), '\p{Zs}', '&#32;')"/>
        </xsl:when>
        <!-- Replace w/ 'no attempt to code' -->
        <xsl:otherwise>
          <xsl:text>||||</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="date2">
      <xsl:choose>
        <!-- Codes are valid -->
        <xsl:when
          test="matches(substring(., 12, 4), '[0-9]{4}|[\p{Zs}u\\\|]{4}|[0-9\p{Zs}u\\\|]{4}', 'i')">
          <xsl:value-of select="replace(lower-case(substring(., 12, 4)), '\p{Zs}', '&#32;')"/>
        </xsl:when>
        <!-- Replace w/ 'no attempt to code' -->
        <xsl:otherwise>
          <xsl:text>||||</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="pubPlace">
      <xsl:choose>
        <!-- Code is minimally valid -->
        <xsl:when test="matches(substring(., 16, 3), '[a-z]{2}[a-z\s]', 'i')">
          <xsl:variable name="thisValue">
            <xsl:value-of select="lower-case(substring(., 16, 3))"/>
          </xsl:variable>
          <xsl:choose>
            <!-- Fix obsolete codes -->
            <xsl:when test="$thisValue = 'ac '">at </xsl:when>
            <xsl:when test="$thisValue = 'ai '">am </xsl:when>
            <xsl:when test="$thisValue = 'air'">ai </xsl:when>
            <xsl:when test="$thisValue = 'ajr'">aj </xsl:when>
            <xsl:when test="$thisValue = 'bwr'">bw </xsl:when>
            <xsl:when test="$thisValue = 'cn '">xxc</xsl:when>
            <xsl:when test="$thisValue = 'cp '">gb </xsl:when>
            <xsl:when test="$thisValue = 'cs '">xo </xsl:when>
            <xsl:when test="$thisValue = 'cz '">pn </xsl:when>
            <xsl:when test="$thisValue = 'err'">er </xsl:when>
            <xsl:when test="$thisValue = 'ge '">gw </xsl:when>
            <xsl:when test="$thisValue = 'gn '">gb </xsl:when>
            <xsl:when test="$thisValue = 'gsr'">gs </xsl:when>
            <xsl:when test="$thisValue = 'hk '">cc </xsl:when>
            <xsl:when test="$thisValue = 'iu '">is </xsl:when>
            <xsl:when test="$thisValue = 'iw '">is </xsl:when>
            <xsl:when test="$thisValue = 'jn '">no </xsl:when>
            <xsl:when test="$thisValue = 'kgr'">kg </xsl:when>
            <xsl:when test="$thisValue = 'kzr'">kz </xsl:when>
            <xsl:when test="$thisValue = 'lir'">li </xsl:when>
            <xsl:when test="$thisValue = 'ln '">gb </xsl:when>
            <xsl:when test="$thisValue = 'lvr'">lv </xsl:when>
            <xsl:when test="$thisValue = 'mh '">cc </xsl:when>
            <xsl:when test="$thisValue = 'mvr'">mv </xsl:when>
            <xsl:when test="$thisValue = 'na '">sn </xsl:when>
            <xsl:when test="$thisValue = 'nm '">nw </xsl:when>
            <xsl:when test="$thisValue = 'pt '">em </xsl:when>
            <xsl:when test="$thisValue = 'rur'">ru </xsl:when>
            <xsl:when test="$thisValue = 'ry '">ja </xsl:when>
            <xsl:when test="$thisValue = 'sb '">no </xsl:when>
            <xsl:when test="$thisValue = 'sk '">ii </xsl:when>
            <xsl:when test="$thisValue = 'sv '">ho </xsl:when>
            <xsl:when test="$thisValue = 'tar'">ta </xsl:when>
            <xsl:when test="$thisValue = 'tkr'">tk </xsl:when>
            <xsl:when test="$thisValue = 'tt '">pw </xsl:when>
            <xsl:when test="$thisValue = 'ui '">stk</xsl:when>
            <xsl:when test="$thisValue = 'uik'">stk</xsl:when>
            <xsl:when test="$thisValue = 'uk '">xxk</xsl:when>
            <xsl:when test="$thisValue = 'unr'">un </xsl:when>
            <xsl:when test="$thisValue = 'ur '">ru </xsl:when>
            <xsl:when test="$thisValue = 'us '">xxu</xsl:when>
            <xsl:when test="$thisValue = 'uzr'">uz </xsl:when>
            <xsl:when test="$thisValue = 'vn '">vm </xsl:when>
            <xsl:when test="$thisValue = 'vs '">vm </xsl:when>
            <xsl:when test="$thisValue = 'wb '">gw </xsl:when>
            <xsl:when test="$thisValue = 'xi '">am </xsl:when>
            <xsl:when test="$thisValue = 'xxr'">ru </xsl:when>
            <xsl:when test="$thisValue = 'ys '">ye </xsl:when>
            <xsl:when test="$thisValue = 'yu '">bn </xsl:when>
            <xsl:otherwise>
              <!-- Fix common errors -->
              <xsl:value-of select="
                  replace(replace(replace(
                  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
                  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
                  $thisValue, 'mcu', 'miu'),
                  'viu', 'vau'),
                  'nku', 'nkc'),
                  'cnu', 'ctu'),
                  'iek', 'ie '),
                  'iou', 'iau'),
                  'unk', 'enk'),
                  'neu', 'nbu'),
                  'nyk', 'nyu'),
                  'guc', 'quc'),
                  'en ', 'enk'),
                  'nyc', 'nyu'),
                  'ny ', 'nyu'),
                  'ar ', 'ag '),
                  'tn ', 'tnu'),
                  'bck', 'bcc'),
                  'atk', 'at '),
                  'cnc', 'onc'),
                  'dc ', 'dcu'),
                  'nj ', 'nju'),
                  'ma ', 'mau'),
                  'en ', 'enk'),
                  'pru', 'pr ')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Replace w/ 'unknown' value -->
        <xsl:otherwise>
          <xsl:text>xx&#32;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="language">
      <xsl:choose>
        <!-- Code is minimally valid -->
        <xsl:when test="matches(substring(., 36, 3), '[a-z]{3}|\p{Zs}{3}', 'i')">
          <xsl:variable name="thisValue">
            <xsl:value-of select="lower-case(substring(., 36, 3))"/>
          </xsl:variable>
          <xsl:choose>
            <!-- Fix obsolete codes -->
            <xsl:when test="$thisValue = 'scr'">hrv</xsl:when>
            <xsl:when test="$thisValue = 'mol'">rum</xsl:when>
            <xsl:when test="$thisValue = 'scc'">srp</xsl:when>
            <xsl:otherwise>
              <!-- Fix common errors -->
              <xsl:value-of select="
                  replace(replace(replace(replace(replace(replace(replace(replace(
                  replace(replace($thisValue, 'jap', 'jpn'), 'ing', 'eng'),
                  'end', 'eng'), '\p{Zs}', '&#32;'), 'rur', 'rus'), 'enh', 'eng'),
                  'ser', 'srp'), 'cro', 'hrv'), 'scs', 'srp'), 'fle', 'dut')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Replace w/ 'unknown' value -->
        <xsl:otherwise>
          <xsl:text>&#32;&#32;&#32;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="recordMod">
      <xsl:choose>
        <!-- Code is valid -->
        <xsl:when test="matches(substring(., 39, 1), '[\p{Zs}\\\|dorsx]', 'i')">
          <xsl:value-of select="replace(lower-case(substring(., 39, 1)), '\p{Zs}', '&#32;')"/>
        </xsl:when>
        <!-- Replace w/ 'no attempt to code' -->
        <xsl:otherwise>
          <xsl:text>|</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="catalogSource">
      <xsl:choose>
        <!-- Code is valid -->
        <xsl:when test="matches(substring(., 40, 1), '[\p{Zs}\\\|cdu]', 'i')">
          <xsl:value-of select="replace(lower-case(substring(., 40, 1)), '\p{Zs}', '&#32;')"/>
        </xsl:when>
        <!-- Replace w/ 'no attempt to code' -->
        <xsl:otherwise>
          <xsl:text>|</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <controlfield>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="concat($dateEntered, $pubStatus, $date1, $date2, $pubPlace)"/>
      <xsl:call-template name="materialSpecific008"/>
      <xsl:value-of select="concat($language, $recordMod, $catalogSource)"/>
    </controlfield>
  </xsl:template>

  <!-- Delete datafields that have no subfields or no content in their subfields -->
  <xsl:template match="
      *:datafield[not(*:subfield)] |
      *:datafield[normalize-space(.) eq '']" mode="pass1"/>

  <!-- MATCH TEMPLATES (phase 1, pass 2) -->
  <!-- Join subfields where @code = ' ' to preceding subfield -->
  <xsl:template match="
      *:datafield
      [*:subfield[normalize-space(@code) = '']]" mode="pass2">
    <xsl:variable name="thisTag">
      <xsl:value-of select="@tag"/>
    </xsl:variable>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:for-each-group select="*" group-starting-with="*:subfield[normalize-space(@code) != '']">
        <xsl:for-each select="current-group()[1]">
          <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="."/>
            <xsl:for-each select="current-group()[position() &gt; 1]">
              <!-- Don't add space separator if @tag = '041' -->
              <xsl:if test="$thisTag != '041'">
                <xsl:text>&#32;</xsl:text>
              </xsl:if>
              <xsl:value-of select="."/>
            </xsl:for-each>
          </xsl:copy>
        </xsl:for-each>
      </xsl:for-each-group>
    </xsl:copy>
  </xsl:template>

  <!-- Process other 007s -->
  <xsl:template match="*:controlfield[@tag = '007']" mode="pass2">
    <xsl:choose>
      <!-- Map -->
      <xsl:when test="matches(substring(., 1, 1), '[a]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[dgjkqrsuyz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[ac\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="physMedium">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[a-gijlnp-z\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="reproType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[fnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="prodDetails">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[a-duz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="posNeg">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 8, 1), '[abmn\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 8, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $color, $physMedium, $reproType, $prodDetails, $posNeg)"/>
        </controlfield>
      </xsl:when>
      <!-- Electronic resource -->
      <xsl:when test="matches(substring(., 1, 1), '[c]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[a-fhjkmoruz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[abcgmnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dimensions">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[aegijnouvz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sound">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}au\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="bitDepth">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when test="matches(substring(., 7, 3), '\d{3}|mmm|nnn|---|\|\|\||[\p{Zs}]{3}')">
              <xsl:value-of select="replace(substring(., 7, 3), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="fileFormat">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 10, 1), '[amu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 10, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="qualityTarget">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 11, 1), '[anpu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 11, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="anteSource">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[a-dmnu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 12, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="compression">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 13, 1), '[abdmu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 13, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="reformatQuality">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 14, 1), '[anpru\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 14, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $color, $dimensions, $sound, $bitDepth, $fileFormat, $qualityTarget, $anteSource, $compression, $reformatQuality)"/>
        </controlfield>
      </xsl:when>
      <!-- Globe -->
      <xsl:when test="matches(substring(., 1, 1), '[d]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[a-ceuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[ac\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="physMedium">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[a-gijlnpu-z\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="reproType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[fnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $color, $physMedium, $reproType)"/>
        </controlfield>
      </xsl:when>
      <!-- Tactile material -->
      <xsl:when test="matches(substring(., 1, 1), '[f]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[a-duz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="brailleClass">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when test="matches(substring(., 4, 2), '[a-emnuz][a-emnuz\p{Zs}]|\|{2}')">
              <xsl:value-of select="replace(substring(., 4, 2), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 4, 2), '[a-emnuz]')">
              <xsl:variable name="codes">
                <xsl:value-of select="replace(substring(., 4, 2), '[^a-emnuz]', '')"/>
              </xsl:variable>
              <xsl:value-of select="substring(concat($codes, '&#32;&#32;'), 1, 2)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="contractionLevel">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[abmnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="brailleMusicFormat">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when test="matches(substring(., 7, 3), '[a-lnuz][a-lnuz\p{Zs}]{2}|\|{3}')">
              <xsl:value-of select="replace(substring(., 7, 3), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Keep existing codes, fill remaining positions with spaces -->
            <xsl:when test="matches(substring(., 7, 3), '[a-lnuz]')">
              <xsl:variable name="codes">
                <xsl:value-of select="replace(substring(., 7, 3), '[^a-lnuz]', '')"/>
              </xsl:variable>
              <xsl:value-of select="substring(concat($codes, '&#32;&#32;&#32;'), 1, 3)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="specialChar">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 10, 1), '[abnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 10, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $brailleClass, $contractionLevel, $brailleMusicFormat, $specialChar)"/>
        </controlfield>
      </xsl:when>
      <!-- Projected graphic -->
      <xsl:when test="matches(substring(., 1, 1), '[g]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[cdfos-uz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[a-chmnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="emulsionBase">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[dejkmou\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="soundOnMedium">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[abu\p{Zs}\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="mediumOfSound">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[a-iuz\p{Zs}\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dimensions">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 8, 1), '[a-gjks-z\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 8, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="support">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 9, 1), '[c-ehjkmuz\p{Zs}\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 9, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $color, $emulsionBase, $soundOnMedium, $mediumOfSound, $dimensions, $support)"/>
        </controlfield>
      </xsl:when>
      <!-- Microform -->
      <xsl:when test="matches(substring(., 1, 1), '[h]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[a-hjuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="posNeg">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[abmu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dimensions">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[adfghlmopuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="reductionRange">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[a-euv\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="reductionRatio">
          <xsl:choose>
            <!-- Codes are valid -->
            <!-- Treat '\-\-\-' as an invalid code, i.e. replace with '|||' -->
            <xsl:when test="matches(substring(., 7, 3), '\p{Zs}{3}|\d{3}|\d{2}-|\d--')">
              <xsl:value-of select="replace(substring(., 7, 3), '\p{Zs}', '&#32;')"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 10, 1), '[bcmuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 10, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="emulsion">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 11, 1), '[abcmnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 11, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="generation">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[abcmu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 12, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="filmBase">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 13, 1), '[acdimnprtuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 13, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $posNeg, $dimensions, $reductionRange, $reductionRatio, $color, $emulsion, $generation, $filmBase)"/>
        </controlfield>
      </xsl:when>
      <!-- Nonprojected graphic -->
      <xsl:when test="matches(substring(., 1, 1), '[k]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[ac-ln-suvz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[abchm\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="supportPrimary">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[a-il-wz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="supportSecondary">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}a-il-wz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $color, $supportPrimary, $supportSecondary)"/>
        </controlfield>
      </xsl:when>
      <!-- Motion picture -->
      <xsl:when test="matches(substring(., 1, 1), '[m]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[cforuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[bchmnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="presentationFormat">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[a-fuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="soundOnMedium">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}abu\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="mediumOfSound">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[\p{Zs}a-iuz]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dimensions">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 8, 1), '[a-guz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 8, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="playbackChannels">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 9, 1), '[kmnqsuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 9, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="productionElements">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 10, 1), '[a-gnz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 10, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="posNeg">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 11, 1), '[abnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 11, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="generation">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[deoruz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 12, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="filmBase">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 13, 1), '[acdimnprtuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 13, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="refinedColor">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 14, 1), '[a-np-vz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 14, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="colorStock">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 15, 1), '[a-dnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 15, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="deterioration">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 16, 1), '[a-hklm\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 16, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="completeness">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 17, 1), '[cinu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 17, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="inspectionDate">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when test="matches(substring(., 18, 6), '([0-9]{4}([0-9]{2}|[\-]{2}))|[\-]{6}')">
              <xsl:value-of select="substring(., 18, 6)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||||||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $color, $presentationFormat, $soundOnMedium, $mediumOfSound, $dimensions, $playbackChannels, $productionElements, $posNeg, $generation, $filmBase, $refinedColor, $colorStock, $deterioration, $completeness, $inspectionDate)"/>
        </controlfield>
      </xsl:when>
      <!-- Kit -->
      <xsl:when test="matches(substring(., 1, 1), '[o]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[u\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd)"/>
        </controlfield>
      </xsl:when>
      <!-- Notated music -->
      <xsl:when test="matches(substring(., 1, 1), '[q]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[u\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd)"/>
        </controlfield>
      </xsl:when>
      <!-- Remote-sensing image -->
      <xsl:when test="matches(substring(., 1, 1), '[r]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[u\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="sensorAlt">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[abcnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sensorAtt">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[abcnu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="cloudCover">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[0-9nu\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="platformConstruction">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[a-inuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="platformUse">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 8, 1), '[abcmnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 8, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sensorType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 9, 1), '[abuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 9, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dataType">
          <xsl:choose>
            <!-- Codes are valid -->
            <xsl:when
              test="matches(substring(., 10, 2), '(aa|da|db|dc|dd|de|df|dv|dz|ga|gb|gc|gd|ge|gf|gg|gu|gz|ja|jb|jc|jv|ma|mb|mm|nn|pa|pb|pc|pd|pe|pz|ra|rb|rc|rd|sa|ta|uu|zz|\|\|)')">
              <xsl:value-of select="substring(., 10, 2)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>||</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $sensorAlt, $sensorAtt, $cloudCover, $platformConstruction, $platformUse, $sensorType, $dataType)"/>
        </controlfield>
      </xsl:when>
      <!-- Sound recording -->
      <xsl:when test="matches(substring(., 1, 1), '[s]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[degiqstuwz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="speed">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[a-fhiklmopruz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="channelConfig">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[mqsuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="groovePitch">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[mnsuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dimensions">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[a-gjosnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tapeWidth">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 8, 1), '[l-puz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 8, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tapeConfig">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 9, 1), '[a-fnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 9, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="discCylinderTapeType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 10, 1), '[abdimnrstuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 10, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="materialType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 11, 1), '[abcgilmnprswuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 11, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="cuttingType">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 12, 1), '[hlnu\|]')">
              <xsl:value-of select="substring(., 12, 1)"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="specialPlayback">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 13, 1), '[a-hnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 13, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="captureStorage">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 14, 1), '[abdeuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 14, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $speed, $channelConfig, $groovePitch, $dimensions, $tapeWidth, $tapeConfig, $discCylinderTapeType, $materialType, $cuttingType, $specialPlayback, $captureStorage)"/>
        </controlfield>
      </xsl:when>
      <!-- Text -->
      <xsl:when test="matches(substring(., 1, 1), '[t]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[a-duz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd)"/>
        </controlfield>
      </xsl:when>
      <!-- Videorecording -->
      <xsl:when test="matches(substring(., 1, 1), '[v]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[acdfnruz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Undefined = 'no attempt to code' -->
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 4, 1), '[bcmnuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 4, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="format">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 5, 1), '[a-km-qsuvz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 5, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="soundOnMedium">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 6, 1), '[\p{Zs}abu\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 6, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="mediumOfSound">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 7, 1), '[\p{Zs}a-iuz\|]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 7, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dimensions">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 8, 1), '[amo-ruz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 8, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="channelConfig">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 9, 1), '[kmnqsuz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 9, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $color, $format, $soundOnMedium, $mediumOfSound, $dimensions, $channelConfig)"/>
        </controlfield>
      </xsl:when>
      <!-- Unspecified -->
      <xsl:when test="matches(substring(., 1, 1), '[z]', 'i')">
        <xsl:variable name="materialCode">
          <xsl:value-of select="lower-case(substring(., 1, 1))"/>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <!-- Code is valid -->
            <xsl:when test="matches(substring(., 2, 1), '[muz\|\p{Zs}]', 'i')">
              <xsl:value-of select="lower-case(replace(substring(., 2, 1), '\p{Zs}', '&#32;'))"/>
            </xsl:when>
            <!-- Replace w/ 'no attempt to code' -->
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd)"/>
        </controlfield>
      </xsl:when>
      <!-- Microform 007 erroneously contains subfields -->
      <xsl:when test="matches(., '^\|ah\|')">
        <xsl:variable name="materialCode">
          <xsl:text>h</xsl:text>
        </xsl:variable>
        <xsl:variable name="smd">
          <xsl:choose>
            <xsl:when
              test="normalize-space(lower-case(substring(substring-after(., '|b'), 1, 1))) != ''">
              <xsl:value-of select="lower-case(substring(substring-after(., '|b'), 1, 1))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="undef3">
          <xsl:text>|</xsl:text>
        </xsl:variable>
        <xsl:variable name="posNeg">
          <xsl:choose>
            <xsl:when
              test="normalize-space(lower-case(substring(substring-after(., '|d'), 1, 1))) != ''">
              <xsl:value-of select="lower-case(substring(substring-after(., '|d'), 1, 1))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dimensions">
          <xsl:choose>
            <xsl:when
              test="normalize-space(lower-case(substring(substring-after(., '|e'), 1, 1))) != ''">
              <xsl:value-of select="lower-case(substring(substring-after(., '|e'), 1, 1))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="reductionRatioRange">
          <xsl:choose>
            <xsl:when
              test="normalize-space(lower-case(substring(substring-after(., '|f'), 1, 1))) != ''">
              <xsl:value-of select="lower-case(substring(substring-after(., '|f'), 1, 1))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="reductionRatio">
          <xsl:text>|||</xsl:text>
        </xsl:variable>
        <xsl:variable name="color">
          <xsl:choose>
            <xsl:when
              test="normalize-space(lower-case(substring(substring-after(., '|g'), 1, 1))) != ''">
              <xsl:value-of select="lower-case(substring(substring-after(., '|g'), 1, 1))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="emulsion">
          <xsl:choose>
            <xsl:when
              test="normalize-space(lower-case(substring(substring-after(., '|h'), 1, 1))) != ''">
              <xsl:value-of select="lower-case(substring(substring-after(., '|h'), 1, 1))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="generation">
          <xsl:choose>
            <xsl:when
              test="normalize-space(lower-case(substring(substring-after(., '|i'), 1, 1))) != ''">
              <xsl:value-of select="lower-case(substring(substring-after(., '|i'), 1, 1))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="filmBase">
          <xsl:choose>
            <xsl:when
              test="normalize-space(lower-case(substring(substring-after(., '|j'), 1, 1))) != ''">
              <xsl:value-of select="lower-case(substring(substring-after(., '|j'), 1, 1))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>|</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="concat($materialCode, $smd, $undef3, $posNeg, $dimensions, $reductionRatioRange, $reductionRatio, $color, $emulsion, $generation, $filmBase)"/>
        </controlfield>
      </xsl:when>
      <!-- Unknown material; leave in place -->
      <xsl:otherwise>
        <controlfield>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </controlfield>
        <!--<xsl:variable name="recordIdentifier">
          <xsl:choose>
            <xsl:when test="../*:controlfield[@tag = '001']">
              <xsl:value-of select="../*:controlfield[@tag = '001']"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="position()"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:message>record <xsl:value-of select="$recordIdentifier"/>: Unknown value '<xsl:value-of
            select="substring(., 1, 1)"/>' in 007/00</xsl:message>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- MATCH TEMPLATES (phase 1, pass 3) -->
  <!-- Join illegal subfields to preceding sibling. -->
  <xsl:template match="
      *:datafield
      [not(*:subfield[normalize-space(@code) = ''])]" mode="pass3">
    <datafield>
      <xsl:apply-templates select="@*"/>
      <xsl:variable name="thisTag">
        <xsl:value-of select="@tag"/>
      </xsl:variable>
      <!-- Compress subfields -->
      <xsl:variable name="pass1">
        <xsl:call-template name="compressSubfields">
          <xsl:with-param name="tag">
            <xsl:value-of select="$thisTag"/>
          </xsl:with-param>
          <xsl:with-param name="subfieldList">
            <xsl:for-each select="*:subfield">
              <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:value-of select="normalize-space(.)"/>
              </xsl:copy>
            </xsl:for-each>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="okSubfields">
        <xsl:variable name="definedSubfields">
          <xsl:value-of
            select="string-join($marcDatafieldDesc//*:datafield[@tag = $thisTag]/*:subfield/@code, ' ')"
          />
        </xsl:variable>
        <xsl:if test="$definedSubfields ne ''">
          <xsl:value-of select="concat('[', $definedSubfields, ']')"/>
        </xsl:if>
      </xsl:variable>
      <xsl:choose>
        <!-- There are valid subfields to append to -->
        <xsl:when test="count(*:subfield[matches(@code, $okSubfields)]) &gt; 0">
          <xsl:variable name="groupedSubfields">
            <xsl:for-each-group select="$pass1/*:subfield"
              group-starting-with="*:subfield[matches(@code, $okSubfields)]">
              <group>
                <xsl:copy-of select="current-group()"/>
              </group>
            </xsl:for-each-group>
          </xsl:variable>
          <xsl:for-each
            select="$groupedSubfields/*:group[*:subfield[matches(@code, $okSubfields)]]/*:subfield[1]">
            <subfield>
              <xsl:apply-templates select="@*"/>
              <xsl:value-of select="."/>
              <xsl:if test="following-sibling::*:subfield">
                <xsl:if test="$thisTag != '041'">
                <xsl:text>&#32;</xsl:text>
              </xsl:if>              
                <xsl:value-of select="string-join(following-sibling::*:subfield, ' ')"/>
              </xsl:if>
              <xsl:if test="position() = last() and ../preceding-sibling::*[count(*:subfield[matches(@code, $okSubfields)]) = 0]">
                <xsl:if test="$thisTag != '041'">
                <xsl:text>&#32;</xsl:text>
              </xsl:if>
              <xsl:value-of select="string-join(../preceding-sibling::*[count(*:subfield[matches(@code, $okSubfields)]) = 0]/*:subfield, ' ')"/>
              </xsl:if>
            </subfield>
          </xsl:for-each>
        </xsl:when>
        <!-- No valid subfields; output the invalid subfields -->
        <xsl:otherwise>
          <xsl:apply-templates select="*:subfield" mode="pass3"/>
        </xsl:otherwise>
      </xsl:choose>
    </datafield>
  </xsl:template>

  <!-- MATCH TEMPLATES (phase 1, pass 4) -->
  <xsl:template match="*:datafield[@tag = '035']" mode="pass4">
    <xsl:if test="*:subfield and normalize-space(.) != ''">
      <datafield>
        <xsl:apply-templates select="@*"/>
        <xsl:for-each select="*:subfield">
          <subfield>
          <xsl:attribute name="code">
            <xsl:choose>
              <xsl:when test="@code = '9'">
                <xsl:text>z</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@code"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:value-of select="."/>
        </subfield>
        </xsl:for-each>
      </datafield>
    </xsl:if>
  </xsl:template>

  <!-- Join multiple 019 datafields into a single field -->
  <xsl:template match="*:datafield[@tag = '019'][1]" mode="pass4">
    <datafield>
      <xsl:apply-templates select="@*"/>
      <!-- Ignore subfields other than $a; they're illegal -->
      <xsl:apply-templates select="*:subfield[@code = 'a']" mode="pass4"/>
      <xsl:apply-templates
        select="following-sibling::*:datafield[@tag = '019']/*:subfield[@code = 'a']" mode="pass4"/>
    </datafield>
  </xsl:template>
  <!-- Ignore datafield 019 after the first one -->
  <xsl:template match="*:datafield[@tag = '019'][position() &gt; 1]" mode="pass4"/>

  <!-- Delete the following datafields -->
  <xsl:template match="*:datafield[@tag = '039']" mode="pass4"/>
  <xsl:template match="*:datafield[@tag = '049']" mode="pass4"/>
  <xsl:template match="*:datafield[@tag = '066']" mode="pass4"/>
  <xsl:template match="*:datafield[@tag = '092']" mode="pass4"/>

  <!-- Delete 050 with "provisional" (?) call number -->
  <xsl:template match="
      *:datafield[@tag = '050' and matches(normalize-space(.), '^[A-Z]{3}$')]" mode="pass4"/>

  <!-- Delete 090 datafield that 
    1. doesn't have $a and doesn't have $b or
    2. matches '^[A-Z]X\d+=' -->
  <xsl:template match="
      *:datafield[@tag = '090' and
      not(*:subfield[@code = 'a']) and not(*:subfield[@code = 'b'])] |
      *:datafield[@tag = '090'][matches(., '^\**[A-Z]X\d+=')]" mode="pass4"/>

  <!-- Delete 090 subfields other than '[abef]' -->
  <xsl:template match="*:datafield[@tag = '090']/*:subfield[not(matches(@code, '[abef]'))]"
    mode="pass4"/>

  <!-- Replace 099 subfield $v with subfield $a -->
  <xsl:template match="*:datafield[@tag = '099']/*:subfield[@code = 'v']" mode="pass4">
    <subfield>
      <xsl:attribute name="code">a</xsl:attribute>
      <xsl:apply-templates mode="pass4"/>
    </subfield>
  </xsl:template>

  <!-- Replace ind2="[Oo]" w/ "0" (zero) -->
  <xsl:template match="@ind2[matches(., 'O', 'i')]" mode="pass4">
    <xsl:attribute name="ind2">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <!-- MATCH TEMPLATES (phase 2) -->
  <xsl:template match="*:record" mode="phase2">
    <record xmlns="http://www.loc.gov/MARC21/slim">
      <!-- Process leader, controlfields, and datafields preceding 035 -->
      <xsl:copy-of select="*:leader"/>
      <xsl:apply-templates select="*:controlfield" mode="phase2"/>
      <xsl:apply-templates select="*:datafield[number(@tag) &lt; 35]" mode="phase2"/>
      <!-- Process 035s normally -->
      <xsl:variable name="systemControlNumbers">
        <xsl:apply-templates select="*:datafield[number(@tag) = 35]" mode="phase2"/>
      </xsl:variable>
      <!-- Keep only 035s where subfield $a has a parenthetical system identifier -->
      <xsl:variable name="systemControlNumbersWithSystemID">
        <xsl:copy-of
          select="$systemControlNumbers/*:datafield[matches(*:subfield[@code = 'a'], '\(')]"/>
      </xsl:variable>
      <!-- Clean up 035/$a values -->
      <xsl:variable name="systemControlNumbersClean">
        <xsl:for-each select="$systemControlNumbersWithSystemID/*:datafield">
          <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each select="*:subfield">
              <xsl:copy>
                <xsl:apply-templates select="@*"/>
                <xsl:choose>
                  <xsl:when test="@code = 'a'">
                    <xsl:value-of
                      select="replace(replace(normalize-space(.), '[^\(\)A-Za-z0-9]', '', 'i'), '^[^\(]+', '')"
                    />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="."/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:copy>
            </xsl:for-each>
          </xsl:copy>
        </xsl:for-each>
      </xsl:variable>
      <xsl:copy-of select="$systemControlNumbersClean"/>

      <!-- Process datafields following 035, but preceding 090 -->
      <xsl:apply-templates select="*:datafield[number(@tag) &gt; 35 and number(@tag) &lt; 90]"
        mode="phase2"/>

      <!-- Process unique 090s -->
      <xsl:for-each select="*:datafield[@tag = '090']">
        <xsl:variable name="thisValue">
          <xsl:value-of select="replace(normalize-space(.), '\s', '')"/>
        </xsl:variable>
        <xsl:if test="
            not(preceding-sibling::*:datafield[@tag = '090']
            [replace(normalize-space(.), '\s', '') = $thisValue]) and
            not(../*:datafield[@tag = '099'][replace(normalize-space(.), '\s', '') = $thisValue])">
          <xsl:apply-templates select="." mode="phase2"/>
        </xsl:if>
      </xsl:for-each>

      <!-- Process datafields following 090 -->
      <!-- Group datafields by hundreds, sort by @tag except 5xx and 6xx which remain in document order -->
      <xsl:apply-templates select="*:datafield[number(@tag) &gt; 90 and number(@tag) &lt; 100]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 100 and number(@tag) &lt; 200]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 200 and number(@tag) &lt; 300]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 300 and number(@tag) &lt; 400]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 400 and number(@tag) &lt; 500]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 500 and number(@tag) &lt; 600]"
        mode="phase2"/>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 600 and number(@tag) &lt; 700]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 700 and number(@tag) &lt; 800]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 800 and number(@tag) &lt; 900]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt;= 900 and number(@tag) &lt; 991]"
        mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>

      <xsl:apply-templates select="*:datafield[@tag = '991']" mode="phase2"/>
      <xsl:if test="not(*:datafield[@tag = '991'])">
        <datafield tag="991" ind1=" " ind2=" ">
          <subfield code="a">MARC validation project</subfield>
        </datafield>
      </xsl:if>
      <xsl:apply-templates select="*:datafield[number(@tag) &gt; 991]" mode="phase2">
        <xsl:sort select="number(@tag)"/>
      </xsl:apply-templates>
    </record>
  </xsl:template>

  <xsl:template match="*:datafield[@tag = '991']" mode="phase2">
    <datafield tag="991" ind1=" " ind2=" ">
      <xsl:apply-templates
        select="*:subfield[@code = 'a'][normalize-space(.) != 'MARC validation project']"
        mode="phase2"/>
      <subfield code="a">MARC validation project</subfield>
    </datafield>
  </xsl:template>

  <!-- Repair Type of date/Publication status flag -->
  <xsl:template match="
      *:controlfield[@tag = '008'][matches(substring(., 7, 1), '[cdiku]') and
      ../*:leader[matches(substring(., 8, 1), 'm')]]" mode="phase2">
    <controlfield tag="008">
      <xsl:variable name="c260">
        <!-- Some records, e.g., u10459, use lowercase 'l' as number 1 -->
        <xsl:for-each select="../*:datafield[@tag = '260']/*:subfield[@code = 'c']">
          <xsl:value-of select="normalize-space(replace(., 'l', '1'))"/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:variable name="date1">
        <xsl:value-of select="substring(., 8, 4)"/>
      </xsl:variable>
      <xsl:variable name="date2">
        <xsl:value-of select="substring(., 12, 4)"/>
      </xsl:variable>
      <!-- In date1copy and date2copy, character class contains
        copyright sign, copyright sign for recordings, "c", or "p" -->
      <xsl:variable name="date1copy">
        <xsl:value-of select="concat('[©℗cp]\s*', substring(., 8, 4))"/>
      </xsl:variable>
      <xsl:variable name="date2copy">
        <xsl:value-of select="concat('[©℗cp]\s*', substring(., 12, 4))"/>
      </xsl:variable>
      <xsl:variable name="dateRange">
        <xsl:value-of select="concat(substring(., 8, 4), '-', substring(., 12, 4))"/>
      </xsl:variable>
      <xsl:choose>
        <!-- 260$c contains a date range -->
        <xsl:when test="matches($c260, $dateRange)">
          <xsl:value-of select="concat(substring(., 1, 6), 'm', substring(., 8))"/>
        </xsl:when>
        <!-- 260$c contains a copyright or production date -->
        <xsl:when test="matches($c260, $date1copy) or matches($c260, $date2copy)">
          <xsl:value-of select="concat(substring(., 1, 6), 't', substring(., 8))"/>
        </xsl:when>
        <!-- 2 dates in 008 and 260$c matches either one; this is a slightly different
          version of the previous test -->
        <xsl:when test="normalize-space($date2) != '' and matches($c260, $date1) or matches($c260, $date2)">
          <xsl:value-of select="concat(substring(., 1, 6), 't', substring(., 8))"/>
        </xsl:when>
        <!-- There's a 500 note containing the string 'reprint' -->
        <xsl:when test="../*:datafield[@tag = '500'][matches(., 'reprint', 'i')]">
          <xsl:value-of select="concat(substring(., 1, 6), 'r', substring(., 8))"/>
        </xsl:when>
        <xsl:when test="normalize-space(substring(., 12, 4)) = ''">
          <xsl:value-of select="concat(substring(., 1, 6), 's', substring(., 8))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>      
    </controlfield>
  </xsl:template>

  <!-- Repair @ind1 -->
  <!-- Replace ind1="[Oo]" w/ "0" (zero) -->
  <xsl:template match="@ind1[matches(., 'O', 'i')]" priority="2">
    <xsl:attribute name="ind1">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <!-- Fixed value = ' ' -->
  <xsl:template
    match="*:datafield[matches(@tag, '(010|013|015|017|018|019|020|025|026|027|030|031|032|035|036|038|040|042|043|044|046|047|048|051|061|066|071|072|074|084|085|088|090|096|099|222|250|251|254|255|256|257|258|261|262|263|300|306|310|321|336|337|338|340|343|344|345|346|347|348|351|352|357|365|366|370|377|380|381|383|385|386|440|500|501|502|504|507|508|513|514|515|518|525|530|533|534|536|538|539|540|546|547|550|552|562|563|580|584|585|591|592|593|594|595|596|597|598|647|648|651|656|657|658|662|691|751|752|753|754|758|830|841|842|843|844|845|850|855|876|877|878|882|884|887|910|936|938|987|994|999)')]/@ind1[not(matches(., '&#32;'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>&#32;</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <!-- Fixed value = '0' -->
  <xsl:template match="*:datafield[matches(@tag, '(510|511)')]/@ind1[not(matches(., '[01]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <!-- Best-guess value = '&#32;' -->
  <xsl:template match="*:datafield[matches(@tag, '(260)')]/@ind1[not(matches(., '[\s23]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>&#32;</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '(264)')]/@ind1[not(matches(., '[\s23]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>&#32;</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '(650)')]/@ind1[not(matches(., '[\s012]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:choose>
        <xsl:when test="count(ancestor::*:record/*:datafield[matches(@tag, '(650)')]) = 1">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>&#32;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>
  <!-- Series traced/untraced -->
  <xsl:template match="*:datafield[matches(@tag, '(490)')]/@ind1[not(matches(., '[01]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:choose>
        <!-- Series traced -->
        <xsl:when test="../*:datafield[matches(@tag, '(800|810|811|830)')]">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <!-- Series untraced -->
        <xsl:otherwise>
          <xsl:text>0</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '(490)')]/@ind1[matches(., '1')]" mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:choose>
        <!-- Change ind1 to '0' if there's no 8XX -->
        <xsl:when test="not(ancestor::*:record/*:datafield[matches(@tag, '(800|810|811|830)')])">
          <xsl:text>0</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>1</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!-- Best-guess value = '0' -->
  <xsl:template match="*:datafield[matches(@tag, '(505)')]/@ind1[not(matches(., '[0128]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '(773)')]/@ind1[not(matches(., '[01]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <!-- Best-guess value = '1' -->
  <xsl:template match="*:datafield[matches(@tag, '(362)')]/@ind1[not(matches(., '[01]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>1</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '(535)')]/@ind1[not(matches(., '[12]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>1</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <!-- Replace non-compliant value with best-guess value -->
  <xsl:template match="*:datafield[matches(@tag, '655')]/@ind1[not(matches(., '[\s0]'))]"
    mode="phase2">
    <xsl:choose>
      <xsl:when test="count(../*:subfield[matches(@code, '[ab]')]) &gt; 1">
        <xsl:attribute name="ind1">
          <xsl:text>0</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="ind1">
          <xsl:text>&#32;</xsl:text>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Repair name type flag in ind1 -->
  <xsl:template match="*:datafield[matches(@tag, '800')]/@ind1[not(matches(., '[013]'))]"
    mode="phase2">
    <xsl:choose>
      <xsl:when
        test="matches(replace(normalize-space(../*:subfield[@code = 'a']), '\W+$', ''), ',')">
        <xsl:attribute name="ind1">
          <xsl:text>1</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="ind1">
          <xsl:text>0</xsl:text>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Repair @ind2 -->
  <!-- Replace ind2="[Oo]" w/ "0" (zero) -->
  <!--<xsl:template match="@ind2[matches(., 'O', 'i')]" priority="2">
    <xsl:attribute name="ind2">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>-->

  <!-- Fixed value = ' ' -->
  <xsl:template
    match="*:datafield[matches(@tag, '(010|013|015|016|018|019|020|022|025|026|027|029|030|031|032|035|036|037|038|040|042|043|044|045|046|051|052|061|066|070|071|074|080|083|084|085|086|088|090|092|096|100|110|111|130|250|251|254|255|256|257|258|260|261|262|263|300|306|307|310|321|336|337|338|340|341|343|344|345|346|347|348|351|352|355|357|362|365|366|370|380|381|383|384|385|386|388|490|500|501|502|504|506|507|508|510|511|513|514|515|516|518|520|521|522|524|525|526|530|532|533|534|535|536|538|539|540|541|542|544|545|546|547|550|552|555|556|561|562|563|565|567|580|581|583|584|585|586|588|590|591|592|593|594|595|596|597|598|654|658|662|720|751|752|753|754|758|800|810|811|841|842|843|844|845|850|855|876|877|878|882|883|884|886|887|910|936|938|987|994|999)')]/@ind2[not(matches(., '&#32;'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>&#32;</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <!-- Replace non-compliant value with fixed value -->
  <xsl:template match="*:datafield[matches(@tag, '(653)')]/@ind2[not(matches(., '[\s0-6]'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>&#32;</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '(656|657)')]/@ind2[not(matches(., '7'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>7</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <!-- Replace non-compliant value with best-guess value -->
  <xsl:template match="*:datafield[matches(@tag, '(264)')]/@ind2[not(matches(., '[0-4]'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>1</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '505')]/@ind2[not(matches(., '\s0'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:choose>
        <xsl:when
          test="count(../*:subfield[@code = 'a']) = 1 and count(../*:subfield[@code != 'a']) = 0">
          <xsl:text>&#32;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>0</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>
  <xsl:template
    match="*:datafield[matches(@tag, '600|610|611|630|647|648|650|651|655')]/@ind2[not(matches(., '[0-7]'))]"
    mode="phase2">
    <xsl:choose>
      <xsl:when test="../*:subfield[@code = '2']">
        <xsl:attribute name="ind2">
          <xsl:text>7</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="ind2">
          <xsl:text>0</xsl:text>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template
    match="*:datafield[matches(@tag, '(700|710|711|730|740)')]/@ind2[not(matches(., '[\s2]'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>&#32;</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '(830)')]/@ind2[not(matches(., '[0-9]'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '866')]/@ind2[not(matches(., '[0127]'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <!-- Fix 040 erroneous subfield @code -->
  <xsl:template match="*:datafield[matches(@tag, '040')]/*:subfield[@code = 'b' and . = 'VA@']"
    mode="phase2">
    <subfield code="d">VA@</subfield>
  </xsl:template>

  <!-- 041 -->
  <xsl:template match="*:datafield[@tag = '041']" mode="phase2">
    <xsl:choose>
      <!-- Replace 041 with 043 when subfield @code is missing -->
      <xsl:when test="count(*:subfield) = 1 and count(*:subfield[not(@code)]) = 1">
        <datafield tag="043" ind1=" " ind2=" ">
          <subfield code="a">
            <xsl:value-of select="."/>
          </subfield>
        </datafield>
      </xsl:when>
      <!-- Replace 041 with 043 when subfield $a matches '-' -->
      <xsl:when
        test="count(*:subfield) = 1 and count(*:subfield[@code = 'a']) = 1 and matches(*:subfield[@code = 'a'], '-')">
        <datafield tag="043" ind1=" " ind2=" ">
          <subfield code="a">
            <xsl:value-of select="."/>
          </subfield>
        </datafield>
      </xsl:when>
      <!-- Split over-long 041 subfields into multiple subfields -->
      <xsl:when test="*:subfield[string-length(.) &gt; 3]">
        <xsl:copy>
          <xsl:apply-templates select="@tag"/>
          <!-- Set @ind1 based on presence of subfield $h or $n -->
          <xsl:attribute name="ind1">
            <xsl:choose>
              <xsl:when test="*:subfield[matches(@code, '[hn]')]">
                <xsl:text>1</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@ind1"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:apply-templates select="@ind2"/>
          <xsl:for-each select="*:subfield">
            <xsl:choose>
              <!-- Split multiple codes without separators into multiple subfields -->
              <xsl:when test="matches(., '([a-z]{3})+$')">
                <xsl:call-template name="split041subfield">
                  <xsl:with-param name="thisValue">
                    <!-- Fix common errors -->
                    <xsl:value-of
                      select="replace(replace(replace(replace(replace(normalize-space(.), '[^a-zA-Z]+$', ''), 'jap', 'jpn'), 'ing', 'eng'), 'end', 'eng'), 'rur', 'rus')"
                    />
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <!-- Split multiple codes with separators into multiple subfields -->
              <xsl:when test="matches(., '([a-z]{3}[^a-z])+')">
                <xsl:variable name="thisSubfield">
                  <xsl:value-of select="@code"/>
                </xsl:variable>
                <xsl:analyze-string select="replace(normalize-space(.), '[^a-zA-Z]+$', '')"
                  regex="[^a-z]+">
                  <xsl:non-matching-substring>
                    <subfield code="{$thisSubfield}">
                      <!-- Fix common errors -->
                      <xsl:value-of select="replace(replace(replace(replace(., 'jap', 'jpn'), 'ing', 'eng'), 'end', 'eng'), 'rur', 'rus')"/>
                    </subfield>
                  </xsl:non-matching-substring>
                </xsl:analyze-string>
              </xsl:when>
              <!-- Single code -->
              <xsl:otherwise>
                <subfield>
                  <xsl:attribute name="code">
                    <xsl:choose>
                      <xsl:when test="@code">
                        <xsl:value-of select="@code"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>a</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <!-- Fix common errors -->
                  <xsl:value-of select="replace(replace(replace(replace(replace(normalize-space(.), '[^a-zA-Z]+$', ''), 'jap', 'jpn'), 'ing', 'eng'), 'end', 'eng'), 'rur', 'rus')"/>
                </subfield>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:copy>
      </xsl:when>
      <!-- "Regular" 041 -->
      <xsl:otherwise>
        <datafield>
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates mode="phase2"/>
        </datafield>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*:datafield[@tag = '041']/*:subfield[not(matches(@code, '[b]'))]"
    mode="phase2">
    <!-- Fix common errors -->
    <subfield>
      <xsl:attribute name="code">
        <xsl:value-of select="@code"/>
      </xsl:attribute>
      <xsl:value-of select="replace(replace(replace(replace(replace(normalize-space(.), '[^a-zA-Z]+$', ''), 'jap', 'jpn'), 'ing', 'eng'), 'end', 'eng'), 'rur', 'rus')"/>
    </subfield>
  </xsl:template>

  <xsl:template match="*:datafield[@tag = '041']/*:subfield[@code = 'b']" mode="phase2">
    <xsl:choose>
      <!-- Substitute $j for $b for video material -->
      <xsl:when test="
          ancestor::*:record/*:datafield[@tag = '099'][*:subfield[@code = 'a'][matches(., '^VIDEO', 'i')]] or
          ancestor::*:record/*:datafield[@tag = '245'][*:subfield[@code = 'h'][matches(., 'videorecording', 'i')]] or
          ancestor::*:record/*:controlfield[@tag = '007'][substring(., 1, 1) = 'v']">
        <!-- Fix common errors -->
        <subfield code="j">
          <xsl:value-of select="replace(replace(replace(replace(replace(normalize-space(.), '[^a-zA-Z]+$', ''), 'jap', 'jpn'), 'ing', 'eng'), 'end', 'eng'), 'rur', 'rus')"/>
        </subfield>
      </xsl:when>
      <!-- Fix common errors -->
      <xsl:otherwise>
        <subfield code="b">
          <xsl:value-of select="replace(replace(replace(replace(replace(normalize-space(.), '[^a-zA-Z]+$', ''), 'jap', 'jpn'), 'ing', 'eng'), 'end', 'eng'), 'rur', 'rus')"/>
        </subfield>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 041/@ind 1 -->
  <xsl:template match="*:datafield[@tag = '041']/@ind1" mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:choose>
        <xsl:when test="../*:subfield[@code = 'h']">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!-- Uncomment the following templates if 049s are not to be deleted -->
  <!-- Join all 049s into a single datafield -->
  <!--<xsl:template match="*:datafield[matches(@tag, '049')][1]">
    <datafield>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="*:subfield"/>
      <xsl:apply-templates select="following-sibling::*:datafield[matches(@tag, '049')]/*:subfield"
       />
    </datafield>
  </xsl:template>-->
  <!-- Ignore 049s other than the first -->
  <!--<xsl:template match="*:datafield[matches(@tag, '049')][position() &gt; 1]"/>-->

  <!-- In 110, 111, 610, 611, 710, and 711 replace ind1 = "&#32;" (space) with ind1="0" -->
  <xsl:template
    match="*:datafield[matches(@tag, '110|111|610|611|710|711')]/@ind1[matches(., '(&#32;|2)')]"
    mode="phase2">
    <xsl:attribute name="ind1">0</xsl:attribute>
  </xsl:template>

  <!-- Repair @ind1 on 100, 600, and 700 -->
  <xsl:template match="*:datafield[matches(@tag, '100|600|700')]/@ind1[not(matches(., '[013]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:choose>
        <!-- Family name -->
        <xsl:when test="matches(../*:subfield[@code = 'a'], 'family', 'i')">
          <xsl:text>3</xsl:text>
        </xsl:when>
        <!-- Surname -->
        <xsl:when test="matches(../*:subfield[@code = 'a'], ', .*', 'i')">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <!-- Forename -->
        <xsl:otherwise>
          <xsl:text>0</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <!-- Since 245 isn't repeatable, convert occurrences after the first to 246? -->
  <!--<xsl:template match="*:datafield[matches(@tag, '245')][position() &gt; 1]">
    
  </xsl:template>-->

  <!-- Repair 245 indicators -->
  <xsl:template match="*:datafield[matches(@tag, '245')]/@ind1[not(matches(., '[01]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '245')]/@ind2[not(matches(., '[0-9]'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <!-- Repair 246 indicators -->
  <xsl:template match="*:datafield[matches(@tag, '246')]/@ind1[not(matches(., '[0123]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>1</xsl:text>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="*:datafield[matches(@tag, '246')]/@ind2[not(matches(., '[\s0-8]'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>&#32;</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <!-- Replace 506$s with $a -->
  <xsl:template match="*:datafield[@tag = '506']/*:subfield[@code = 's']" mode="phase2">
    <subfield code="a">
      <xsl:value-of select="."/>
    </subfield>
  </xsl:template>

  <!-- In 600 keep only allowed subfields -->
  <xsl:template match="*:datafield[@tag = '600']" mode="phase2">
    <datafield>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="*:subfield[matches(@code, '[abcdefghjklmnopqrstuvxyz0123468]')]"
        mode="phase2"/>
    </datafield>
  </xsl:template>

  <!-- In 653 keep $6 & $8, make all other subfields $a -->
  <xsl:template match="*:datafield[@tag = '653']" mode="phase2">
    <datafield>
      <xsl:apply-templates select="@*"/>
      <xsl:for-each select="*:subfield">
        <subfield>
          <xsl:attribute name="code">
            <xsl:choose>
              <xsl:when test="matches(@code, '6|8')">
                <xsl:value-of select="@code"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>a</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:value-of select="."/>
        </subfield>
      </xsl:for-each>
    </datafield>
  </xsl:template>

  <!-- Set @ind2 = '0' when value is invalid -->
  <xsl:template match="*:datafield[@tag = '695']/@ind2[not(matches(., '[0-59]'))]" mode="phase2">
    <xsl:attribute name="ind2">9</xsl:attribute>
  </xsl:template>

  <!-- Delete 773 when $a matches library name in 999 -->
  <xsl:template match="*:datafield[@tag = '773']" mode="phase2">
    <!-- Create a look-up table of library names -->
    <xsl:variable name="libraries">
      <xsl:copy-of select="../*:datafield[@tag = '999']/*:subfield[@code = 'm']"/>
    </xsl:variable>
    <!-- Capture $a -->
    <xsl:variable name="heading">
      <xsl:value-of select="upper-case(normalize-space(*:subfield[@code = 'a']))"/>
    </xsl:variable>
    <xsl:choose>
      <!-- Don't process the 773 if $a matches a library name -->
      <xsl:when test="$libraries//*:subfield[. eq $heading]"/>
      <xsl:otherwise>
        <datafield>
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates mode="phase2"/>
        </datafield>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- On 017, 76x, 77x, and 78x, set incorrect ind2 value to ' ' -->
  <xsl:template
    match="*:datafield[matches(@tag, '(017|760|762|765|767|770|773|774|775|776|777|786|787)')]/@ind2[not(matches(., '[\s8]'))]"
    mode="phase2">
    <xsl:attribute name="ind2">
      <xsl:text>&#32;</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <!-- On 810, set incorrect ind2 value to '2' -->
  <xsl:template match="*:datafield[matches(@tag, '810')]/@ind1[not(matches(., '[012]'))]"
    mode="phase2">
    <xsl:attribute name="ind1">
      <xsl:text>2</xsl:text>
    </xsl:attribute>
  </xsl:template>

  <!-- Repair 856 @ind1-->
  <xsl:template match="*:datafield[@tag = '856']" mode="phase2">
    <xsl:copy>
      <xsl:apply-templates select="@tag"/>
      <xsl:choose>
        <xsl:when test="*:subfield[@code = 'u'][not(matches(., '^(mailto|ftp|telnet|https?):'))]">
          <xsl:attribute name="ind1">
            <xsl:text>&#32;</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@ind1" mode="phase2"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@ind2" mode="phase2"/>
      <xsl:apply-templates mode="phase2"/>
    </xsl:copy>
  </xsl:template>

  <!-- In subfield 8 replace forward slash w/ backslash -->
  <xsl:template match="*:subfield[@code = '8']" mode="phase2">
    <xsl:copy>
      <xsl:copy-of select="@code"/>
      <xsl:value-of select="replace(., '/', '\\')"/>
    </xsl:copy>
  </xsl:template>

  <!-- MATCH TEMPLATES (phase3) -->
  <!-- 010 -->
  <xsl:template match="*:datafield[@tag = '010'][1]" mode="phase3">
    <xsl:choose>
      <!-- Copy when datafield 010 is not repeated or following-sibling 
        datafield 010 has fields other than $z -->
      <xsl:when test="
          not(following-sibling::*:datafield[@tag = '010'])
          or following-sibling::*:datafield[@tag = '010']/*:subfield[matches(@code, '[^z]')]">
        <xsl:copy>
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates mode="phase3"/>
        </xsl:copy>
      </xsl:when>
      <!-- Datafield 010 repeated -->
      <!-- Following sibling 010 has only $z subfields -->
      <xsl:when
        test="count(following-sibling::*:datafield[@tag = '010']/*:subfield[@code = 'z']) = count(following-sibling::*:datafield[@tag = '010']/*:subfield)">
        <!-- Include following sibling $z subfields -->
        <xsl:copy>
          <xsl:apply-templates select="@*"/>
          <xsl:apply-templates mode="phase3"/>
          <xsl:apply-templates
            select="following-sibling::*:datafield[@tag = '010']/*:subfield[@code = 'z']"
            mode="phase3"/>
        </xsl:copy>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*:datafield[@tag = '010'][position() &gt; 1]" mode="phase3">
    <!-- Process 010 if there are subfields other than $z -->
    <xsl:if test="not(count(*:subfield[@code = 'z']) = count(*:subfield))">
      <xsl:copy>
        <xsl:apply-templates select="@*"/>
        <xsl:apply-templates mode="phase3"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <!-- Delete 035 that doesn't have $a -->
  <!--<xsl:template match="*:datafield[@tag = '035' and not(*:subfield[@code = 'a'])]"/>-->

  <!-- Join all 040s into a single datafield -->
  <!--<xsl:template match="*:datafield[@tag = '040' and following-sibling::*:datafield[@tag = '040']][1]">-->
  <xsl:template match="*:datafield[@tag = '040'][1]" mode="phase3">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="*:subfield" mode="phase3"/>
      <xsl:for-each select="following-sibling::*:datafield[@tag = '040']">
        <xsl:apply-templates select="*:subfield" mode="phase3"/>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
  <!-- Delete 040 other than first -->
  <xsl:template match="*:datafield[@tag = '040'][position() &gt; 1]" mode="phase3"/>

  <!-- Create 041 $h when @ind1 = '1', there are 2 subfields, and $h doesn't already exist -->
  <xsl:template match="
      *:datafield[@tag = '041' and @ind1 = '1'
      and *:subfield[@code = 'a'] and count(*:subfield) = 2 and
      not(*:subfield[matches(@code, '[hn]')])]" mode="phase3">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:variable name="pubLang">
        <xsl:value-of select="substring(ancestor::*:record/*:controlfield[@tag = '008'], 36, 3)"/>
      </xsl:variable>
      <xsl:choose>
        <!-- When there's a subfield that matches 008/35-37 -->
        <xsl:when test="*:subfield[matches(., $pubLang)] and *:subfield[not(matches(., $pubLang))]">
          <subfield code="a">
            <xsl:value-of select="*:subfield[matches(., $pubLang)][1]"/>
          </subfield>
          <subfield code="h">
            <xsl:value-of select="
                replace(replace(replace(replace(replace(
                *:subfield[not(matches(., $pubLang))][1], 'ser', 'srp'),
                'cro', 'hrv'),
                'scs', 'srp'),
                'scc', 'srp'),
                'scr', 'srp')"/>
          </subfield>
        </xsl:when>
        <!-- Pass the error through -->
        <xsl:otherwise>
          <xsl:apply-templates select="*:subfield" mode="phase3"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- Repair incorrect 041 @ind1 when there are 2 subfields: $a and $h -->
  <xsl:template match="
      *:datafield[@tag = '041' and
      @ind1 = '0' and *:subfield[@code = 'a'] and count(*:subfield) = 2 and
      *:subfield[matches(@code, '[hn]')]]" mode="phase3">
    <datafield tag="041" ind1="1">
      <xsl:apply-templates select="@ind2"/>
      <xsl:apply-templates select="*:subfield" mode="phase3"/>
    </datafield>
  </xsl:template>

  <!-- Repair 041 incorrect @ind1 when there are only subfields matching 
    $b, d, e, f, g, i, j, m, p, q, r, and t -->
  <xsl:template match="
      *:datafield[@tag = '041' and
      @ind1 = '1' and count(*:subfield[matches(@code, '[bdefgijmpqrt]')]) =
      count(*:subfield[matches(@code, '[a-z]')])]" mode="phase3">
    <datafield tag="041" ind1="0">
      <xsl:apply-templates select="@ind2"/>
      <xsl:apply-templates select="*:subfield" mode="phase3"/>
    </datafield>
  </xsl:template>

  <!-- Repair 041 incorrect @ind1 when all subfields have the same value -->
  <xsl:template match="
      *:datafield[@tag = '041' and
      @ind1 = '1' and count(distinct-values(*:subfield)) = 1]" mode="phase3">
    <datafield tag="041" ind1="0">
      <xsl:apply-templates select="@ind2"/>
      <xsl:apply-templates select="*:subfield" mode="phase3"/>
    </datafield>
  </xsl:template>

  <!-- Fix common language code errors -->
  <xsl:template match="*:datafield[@tag = '041']/*:subfield[matches(@code, '[a-z]')]" mode="phase3">
    <xsl:variable name="thisCode">
      <xsl:value-of select="@code"/>
    </xsl:variable>
    <subfield code="{$thisCode}">
      <xsl:value-of select="
          replace(replace(replace(replace(replace(replace(., 'ser', 'srp'),
          'cro', 'hrv'),
          'scs', 'srp'),
          'scc', 'srp'),
          'scr', 'srp'), 'fle', 'dut')"/>
    </subfield>
  </xsl:template>

  <!-- Ensure that 044/$a is 3 characters long -->
  <xsl:template match="*:datafield[@tag = '044']/*:subfield[@code = 'a']" mode="phase3">
    <subfield code="a">
      <xsl:value-of select="substring(concat(normalize-space(.), '   '), 1, 3)"/>
    </subfield>
  </xsl:template>

  <!-- Set @ind2 to '3' when 246/$a is not a substring of 245 -->
  <xsl:template match="
      *:datafield[@tag = '246' and @ind2 = '0' and
      normalize-space(*:subfield[@code = 'a']) != '' and
      normalize-space(ancestor::*:record/*:datafield[@tag = '245'][1]) != '']" mode="phase3">
    <xsl:variable name="title245">
      <xsl:for-each
        select="ancestor::*:record/*:datafield[@tag = '245'][1]/*:subfield[not(matches(@code, '[h678]'))]">
        <xsl:value-of select="."/>
        <xsl:text>&#32;</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="title245norm">
      <xsl:value-of
        select="normalize-space(replace(replace($title245, '\p{Z}', ' '), '[\p{P}|:|\$\+\*\|]', ''))"
      />
    </xsl:variable>
    <xsl:variable name="subfieldA"
      select="normalize-space(replace(replace(*:subfield[@code = 'a'], '\p{Z}', ' '), '[\p{P}|:|\$\+\*\|]', ''))"/>
    <xsl:copy>
      <xsl:copy-of select="@tag"/>
      <xsl:copy-of select="@ind1"/>
      <xsl:attribute name="ind2">
        <xsl:choose>
          <xsl:when test="matches($title245norm, $subfieldA, 'i')">
            <xsl:text>0</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>3</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates mode="phase3"/>
    </xsl:copy>
  </xsl:template>

  <!-- Repair language coding error in 775/subfield $f -->
  <xsl:template match="*:datafield[@tag = '775']/*:subfield[@code = 'f']" mode="phase3">
    <subfield>
      <xsl:copy-of select="@*"/>
      <xsl:choose>
        <xsl:when test="matches(., '^[a-zA-Z][a-zA-Z]$')">
          <xsl:value-of select="concat(lower-case(.), ' ')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="replace(lower-case(.), 'fre', 'fr ')"/>
        </xsl:otherwise>
      </xsl:choose>      
    </subfield>
  </xsl:template>

  <!-- Repair subfield 6 and indicators on 880 -->
  <xsl:template match="*:datafield[@tag = '880']" mode="phase3">
    <datafield>
      <xsl:variable name="subfields">
        <xsl:for-each select="*:subfield">
          <xsl:choose>
            <xsl:when test="@code = '6'">
              <subfield code="6">
              <xsl:choose>
                <!-- 3 tokens (2 slashes) -->
                <xsl:when test="count(tokenize(normalize-space(.), '/')) = 3">
                  <xsl:variable name="linkedTag">
                    <xsl:value-of select="normalize-space(tokenize(., '/')[1])"/>
                  </xsl:variable>
                  <xsl:variable name="linkingTag">
                    <xsl:value-of select="concat('880-', substring-after($linkedTag, '-'))"/>
                  </xsl:variable>
                  <xsl:variable name="script">
                    <xsl:value-of select="normalize-space(tokenize(., '/')[2])"/>
                  </xsl:variable>
                  <xsl:variable name="direction">
                    <xsl:value-of select="normalize-space(tokenize(., '/')[3])"/>
                  </xsl:variable>
                  <!-- Output the component tokens -->
                  <!-- Tag linked to -->
                  <xsl:value-of select="$linkedTag"/>
                  <!--<xsl:choose>
                    <!-\- When linking tag was a 490 that got changed to 440 -\->
                    <xsl:when test="matches($linkedTag, '^490') and ancestor::*:record/*:datafield[matches(*:subfield[@code = '6'], $linkingTag)]/@tag = '440'">
                      <xsl:value-of select="concat('440-', substring-after($linkedTag, '-'))"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$linkedTag"/>
                    </xsl:otherwise>
                  </xsl:choose>-->
                  <!-- Script code -->
                  <xsl:choose>
                    <!-- MARC-compliant script code -->
                    <xsl:when test="matches($script, '^(\([BNS23]|\$1|\d{3}|[A-Za-z]{4})$')">
                      <xsl:value-of select="concat('/', $script)"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>/Zyyy</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                  <!-- Direction -->
                  <xsl:if test="normalize-space($direction) ne ''">
                    <xsl:text>/r</xsl:text>
                  </xsl:if>
                </xsl:when>
                <!-- 2 tokens (1 slash) -->
                <xsl:when test="count(tokenize(normalize-space(.), '/')) = 2">
                  <xsl:variable name="linkedTag">
                    <xsl:value-of select="normalize-space(tokenize(., '/')[1])"/>
                  </xsl:variable>
                  <xsl:variable name="linkingTag">
                    <xsl:value-of select="concat('880-', substring-after($linkedTag, '-'))"/>
                  </xsl:variable>
                  <xsl:variable name="token2">
                    <xsl:value-of select="normalize-space(tokenize(., '/')[2])"/>
                  </xsl:variable>
                  <xsl:choose>
                    <!-- When linking tag was a 490 that got changed to 440 -->
                    <xsl:when test="matches($linkedTag, '^490') and ancestor::*:record/*:datafield[matches(*:subfield[@code = '6'], $linkingTag)]/@tag = '440'">
                      <xsl:value-of select="concat('440-', substring-after($linkedTag, '-'))"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$linkedTag"/>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                    <!-- $token2 contains script code -->
                    <xsl:when test="matches($token2, '^(\([BNS23]|\$1|\d{3}|[A-Za-z]{4})$')">
                      <xsl:value-of select="concat('/', $token2)"/>
                    </xsl:when>
                    <!-- $token2 contains direction indicator -->
                    <xsl:otherwise>
                      <xsl:text>/Zyyy/r</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <!-- 1 token (no slashes) -->
                <xsl:when test="count(tokenize(normalize-space(.), '/')) = 1">
                  <xsl:analyze-string select="." regex="^(\d\d\d-\d\d)(.*)$">
                    <xsl:matching-substring>
                      <xsl:value-of select="regex-group(1)"/>
                      <xsl:choose>
                        <!-- script code & direction present -->
                        <xsl:when test="matches(regex-group(2), '^.+r$')">
                          <xsl:value-of select="concat('/', substring-before(regex-group(2), 'r'), '/r')"/>
                        </xsl:when>
                        <!-- script code missing, direction present -->
                        <xsl:when test="matches(regex-group(2), '^r$')">
                          <xsl:text>/Zyyy/r</xsl:text>
                        </xsl:when>
                        <!-- script code present, direction missing -->
                        <xsl:when test="matches(regex-group(2), '.+')">
                          <xsl:value-of select="concat('/', regex-group(2))"/>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:matching-substring>
                  </xsl:analyze-string>
                </xsl:when>
                <!-- More than 3 tokens: pass the error along -->
                <xsl:otherwise>
                  <xsl:value-of select="."/>
                </xsl:otherwise>
              </xsl:choose>
            </subfield>
            </xsl:when>
            <xsl:otherwise>
              <xsl:copy-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:variable>
      <xsl:apply-templates select="@tag"/>
      <xsl:choose>
        <xsl:when test="matches($subfields/*:subfield[@code = '6'], '/')">
          <xsl:variable name="linkingField">
            <xsl:value-of select="substring-before($subfields/*:subfield[@code = '6'], '/')"/>
          </xsl:variable>
          <xsl:variable name="linkingTag">
            <xsl:value-of select="substring-before($linkingField, '-')"/>
          </xsl:variable>
          <xsl:variable name="occurrenceNum">
            <xsl:value-of select="substring-after($linkingField, '-')"/>
          </xsl:variable>
          <xsl:variable name="linkedField">
            <xsl:value-of select="concat('880-', $occurrenceNum)"/>
          </xsl:variable>
          <xsl:choose>
            <!-- Linked field doesn't exist; use indicators as they are -->
            <xsl:when
              test="$occurrenceNum = '00' or not(ancestor::*:record/*:datafield[matches(@tag, $linkingTag) and matches(*:subfield[@code = '6'], $linkedField)])">
              <xsl:apply-templates select="@ind1"/>
              <xsl:apply-templates select="@ind2"/>
            </xsl:when>
            <xsl:otherwise>
              <!-- Use indicators from linked field -->
              <xsl:attribute name="ind1">
                <xsl:value-of
                  select="ancestor::*:record/*:datafield[matches(@tag, $linkingTag) and matches(*:subfield[@code = '6'], $linkedField)]/@ind1"
                />
              </xsl:attribute>
              <xsl:attribute name="ind2">
                <xsl:value-of
                  select="ancestor::*:record/*:datafield[matches(@tag, $linkingTag) and matches(*:subfield[@code = '6'], $linkedField)]/@ind2"
                />
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Malformed subfield 6, use indicators as they are -->
        <xsl:otherwise>
          <xsl:apply-templates select="@ind1"/>
          <xsl:apply-templates select="@ind2"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:copy-of select="$subfields"/>
    </datafield>
  </xsl:template>

  <!-- Delete no-longer-needed 999s -->
  <xsl:template match="*:datafield[@tag = '999']" mode="phase3">
    <xsl:choose>
      <xsl:when test="matches($keep999s, 'true', 'i')">
        <xsl:copy-of select="."/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- DEFAULT TEMPLATE -->
  <!-- Identity template -->
  <xsl:template match="element() | processing-instruction() | comment() | @*" mode="#all">
    <xsl:copy exclude-result-prefixes="xs">
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:apply-templates mode="#current"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
