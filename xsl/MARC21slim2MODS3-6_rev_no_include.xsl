<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.loc.gov/mods/v3" xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc" version="2.0">

  <!-- This stylesheet is based on MARC21slim2MODS3-6, available at
    https://www.loc.gov/standards/mods/v3/MARC21slim2MODS3-6-2016.xsl. -->

  <!-- <xsl:include href="MARC21slimUtils.xsl"/> -->
  <!-- MARC21slimUtils.xsl physically included -->
  <xsl:variable name="ascii">
    <xsl:text> !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~</xsl:text>
  </xsl:variable>
  <xsl:variable name="latin1">
    <xsl:text> ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ</xsl:text>
  </xsl:variable>
  <xsl:variable name="safe">
    <xsl:text>!'()*-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~</xsl:text>
  </xsl:variable>
  <xsl:variable name="hex">0123456789ABCDEF</xsl:variable>
  <xsl:template name="datafield">
    <xsl:param name="tag"/>
    <xsl:param name="ind1">
      <xsl:text> </xsl:text>
    </xsl:param>
    <xsl:param name="ind2">
      <xsl:text> </xsl:text>
    </xsl:param>
    <xsl:param name="subfields"/>
    <xsl:element name="marc:datafield">
      <xsl:attribute name="tag">
        <xsl:value-of select="$tag"/>
      </xsl:attribute>
      <xsl:attribute name="ind1">
        <xsl:value-of select="$ind1"/>
      </xsl:attribute>
      <xsl:attribute name="ind2">
        <xsl:value-of select="$ind2"/>
      </xsl:attribute>
      <xsl:copy-of select="$subfields"/>
    </xsl:element>
  </xsl:template>
  <xsl:template name="subfieldSelect">
    <xsl:param name="codes">abcdefghijklmnopqrstuvwxyz</xsl:param>
    <xsl:param name="delimeter">
      <xsl:text> </xsl:text>
    </xsl:param>
    <xsl:variable name="str">
      <xsl:for-each select="marc:subfield">
        <xsl:if test="contains($codes, @code)">
          <xsl:value-of select="text()"/>
          <xsl:value-of select="$delimeter"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="substring($str, 1, string-length($str) - string-length($delimeter))"/>
  </xsl:template>
  <xsl:template name="buildSpaces">
    <xsl:param name="spaces"/>
    <xsl:param name="char">
      <xsl:text> </xsl:text>
    </xsl:param>
    <xsl:if test="$spaces &gt; 0">
      <xsl:value-of select="$char"/>
      <xsl:call-template name="buildSpaces">
        <xsl:with-param name="spaces" select="$spaces - 1"/>
        <xsl:with-param name="char" select="$char"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="chopPunctuation">
    <xsl:param name="chopString"/>
    <xsl:param name="punctuation">
      <xsl:text>.:,;/ </xsl:text>
    </xsl:param>
    <xsl:variable name="length" select="string-length($chopString)"/>
    <xsl:choose>
      <xsl:when test="$length = 0"/>
      <xsl:when test="contains($punctuation, substring($chopString, $length, 1))">
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString" select="substring($chopString, 1, $length - 1)"/>
          <xsl:with-param name="punctuation" select="$punctuation"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="not($chopString)"/>
      <xsl:otherwise>
        <xsl:value-of select="$chopString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="chopPunctuationFront">
    <xsl:param name="chopString"/>
    <xsl:variable name="length" select="string-length($chopString)"/>
    <xsl:choose>
      <xsl:when test="$length = 0"/>
      <xsl:when test="contains('.:,;/[ ', substring($chopString, 1, 1))">
        <xsl:call-template name="chopPunctuationFront">
          <xsl:with-param name="chopString" select="substring($chopString, 2, $length - 1)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="not($chopString)"/>
      <xsl:otherwise>
        <xsl:value-of select="$chopString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="chopPunctuationBack">
    <xsl:param name="chopString"/>
    <xsl:param name="punctuation">
      <xsl:text>.:,;/] </xsl:text>
    </xsl:param>
    <xsl:variable name="length" select="string-length($chopString)"/>
    <xsl:choose>
      <xsl:when test="$length = 0"/>
      <xsl:when test="contains($punctuation, substring($chopString, $length, 1))">
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString" select="substring($chopString, 1, $length - 1)"/>
          <xsl:with-param name="punctuation" select="$punctuation"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="not($chopString)"/>
      <xsl:otherwise>
        <xsl:value-of select="$chopString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="url-encode">

    <xsl:param name="str"/>

    <xsl:if test="$str">
      <xsl:variable name="first-char" select="substring($str, 1, 1)"/>
      <xsl:choose>
        <xsl:when test="contains($safe, $first-char)">
          <xsl:value-of select="$first-char"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="codepoint">
            <xsl:choose>
              <xsl:when test="contains($ascii, $first-char)">
                <xsl:value-of select="string-length(substring-before($ascii, $first-char)) + 32"/>
              </xsl:when>
              <xsl:when test="contains($latin1, $first-char)">
                <xsl:value-of select="string-length(substring-before($latin1, $first-char)) + 160"/>
                <!-- was 160 -->
              </xsl:when>
              <xsl:otherwise>
                <xsl:message terminate="no">Warning: string contains a character that is out of
                  range! Substituting "?".</xsl:message>
                <xsl:text>63</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="hex-digit1" select="substring($hex, floor($codepoint div 16) + 1, 1)"/>
          <xsl:variable name="hex-digit2" select="substring($hex, $codepoint mod 16 + 1, 1)"/>
          <!-- <xsl:value-of select="concat('%',$hex-digit2)"/> -->
          <xsl:value-of select="concat('%', $hex-digit1, $hex-digit2)"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="string-length($str) &gt; 1">
        <xsl:call-template name="url-encode">
          <xsl:with-param name="str" select="substring($str, 2)"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- <xsl:include href="marcPerfMediumMap.xsl"/> -->
  <!-- marcPerfMediumMap.xsl physically included -->
  <xsl:variable xmlns:xs="http://www.w3.org/2001/XMLSchema" name="marcPerfMediumMap">
    <instrVoice code="ba" marcValue="brass - horn">horn</instrVoice>
    <instrVoice code="bb" marcValue="brass - trumpet">trumpet</instrVoice>
    <instrVoice code="bc" marcValue="brass - cornet">cornet</instrVoice>
    <instrVoice code="bd" marcValue="brass - trombone">trombone</instrVoice>
    <instrVoice code="be" marcValue="brass - tuba">tuba</instrVoice>
    <instrVoice code="bf" marcValue="brass - baritone">baritone horn</instrVoice>
    <instrVoice code="bn" marcValue="brass - unspecified">brass instrument</instrVoice>
    <instrVoice code="bu" marcValue="brass - unknown">brass instrument</instrVoice>
    <instrVoice code="by" marcValue="brass - ethnic brass">brass instrument</instrVoice>
    <instrVoice code="bz" marcValue="brass - other">brass instrument</instrVoice>
    <instrVoice code="ca" marcValue="choruses - mixed">mixed chorus</instrVoice>
    <instrVoice code="cb" marcValue="choruses - women's">women's chorus</instrVoice>
    <instrVoice code="cc" marcValue="choruses - men's">men's chorus</instrVoice>
    <instrVoice code="cd" marcValue="choruses - children's">children's chorus</instrVoice>
    <instrVoice code="cn" marcValue="choruses - unspecified">chorus</instrVoice>
    <instrVoice code="cu" marcValue="choruses - unknown">chorus</instrVoice>
    <instrVoice code="cy" marcValue="choruses - ethnic">chorus</instrVoice>
    <instrVoice code="ea" marcValue="electronic - synthesizer">synthesizer</instrVoice>
    <instrVoice code="eb" marcValue="electronic - tape">pre-recorded audio</instrVoice>
    <instrVoice code="ec" marcValue="electronic - computer">computer</instrVoice>
    <instrVoice code="ed" marcValue="electronic - ondes martinot">ondes Martinot</instrVoice>
    <instrVoice code="en" marcValue="electronic - unspecified">electronic instrument</instrVoice>
    <instrVoice code="eu" marcValue="electronic - unknown">electronic instrument</instrVoice>
    <instrVoice code="ez" marcValue="electronic - other">electronic instrument</instrVoice>
    <instrVoice code="ka" marcValue="keyboard - piano">piano</instrVoice>
    <instrVoice code="kb" marcValue="keyboard - organ">organ</instrVoice>
    <instrVoice code="kc" marcValue="keyboard - harpsichord">harpsichord</instrVoice>
    <instrVoice code="kd" marcValue="keyboard - clavichord">clavichord</instrVoice>
    <instrVoice code="ke" marcValue="keyboard - continuo">continuo</instrVoice>
    <instrVoice code="kf" marcValue="keyboard - celeste">celesta</instrVoice>
    <instrVoice code="kn" marcValue="keyboard - unspecified">keyboard instrument</instrVoice>
    <instrVoice code="ku" marcValue="keyboard - unknown">keyboard instrument</instrVoice>
    <instrVoice code="ky" marcValue="keyboard - ethnic">keyboard instrument</instrVoice>
    <instrVoice code="kz" marcValue="keyboard - other">keyboard instrument</instrVoice>
    <instrVoice code="oa" marcValue="larger ensemble - full orchestra">orchestra</instrVoice>
    <instrVoice code="ob" marcValue="larger ensemble - chamber orchestra">chamber
      orchestra</instrVoice>
    <instrVoice code="oc" marcValue="larger ensemble - string orchestra">string
      orchestra</instrVoice>
    <instrVoice code="od" marcValue="larger ensemble - band">band</instrVoice>
    <instrVoice code="oe" marcValue="larger ensemble - dance orchestra">dance orchestra</instrVoice>
    <instrVoice code="of" marcValue="larger ensemble - brass band">brass band</instrVoice>
    <instrVoice code="on" marcValue="larger ensemble - unspecified">ensemble</instrVoice>
    <instrVoice code="ou" marcValue="larger ensemble - unknown">ensemble</instrVoice>
    <instrVoice code="oy" marcValue="larger ensemble - ethnic">ensemble</instrVoice>
    <instrVoice code="oz" marcValue="larger ensemble - other">ensemble</instrVoice>
    <instrVoice code="pa" marcValue="percussion - timpani">timpani</instrVoice>
    <instrVoice code="pb" marcValue="percussion - xylophone">xylophone</instrVoice>
    <instrVoice code="pc" marcValue="percussion - marimba">marimba</instrVoice>
    <instrVoice code="pd" marcValue="percussion - drum">drum</instrVoice>
    <instrVoice code="pn" marcValue="percussion - unspecified">percussion</instrVoice>
    <instrVoice code="pu" marcValue="percussion - unknown">percussion</instrVoice>
    <instrVoice code="py" marcValue="percussion - ethnic">percussion</instrVoice>
    <instrVoice code="pz" marcValue="percussion - other">percussion</instrVoice>
    <instrVoice code="sa" marcValue="strings, bowed - violin">violin</instrVoice>
    <instrVoice code="sb" marcValue="strings, bowed - viola">viola</instrVoice>
    <instrVoice code="sc" marcValue="strings, bowed - violoncello">violoncello</instrVoice>
    <instrVoice code="sd" marcValue="strings, bowed - double bass">double bass</instrVoice>
    <instrVoice code="se" marcValue="strings, bowed - viol">viol</instrVoice>
    <instrVoice code="sf" marcValue="strings, bowed - viola d'amore">viola d'amore</instrVoice>
    <instrVoice code="sg" marcValue="strings, bowed - viola da gamba">viola da gamba</instrVoice>
    <instrVoice code="sn" marcValue="strings, bowed - unspecified">bowed string
      instrument</instrVoice>
    <instrVoice code="su" marcValue="strings, bowed - unknown">bowed string instrument</instrVoice>
    <instrVoice code="sy" marcValue="strings, bowed - ethnic">bowed string instrument</instrVoice>
    <instrVoice code="sz" marcValue="strings, bowed - other">bowed string instrument</instrVoice>
    <instrVoice code="ta" marcValue="strings, plucked - harp">harp</instrVoice>
    <instrVoice code="tb" marcValue="strings, plucked - guitar">guitar</instrVoice>
    <instrVoice code="tc" marcValue="strings, plucked - lute">lute</instrVoice>
    <instrVoice code="td" marcValue="strings, plucked - mandolin">mandolin</instrVoice>
    <instrVoice code="tn" marcValue="strings, plucked - unspecified">plucked stringed
      instrument</instrVoice>
    <instrVoice code="tu" marcValue="strings, plucked - unknown">plucked stringed
      instrument</instrVoice>
    <instrVoice code="ty" marcValue="strings, plucked - ethnic">plucked stringed
      instrument</instrVoice>
    <instrVoice code="tz" marcValue="strings, plucked - other">plucked stringed
      instrument</instrVoice>
    <instrVoice code="va" marcValue="voices - soprano">soprano voice</instrVoice>
    <instrVoice code="vb" marcValue="voices - mezzo soprano">mezzo-soprano voice</instrVoice>
    <instrVoice code="vc" marcValue="voices - alto">alto voice</instrVoice>
    <instrVoice code="vd" marcValue="voices - tenor">tenor voice</instrVoice>
    <instrVoice code="ve" marcValue="voices - baritone">baritone voice</instrVoice>
    <instrVoice code="vf" marcValue="voices - bass">bass voice</instrVoice>
    <instrVoice code="vg" marcValue="voices - counter tenor">countertenor voice</instrVoice>
    <instrVoice code="vh" marcValue="voices - high voice">high voice</instrVoice>
    <instrVoice code="vi" marcValue="voices - medium voice">medium voice</instrVoice>
    <instrVoice code="vj" marcValue="voices - low voice">low voice</instrVoice>
    <instrVoice code="vn" marcValue="voices - unspecified">voice</instrVoice>
    <instrVoice code="vu" marcValue="voices - unknown">voice</instrVoice>
    <instrVoice code="vy" marcValue="voices - ethnic">voice</instrVoice>
    <instrVoice code="wa" marcValue="woodwinds - flute">flute</instrVoice>
    <instrVoice code="wb" marcValue="woodwinds - oboe">oboe</instrVoice>
    <instrVoice code="wc" marcValue="woodwinds - clarinet">clarinet</instrVoice>
    <instrVoice code="wd" marcValue="woodwinds - bassoon">bassoon</instrVoice>
    <instrVoice code="we" marcValue="woodwinds - piccolo">piccolo</instrVoice>
    <instrVoice code="wf" marcValue="woodwinds - english horn">English horn</instrVoice>
    <instrVoice code="wg" marcValue="woodwinds - bass clarinet">bass clarinet</instrVoice>
    <instrVoice code="wh" marcValue="woodwinds - recorder">recorder</instrVoice>
    <instrVoice code="wi" marcValue="woodwinds - saxophone">saxophone</instrVoice>
    <instrVoice code="wn" marcValue="woodwinds - unspecified">wood-wind instrument</instrVoice>
    <instrVoice code="wu" marcValue="woodwinds - unknown">wood-wind instrument</instrVoice>
    <instrVoice code="wy" marcValue="woodwinds - ethnic">wood-wind instrument</instrVoice>
    <instrVoice code="wz" marcValue="woodwinds - other">wood-wind instrument</instrVoice>
    <instrVoice code="zn" marcValue="unspecified instruments">unspecified instrument</instrVoice>
    <instrVoice code="zu" marcValue="unknown instruments">instrument</instrVoice>
  </xsl:variable>

  <xsl:output encoding="UTF-8" indent="yes" method="xml" xml:space="preserve"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="barcode" select="''"/>

  <xsl:param name="redact541" select="'true'"/>

  <xsl:param name="createSubjectFrom043" select="'true'"/>

  <xsl:variable name="notePrefix">uvax-</xsl:variable>

  <!-- Maintenance note: For each revision, change the content of $progVersion to reflect the 
    latest revision number. -->
  <xsl:variable name="progName">MARC21slim2MODS3-6_rev_no_include.xsl</xsl:variable>
  <xsl:variable name="progVersion">2.0</xsl:variable>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="//*:collection">
        <modsCollection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <!--xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-6.xsd"-->
          <xsl:for-each select="//*:collection/*:record[not(ancestor::*:record)]">
            <mods version="3.6">
              <xsl:call-template name="marcRecord"/>
            </mods>
          </xsl:for-each>
        </modsCollection>
      </xsl:when>
      <xsl:otherwise>
        <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.6">
          <!--xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-6.xsd"-->
          <xsl:for-each select="//*:record[not(ancestor::*:record)]">
            <xsl:call-template name="marcRecord"/>
          </xsl:for-each>
        </mods>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="marcRecord">
    <xsl:variable name="leader" select="*:leader"/>
    <xsl:variable name="leader6" select="substring($leader, 7, 1)"/>
    <xsl:variable name="leader7" select="substring($leader, 8, 1)"/>
    <xsl:variable name="leader19" select="substring($leader, 20, 1)"/>
    <xsl:variable name="controlField008" select="*:controlfield[@tag = '008']"/>
    <xsl:variable name="typeOf008">
      <xsl:choose>
        <xsl:when test="$leader6 = 'a'">
          <xsl:choose>
            <xsl:when test="$leader7 = 'a' or $leader7 = 'c' or $leader7 = 'd' or $leader7 = 'm'"
              >BK</xsl:when>
            <xsl:when test="$leader7 = 'b' or $leader7 = 'i' or $leader7 = 's'">SE</xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="$leader6 = 't'">BK</xsl:when>
        <xsl:when test="$leader6 = 'p'">MM</xsl:when>
        <xsl:when test="$leader6 = 'm'">CF</xsl:when>
        <xsl:when test="$leader6 = 'e' or $leader6 = 'f'">MP</xsl:when>
        <xsl:when test="$leader6 = 'g' or $leader6 = 'k' or $leader6 = 'o' or $leader6 = 'r'"
          >VM</xsl:when>
        <xsl:when test="$leader6 = 'c' or $leader6 = 'd' or $leader6 = 'i' or $leader6 = 'j'"
          >MU</xsl:when>
      </xsl:choose>
    </xsl:variable>

    <!-- titleInfo -->
    <xsl:for-each select="*:datafield[@tag = '245']">
      <xsl:call-template name="createTitleInfoFrom245"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '210']">
      <xsl:call-template name="createTitleInfoFrom210"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '246']">
      <xsl:call-template name="createTitleInfoFrom246"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '240']">
      <xsl:call-template name="createTitleInfoFrom240"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '740']">
      <xsl:call-template name="createTitleInfoFrom740"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '130']">
      <xsl:call-template name="createTitleInfoFrom130"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '730'][@ind2 eq '2']">
      <xsl:call-template name="createTitleInfoFrom730"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '242']">
      <titleInfo type="translated">
        <xsl:for-each select="*:subfield[@code = 'y']">
          <xsl:attribute name="lang">
            <xsl:value-of select="text()"/>
          </xsl:attribute>
        </xsl:for-each>

        <xsl:variable name="title">
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">a</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="titleChop">
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:value-of select="$title"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="number(@ind2) &gt; 0">
            <nonSort xml:space="preserve"><xsl:value-of select="substring($titleChop, 1, @ind2)"/> </nonSort>
            <title>
              <xsl:value-of select="substring($titleChop, @ind2 + 1)"/>
            </title>
          </xsl:when>
          <xsl:otherwise>
            <title>
              <xsl:value-of select="$titleChop"/>
            </title>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:call-template name="subtitle"/>
        <xsl:call-template name="part"/>
      </titleInfo>
    </xsl:for-each>

    <!-- name -->
    <xsl:for-each select="*:datafield[@tag = '100'][not(*:subfield[@code = 't'])]">
      <xsl:call-template name="createNameFrom100"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '110'][not(*:subfield[@code = 't'])]">
      <xsl:call-template name="createNameFrom110"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '111'][not(*:subfield[@code = 't'])]">
      <xsl:call-template name="createNameFrom111"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '700'][not(*:subfield[@code = 't'])]">
      <xsl:call-template name="createNameFrom700"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '710'][not(*:subfield[@code = 't'])]">
      <xsl:call-template name="createNameFrom710"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '711'][not(*:subfield[@code = 't'])]">
      <xsl:call-template name="createNameFrom711"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '720'][not(*:subfield[@code = 't'])]">
      <xsl:call-template name="createNameFrom720"/>
    </xsl:for-each>

    <!-- typeOfResource -->
    <typeOfResource>
      <xsl:if test="$leader7 = 'c'">
        <xsl:attribute name="collection">yes</xsl:attribute>
      </xsl:if>
      <xsl:if test="$leader6 = 'd' or $leader6 = 'f' or $leader6 = 'p' or $leader6 = 't'">
        <xsl:attribute name="manuscript">yes</xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="$leader6 = 'a' or $leader6 = 't'">text</xsl:when>
        <xsl:when test="$leader6 = 'e' or $leader6 = 'f'">cartographic</xsl:when>
        <xsl:when test="$leader6 = 'c' or $leader6 = 'd'">notated music</xsl:when>
        <xsl:when test="$leader6 = 'i'">sound recording-nonmusical</xsl:when>
        <xsl:when test="$leader6 = 'j'">sound recording-musical</xsl:when>
        <xsl:when test="$leader6 = 'k'">still image</xsl:when>
        <xsl:when test="$leader6 = 'g'">moving image</xsl:when>
        <xsl:when test="$leader6 = 'r'">three dimensional object</xsl:when>
        <xsl:when test="$leader6 = 'm'">software, multimedia</xsl:when>
        <xsl:when test="$leader6 = 'p'">mixed material</xsl:when>
      </xsl:choose>
    </typeOfResource>

    <!-- genre from control fields -->
    <xsl:if test="substring($controlField008, 26, 1) = 'd'">
      <genre authority="marcgt">globe</genre>
    </xsl:if>
    <xsl:if
      test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'r']">
      <genre authority="marcgt">remote-sensing image</genre>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'MP'">
      <xsl:variable name="controlField008-25" select="substring($controlField008, 26, 1)"/>
      <xsl:choose>
        <xsl:when
          test="$controlField008-25 = 'a' or $controlField008-25 = 'b' or $controlField008-25 = 'c' or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'j']">
          <genre authority="marcgt">map</genre>
        </xsl:when>
        <xsl:when
          test="$controlField008-25 = 'e' or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'd']">
          <genre authority="marcgt">atlas</genre>
        </xsl:when>
      </xsl:choose>
      <xsl:variable name="controlField008-33-34" select="substring($controlField008, 34, 2)"/>
      <xsl:if test="contains($controlField008-33-34, 'j')">
        <genre authority="marcgt">postcards</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-33-34, 'k')">
        <genre authority="marcgt">calendars</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-33-34, 'l')">
        <genre authority="marcgt">puzzles and games</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-33-34, 'n')">
        <genre authority="marcgt">puzzles and games</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-33-34, 'o')">
        <genre authority="marcgt">wall maps</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-33-34, 'p')">
        <genre authority="marcgt">playing cards</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-33-34, 'r')">
        <genre authority="marcgt">loose-leaf</genre>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'SE'">
      <xsl:variable name="controlField008-21" select="substring($controlField008, 22, 1)"/>
      <xsl:choose>
        <xsl:when test="$controlField008-21 = 'd'">
          <genre authority="marcgt">database</genre>
        </xsl:when>
        <xsl:when test="$controlField008-21 = 'l'">
          <genre authority="marcgt">loose-leaf</genre>
        </xsl:when>
        <xsl:when test="$controlField008-21 = 'm'">
          <genre authority="marcgt">series</genre>
        </xsl:when>
        <xsl:when test="$controlField008-21 = 'n'">
          <genre authority="marcgt">newspaper</genre>
        </xsl:when>
        <xsl:when test="$controlField008-21 = 'p'">
          <genre authority="marcgt">periodical</genre>
        </xsl:when>
        <xsl:when test="$controlField008-21 = 'w'">
          <genre authority="marcgt">web site</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'BK' or $typeOf008 = 'SE'">
      <xsl:variable name="controlField008-24" select="substring($controlField008, 25, 4)"/>
      <xsl:choose>
        <xsl:when test="contains($controlField008-24, 'a')">
          <genre authority="marcgt">abstract or summary</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'b')">
          <genre authority="marcgt">bibliography</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'c')">
          <genre authority="marcgt">catalog</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'd')">
          <genre authority="marcgt">dictionary</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'e')">
          <genre authority="marcgt">encyclopedia</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'f')">
          <genre authority="marcgt">handbook</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'g')">
          <genre authority="marcgt">legal article</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'i')">
          <genre authority="marcgt">index</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'k')">
          <genre authority="marcgt">discography</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'l')">
          <genre authority="marcgt">legislation</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'm')">
          <genre authority="marcgt">theses</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'n')">
          <genre authority="marcgt">survey of literature</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'o')">
          <genre authority="marcgt">review</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'p')">
          <genre authority="marcgt">programmed text</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'q')">
          <genre authority="marcgt">filmography</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'r')">
          <genre authority="marcgt">directory</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 's')">
          <genre authority="marcgt">statistics</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 't')">
          <genre authority="marcgt">technical report</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'v')">
          <genre authority="marcgt">legal case and case notes</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'w')">
          <genre authority="marcgt">law report or digest</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-24, 'z')">
          <genre authority="marcgt">treaty</genre>
        </xsl:when>
      </xsl:choose>
      <xsl:variable name="controlField008-29" select="substring($controlField008, 30, 1)"/>
      <xsl:choose>
        <xsl:when test="$controlField008-29 = '1'">
          <genre authority="marcgt">conference publication</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'CF'">
      <xsl:variable name="controlField008-26" select="substring($controlField008, 27, 1)"/>
      <xsl:choose>
        <xsl:when test="$controlField008-26 = 'a'">
          <genre authority="marcgt">numeric data</genre>
        </xsl:when>
        <xsl:when test="$controlField008-26 = 'e'">
          <genre authority="marcgt">database</genre>
        </xsl:when>
        <xsl:when test="$controlField008-26 = 'f'">
          <genre authority="marcgt">font</genre>
        </xsl:when>
        <xsl:when test="$controlField008-26 = 'g'">
          <genre authority="marcgt">game</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'BK'">
      <xsl:if test="substring($controlField008, 25, 1) = 'j'">
        <genre authority="marcgt">patent</genre>
      </xsl:if>
      <xsl:if test="substring($controlField008, 25, 1) = '2'">
        <genre authority="marcgt">offprint</genre>
      </xsl:if>
      <xsl:if test="substring($controlField008, 31, 1) = '1'">
        <genre authority="marcgt">festschrift</genre>
      </xsl:if>
      <xsl:variable name="controlField008-34" select="substring($controlField008, 35, 1)"/>
      <xsl:if
        test="$controlField008-34 = 'a' or $controlField008-34 = 'b' or $controlField008-34 = 'c' or $controlField008-34 = 'd'">
        <genre authority="marcgt">biography</genre>
      </xsl:if>
      <xsl:variable name="controlField008-33" select="substring($controlField008, 34, 1)"/>
      <xsl:choose>
        <xsl:when test="$controlField008-33 = 'e'">
          <genre authority="marcgt">essay</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'd'">
          <genre authority="marcgt">drama</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'c'">
          <genre authority="marcgt">comic strip</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = '1'">
          <genre authority="marcgt">fiction</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'h'">
          <genre authority="marcgt">humor, satire</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'i'">
          <genre authority="marcgt">letter</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'f'">
          <genre authority="marcgt">novel</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'j'">
          <genre authority="marcgt">short story</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 's'">
          <genre authority="marcgt">speech</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'MU'">
      <xsl:variable name="controlField008-30-31" select="substring($controlField008, 31, 2)"/>
      <xsl:if test="contains($controlField008-30-31, 'b')">
        <genre authority="marcgt">biography</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'c')">
        <genre authority="marcgt">conference publication</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'd')">
        <genre authority="marcgt">drama</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'e')">
        <genre authority="marcgt">essay</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'f')">
        <genre authority="marcgt">fiction</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'o')">
        <genre authority="marcgt">folktale</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'h')">
        <genre authority="marcgt">history</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'k')">
        <genre authority="marcgt">humor, satire</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'm')">
        <genre authority="marcgt">memoir</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'p')">
        <genre authority="marcgt">poetry</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'r')">
        <genre authority="marcgt">rehearsal</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'g')">
        <genre authority="marcgt">reporting</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 's')">
        <genre authority="marcgt">sound</genre>
      </xsl:if>
      <xsl:if test="contains($controlField008-30-31, 'l')">
        <genre authority="marcgt">speech</genre>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'VM'">
      <xsl:variable name="controlField008-33" select="substring($controlField008, 34, 1)"/>
      <xsl:choose>
        <xsl:when test="$controlField008-33 = 'a'">
          <genre authority="marcgt">art original</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'b'">
          <genre authority="marcgt">kit</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'c'">
          <genre authority="marcgt">art reproduction</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'd'">
          <genre authority="marcgt">diorama</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'f'">
          <genre authority="marcgt">filmstrip</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'g'">
          <genre authority="marcgt">legal article</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'i'">
          <genre authority="marcgt">picture</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'k'">
          <genre authority="marcgt">graphic</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'l'">
          <genre authority="marcgt">technical drawing</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'm'">
          <genre authority="marcgt">motion picture</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'n'">
          <genre authority="marcgt">chart</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'o'">
          <genre authority="marcgt">flash card</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'p'">
          <genre authority="marcgt">microscope slide</genre>
        </xsl:when>
        <xsl:when
          test="$controlField008-33 = 'q' or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'q']">
          <genre authority="marcgt">model</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'r'">
          <genre authority="marcgt">realia</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 's'">
          <genre authority="marcgt">slide</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 't'">
          <genre authority="marcgt">transparency</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'v'">
          <genre authority="marcgt">videorecording</genre>
        </xsl:when>
        <xsl:when test="$controlField008-33 = 'w'">
          <genre authority="marcgt">toy</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'BK'">
      <xsl:variable name="controlField008-28" select="substring($controlField008, 29, 1)"/>
      <xsl:choose>
        <xsl:when test="contains($controlField008-28, 'a')">
          <genre authority="marcgt">Government publication, Autonomous or semi-autonomous
            component</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'c')">
          <genre authority="marcgt">Government publication, Multilocal</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'f')">
          <genre authority="marcgt">Government publication, Federal/national</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'i')">
          <genre authority="marcgt">Government publication, International intergovernmental</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'l')">
          <genre authority="marcgt">Government publication, Local</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'm')">
          <genre authority="marcgt">Government publication, Multistate</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'o')">
          <genre authority="marcgt">Government publication, Government publication-level
            undetermined</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 's')">
          <genre authority="marcgt">Government publication, State, provincial, territorial,
            dependent, etc.</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'z')">
          <genre authority="marcgt">Government publication, Other</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'CF'">
      <xsl:variable name="controlField008-28" select="substring($controlField008, 29, 1)"/>
      <xsl:choose>
        <xsl:when test="contains($controlField008-28, 'a')">
          <genre authority="marcgt">Government publication, Autonomous or semi-autonomous
            component</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'c')">
          <genre authority="marcgt">Government publication, Multilocal</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'f')">
          <genre authority="marcgt">Government publication, Federal/national</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'i')">
          <genre authority="marcgt">Government publication, International intergovernmental</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'l')">
          <genre authority="marcgt">Government publication, Local</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'm')">
          <genre authority="marcgt">Government publication, Multistate</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'o')">
          <genre authority="marcgt">Government publication, Government publication-level
            undetermined</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 's')">
          <genre authority="marcgt">Government publication, State, provincial, territorial,
            dependent, etc.</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'z')">
          <genre authority="marcgt">Government publication, Other</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'SE'">
      <xsl:variable name="controlField008-28" select="substring($controlField008, 29, 1)"/>
      <xsl:choose>
        <xsl:when test="contains($controlField008-28, 'a')">
          <genre authority="marcgt">Government publication, Autonomous or semi-autonomous
            component</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'c')">
          <genre authority="marcgt">Government publication, Multilocal</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'f')">
          <genre authority="marcgt">Government publication, Federal/national</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'i')">
          <genre authority="marcgt">Government publication, International intergovernmental</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'l')">
          <genre authority="marcgt">Government publication, Local</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'm')">
          <genre authority="marcgt">Government publication, Multistate</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'o')">
          <genre authority="marcgt">Government publication, Level undetermined</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 's')">
          <genre authority="marcgt">Government publication, State, provincial, territorial,
            dependent, etc.</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'z')">
          <genre authority="marcgt">Government publication, Other</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'MP'">
      <xsl:variable name="controlField008-28" select="substring($controlField008, 29, 1)"/>
      <xsl:choose>
        <xsl:when test="contains($controlField008-28, 'a')">
          <genre authority="marcgt">Government publication, Autonomous or semi-autonomous
            component</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'c')">
          <genre authority="marcgt">Government publication, Multilocal</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'f')">
          <genre authority="marcgt">Government publication, Federal/national</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'i')">
          <genre authority="marcgt">Government publication, International intergovernmental</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'l')">
          <genre authority="marcgt">Government publication, Local</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'm')">
          <genre authority="marcgt">Government publication, Multistate</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'o')">
          <genre authority="marcgt">Government publication, Government publication-level
            undetermined</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 's')">
          <genre authority="marcgt">Government publication, State, provincial, territorial,
            dependent, etc.</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'z')">
          <genre authority="marcgt">Government publication, Other</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$typeOf008 = 'VM'">
      <xsl:variable name="controlField008-28" select="substring($controlField008, 29, 1)"/>
      <xsl:choose>
        <xsl:when test="contains($controlField008-28, 'a')">
          <genre authority="marcgt">Government publication, Autonomous or semi-autonomous
            component</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'c')">
          <genre authority="marcgt">Government publication, Multilocal</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'f')">
          <genre authority="marcgt">Government publication, Federal/national</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'i')">
          <genre authority="marcgt">Government publication, International intergovernmental</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'l')">
          <genre authority="marcgt">Government publication, Local</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'm')">
          <genre authority="marcgt">Government publication, Multistate</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'o')">
          <genre authority="marcgt">Government publication, Government publication-level
            undetermined</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 's')">
          <genre authority="marcgt">Government publication, State, provincial, territorial,
            dependent, etc.</genre>
        </xsl:when>
        <xsl:when test="contains($controlField008-28, 'z')">
          <genre authority="marcgt">Government publication, Other</genre>
        </xsl:when>
      </xsl:choose>
    </xsl:if>

    <!-- genre from variable fields -->
    <xsl:for-each select="*:datafield[@tag eq '047']">
      <xsl:call-template name="createGenreFrom047"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag eq '336']">
      <xsl:call-template name="createGenreFrom336"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag eq '655']">
      <xsl:call-template name="createGenreFrom655"/>
    </xsl:for-each>

    <!-- originInfo -->
    <originInfo>
      <xsl:call-template name="scriptCode"/>
      <xsl:for-each select="*:datafield[@tag = '250' and *:subfield[@code = 'a' or code = 'b']]">
        <xsl:call-template name="z2xx880"/>
      </xsl:for-each>
      <xsl:for-each
        select="*:datafield[@tag = '260' and *:subfield[@code = 'a' or code = 'b' or @code = 'c' or code = 'g']]">
        <xsl:call-template name="z2xx880"/>
      </xsl:for-each>
      <xsl:variable name="MARCpublicationCode" select="substring($controlField008, 16, 3)"/>
      <xsl:if test="translate($MARCpublicationCode, '|', '')">
        <place>
          <placeTerm>
            <xsl:attribute name="type">code</xsl:attribute>
            <xsl:attribute name="authority">marccountry</xsl:attribute>
            <xsl:value-of select="$MARCpublicationCode"/>
          </placeTerm>
        </place>
      </xsl:if>
      <xsl:for-each select="*:datafield[@tag = '044']/*:subfield[@code = 'c']">
        <place>
          <placeTerm>
            <xsl:attribute name="type">code</xsl:attribute>
            <xsl:attribute name="authority">iso3166</xsl:attribute>
            <xsl:value-of select="."/>
          </placeTerm>
        </place>
      </xsl:for-each>
      <xsl:for-each select="*:datafield[@tag = '260']/*:subfield[@code = 'a']">
        <place>
          <placeTerm>
            <xsl:attribute name="type">text</xsl:attribute>
            <xsl:call-template name="chopPunctuationBack">
              <xsl:with-param name="chopString" select="."/>
              <xsl:with-param name="punctuation">
                <xsl:text>:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </placeTerm>
        </place>
      </xsl:for-each>
      <xsl:for-each select="*:datafield[@tag = '260']/*:subfield[@code = 'b']">
        <publisher>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString" select="."/>
            <xsl:with-param name="punctuation">
              <xsl:text>:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </publisher>
      </xsl:for-each>
      <xsl:for-each select="*:datafield[@tag = '046']/*:subfield[@code = 'm']">
        <dateValid encoding="edtf">
          <xsl:value-of select="replace(., '[u\?]', 'X')"/>
          <xsl:if test="../*:subfield[@code = 'n']">
            <xsl:value-of select="concat('/', replace(../*:subfield[@code = 'n'], '[u\?]', 'X'))"/>
          </xsl:if>
        </dateValid>
      </xsl:for-each>
      <xsl:for-each select="*:datafield[@tag = '046']/*:subfield[@code = 'j']">
        <dateModified>
          <xsl:value-of select="."/>
        </dateModified>
      </xsl:for-each>
      <xsl:for-each select="*:datafield[@tag = '046']/*:subfield[@code = 'c']">
        <dateIssued encoding="edtf">
          <xsl:value-of select="replace(., '[u\?]', 'X')"/>
          <xsl:if test="../*:subfield[@code = 'e']">
            <xsl:value-of select="concat('/', replace(../*:subfield[@code = 'e'], '[u\?]', 'X'))"/>
          </xsl:if>
        </dateIssued>
      </xsl:for-each>
      <xsl:for-each select="*:datafield[@tag = '046']/*:subfield[@code = 'k']">
        <dateCreated encoding="edtf">
          <xsl:value-of select="replace(., '[u\?]', 'X')"/>
          <xsl:if test="../*:subfield[@code = 'l']">
            <xsl:value-of select="concat('/', replace(../*:subfield[@code = 'l'], '[u\?]', 'X'))"/>
          </xsl:if>
        </dateCreated>
      </xsl:for-each>

      <xsl:variable name="controlField008-7-10"
        select="replace(replace(substring($controlField008, 8, 4), '^\s+', ''), '\|', '')"/>
      <xsl:variable name="controlField008-11-14"
        select="replace(replace(substring($controlField008, 12, 4), '^\s+', ''), '\|', '')"/>
      <xsl:variable name="controlField008-6" select="substring($controlField008, 7, 1)"/>
      <xsl:variable name="fixedFieldDates">
        <!-- 008/07-14 captures a date range; i.e., dates of continuing resource currently published, 
           continuing resource ceased publication, inclusive dates of collection, range of years of bulk of 
           collection, range of years of publication of a multipart item, or continuing resource status unknown -->
        <xsl:if
          test="$controlField008-6 = 'c' or $controlField008-6 = 'd' or $controlField008-6 = 'i' or $controlField008-6 = 'k' or $controlField008-6 = 'm' or $controlField008-6 = 'u'">
          <xsl:variable name="elementName">
            <xsl:choose>
              <xsl:when test="$leader6 = 'd' or $leader6 = 'f' or $leader6 = 'p' or $leader6 = 't'"
                >dateCreated</xsl:when>
              <xsl:otherwise>dateIssued</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:element name="{$elementName}">
            <xsl:attribute name="encoding">edtf</xsl:attribute>
            <xsl:attribute name="keyDate">yes</xsl:attribute>
            <xsl:value-of select="replace($controlField008-7-10, '[u\s\?]', 'X')"/>
            <xsl:choose>
              <xsl:when test="matches($controlField008-11-14, '^$')">
                <xsl:value-of select="'/..'"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of
                  select="concat('/', replace(replace($controlField008-11-14, '[u\s\?]', 'X'), '^9999$', '..'))"
                />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:element>
        </xsl:if>
        <!-- 008/07-14 captures date which represents the month (and possibly the day) in addition to the year -->
        <xsl:if test="$controlField008-6 = 'e' and $controlField008-7-10">
          <xsl:variable name="elementName">
            <xsl:choose>
              <xsl:when test="$leader6 = 'd' or $leader6 = 'f' or $leader6 = 'p' or $leader6 = 't'">
                <xsl:text>dateCreated</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>dateIssued</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:element name="{$elementName}">
            <xsl:attribute name="encoding">edtf</xsl:attribute>
            <xsl:attribute name="keyDate">yes</xsl:attribute>
            <xsl:value-of select="replace($controlField008-7-10, '[u\s\?]', 'X')"/>
            <xsl:value-of
              select="concat('-', replace(substring($controlField008-11-14, 1, 2), '[u\s\?]', 'X'))"/>
            <xsl:if test="not(matches(substring($controlField008-11-14, 3, 2), '\s\s'))">
              <xsl:value-of
                select="concat('-', replace(substring($controlField008-11-14, 3, 2), '[u\s\?]', 'X'))"
              />
            </xsl:if>
          </xsl:element>
        </xsl:if>
        <!-- 008/07-14 captures distribution/release/issue and production/recording session date, 
          reprint/reissue date and original date, or publication date and copyright date -->
        <xsl:if
          test="($controlField008-6 = 'p' or $controlField008-6 = 'r' or $controlField008-6 = 't') and $controlField008-7-10">
          <dateIssued encoding="edtf">
            <xsl:if test="matches($controlField008-7-10, '^\d+$')">
              <xsl:attribute name="keyDate">yes</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="replace($controlField008-7-10, '[u\s\?]', 'X')"/>
          </dateIssued>
          <xsl:if test="not(normalize-space($controlField008-11-14) = '')">
            <xsl:choose>
              <xsl:when test="$controlField008-6 = 'p'">
                <dateCreated encoding="edtf">
                  <xsl:if test="not(matches($controlField008-7-10, '^\d+$'))">
                    <xsl:attribute name="keyDate">yes</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="replace($controlField008-11-14, '[u\s\?]', 'X')"/>
                </dateCreated>
              </xsl:when>
              <xsl:when test="$controlField008-6 = 'r'">
                <dateIssued encoding="edtf">
                  <xsl:if test="not(matches($controlField008-7-10, '^\d+$'))">
                    <xsl:attribute name="keyDate">yes</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="replace($controlField008-11-14, '[u\s\?]', 'X')"/>
                </dateIssued>
              </xsl:when>
              <xsl:when test="$controlField008-6 = 't'">
                <copyrightDate encoding="edtf">
                  <xsl:if test="not(matches($controlField008-7-10, '^\d+$'))">
                    <xsl:attribute name="keyDate">yes</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="replace($controlField008-11-14, '[u\s\?]', 'X')"/>
                </copyrightDate>
              </xsl:when>
            </xsl:choose>
          </xsl:if>
        </xsl:if>
        <!-- 008/07-14 contains a range of years when the exact date for a monographic item is not known -->
        <xsl:if test="$controlField008-6 = 'q'">
          <dateIssued encoding="edtf" keyDate="yes">
            <xsl:choose>
              <!-- Date range -->
              <xsl:when
                test="matches($controlField008-7-10, '[\d\?u]+') and matches($controlField008-11-14, '[\d\?u]+')">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="replace($controlField008-7-10, '[u\s\?]', 'X')"/>
                <xsl:value-of select="concat('..', replace($controlField008-11-14, '[u\s\?]', 'X'))"/>
                <xsl:text>]</xsl:text>
              </xsl:when>
              <!-- Single date must be in 008/07-10 -->
              <xsl:otherwise>
                <xsl:value-of select="concat(replace($controlField008-7-10, '[u\s\?]', 'X'), '?')"/>
              </xsl:otherwise>
            </xsl:choose>
          </dateIssued>
        </xsl:if>
        <!-- 008/07-14 contains a single known date/probable date -->
        <xsl:if test="$controlField008-6 = 's' and $controlField008-7-10">
          <dateIssued encoding="edtf" keyDate="yes">
            <xsl:value-of select="replace($controlField008-7-10, '[u\s\?]', 'X')"/>
          </dateIssued>
        </xsl:if>
        <!-- 008/07-14 contains some other kind of date -->
        <xsl:if
          test="not(matches($controlField008-6, '[bcdeikmpqrstu]')) and (matches($controlField008-7-10, '[\du]+') or matches($controlField008-11-14, '[\du]+'))">
          <dateOther encoding="edtf" keyDate="yes">
            <xsl:choose>
              <!-- Date range -->
              <xsl:when
                test="matches($controlField008-7-10, '[\d\?u]+') and matches($controlField008-11-14, '[\d\?u]+')">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="replace($controlField008-7-10, '[u\s\?]', 'X')"/>
                <xsl:value-of select="concat('..', replace($controlField008-11-14, '[u\s\?]', 'X'))"/>
                <xsl:text>]</xsl:text>
              </xsl:when>
              <!-- Single date -->
              <xsl:otherwise>
                <xsl:choose>
                  <!-- Date is in 008/07-10 -->
                  <xsl:when test="matches($controlField008-7-10, '[\d\?u]+')">
                    <xsl:value-of select="replace($controlField008-7-10, '[u\s\?]', 'X')"/>
                  </xsl:when>
                  <!-- Date is in 008/01-14 -->
                  <xsl:otherwise>
                    <xsl:value-of select="replace($controlField008-11-14, '[u\s\?]', 'X')"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </dateOther>
        </xsl:if>
      </xsl:variable>
      <xsl:copy-of select="$fixedFieldDates"/>

      <xsl:for-each select="*:datafield[@tag = '260']/*:subfield[@code = 'c' or @code = 'g']">
        <xsl:choose>
          <xsl:when test="(@code = 'c')">
            <xsl:if test="$leader6 = 'd' or $leader6 = 'f' or $leader6 = 'p' or $leader6 = 't'">
              <xsl:variable name="regDate">
                <xsl:value-of
                  select="replace(replace(replace(., '^[\.:,;/\[\]\s]+|[\.:,;/\[\]\s]+$', ''), '(\d{4})-(\d{4})', '$1/$2'), '^\D+|\D+$', '')"
                />
              </xsl:variable>
              <xsl:if test="not($fixedFieldDates/*:dateCreated[. eq $regDate])">
                <dateCreated>
                  <xsl:value-of select="$regDate"/>
                </dateCreated>
              </xsl:if>
            </xsl:if>
            <xsl:if test="not($leader6 = 'd' or $leader6 = 'f' or $leader6 = 'p' or $leader6 = 't')">
              <xsl:choose>
                <xsl:when test="matches(normalize-space(.), '^c', 'i')">
                  <xsl:variable name="regDate">
                    <xsl:value-of
                      select="replace(replace(replace(., '^[\.:,;/\[\]\s]+|[\.:,;/\[\]\s]+$', ''), '(\d{4})-(\d{4})', '$1/$2'), '^\D+|\D+$', '')"
                    />
                  </xsl:variable>
                  <xsl:if test="not($fixedFieldDates/*:copyrightDate[. eq $regDate])">
                    <copyrightDate>
                      <xsl:value-of select="$regDate"/>
                    </copyrightDate>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="regDate">
                    <xsl:value-of
                      select="replace(replace(replace(., '^[\.:,;/\[\]\s]+|[\.:,;/\[\]\s]+$', ''), '(\d{4})-(\d{4})', '$1/$2'), '^\D+|\D+$', '')"
                    />
                  </xsl:variable>
                  <xsl:if test="not($fixedFieldDates/*:dateIssued[. eq $regDate])">
                    <dateIssued>
                      <xsl:value-of select="."/>
                    </dateIssued>
                  </xsl:if>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
          </xsl:when>
          <xsl:when test="@code = 'g'">
            <xsl:variable name="regDate">
              <xsl:value-of
                select="replace(replace(replace(., '^[\.:,;/\[\]\s]+|[\.:,;/\[\]\s]+$', ''), '(\d{4})-(\d{4})', '$1/$2'), '^\D+|\D+$', '')"
              />
            </xsl:variable>
            <xsl:if test="not($fixedFieldDates/*:dateCreated[. eq $regDate])">
              <dateCreated>
                <xsl:value-of select="$regDate"/>
              </dateCreated>
            </xsl:if>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
      <!-- One or more single dates -->
      <xsl:for-each
        select="*:datafield[@tag = '033'][(@ind1 = '0' or @ind1 = '1') and @ind2 = '0']/*:subfield[@code = 'a']">
        <dateCaptured encoding="edtf">
          <xsl:variable name="temp">
            <xsl:value-of select="replace(substring(., 1, 8), '-', 'X')"/>
          </xsl:variable>
          <xsl:value-of
            select="concat(substring($temp, 1, 4), '-', substring($temp, 5, 2), '-', substring($temp, 7, 2))"
          />
        </dateCaptured>
      </xsl:for-each>
      <!-- Date range -->
      <xsl:for-each select="*:datafield[@tag = '033'][@ind1 = '2' and @ind2 = '0']">
        <dateCaptured encoding="edtf" point="start">
          <xsl:variable name="temp">
            <xsl:value-of select="replace(substring(*:subfield[@code = 'a'][1], 1, 8), '-', 'X')"/>
          </xsl:variable>
          <xsl:value-of
            select="concat(substring($temp, 1, 4), '-', substring($temp, 5, 2), '-', substring($temp, 7, 2))"
          />
        </dateCaptured>
        <dateCaptured encoding="edtf" point="end">
          <xsl:variable name="temp">
            <xsl:value-of select="replace(substring(*:subfield[@code = 'a'][2], 1, 8), '-', 'X')"/>
          </xsl:variable>
          <xsl:value-of
            select="concat(substring($temp, 1, 4), '-', substring($temp, 5, 2), '-', substring($temp, 7, 2))"
          />
        </dateCaptured>
      </xsl:for-each>

      <xsl:for-each select="*:datafield[@tag = '250']/*:subfield[@code = 'a']">
        <edition>
          <xsl:value-of select="normalize-space(replace(., '[;:,/]+$', ''))"/>
        </edition>
      </xsl:for-each>
      <xsl:for-each select="*:leader">
        <issuance>
          <xsl:choose>
            <xsl:when test="$leader7 = 'a' or $leader7 = 'c' or $leader7 = 'd' or $leader7 = 'm'"
              >monographic</xsl:when>
            <xsl:when
              test="$leader7 = 'm' and ($leader19 = 'a' or $leader19 = 'b' or $leader19 = 'c')"
              >multipart monograph</xsl:when>
            <xsl:when test="$leader7 = 'm' and ($leader19 = ' ')">single unit</xsl:when>
            <xsl:when test="$leader7 = 'm' and ($leader19 = '#')">single unit</xsl:when>
            <xsl:when test="$leader7 = 'i'">integrating resource</xsl:when>
            <xsl:when test="$leader7 = 'b' or $leader7 = 's'">serial</xsl:when>
          </xsl:choose>
        </issuance>
      </xsl:for-each>

      <xsl:variable name="frequency">
        <xsl:for-each select="*:datafield[@tag = '310'] | *:datafield[@tag = '321']">
          <freq>
            <xsl:variable name="freq">
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">ab</xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <xsl:call-template name="chopPunctuationBack">
              <xsl:with-param name="chopString" select="lower-case($freq)"/>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </freq>
        </xsl:for-each>
        <xsl:if test="$typeOf008 = 'SE'">
          <xsl:for-each select="*:controlfield[@tag = '008']">
            <xsl:variable name="controlField008-18" select="substring($controlField008, 19, 1)"/>
            <freq>
              <xsl:choose>
                <xsl:when test="$controlField008-18 = 'a'">annual</xsl:when>
                <xsl:when test="$controlField008-18 = 'b'">bimonthly</xsl:when>
                <xsl:when test="$controlField008-18 = 'c'">semiweekly</xsl:when>
                <xsl:when test="$controlField008-18 = 'd'">daily</xsl:when>
                <xsl:when test="$controlField008-18 = 'e'">biweekly</xsl:when>
                <xsl:when test="$controlField008-18 = 'f'">semiannual</xsl:when>
                <xsl:when test="$controlField008-18 = 'g'">biennial</xsl:when>
                <xsl:when test="$controlField008-18 = 'h'">triennial</xsl:when>
                <xsl:when test="$controlField008-18 = 'i'">three times a week</xsl:when>
                <xsl:when test="$controlField008-18 = 'j'">three times a month</xsl:when>
                <xsl:when test="$controlField008-18 = 'k'">continuously updated</xsl:when>
                <xsl:when test="$controlField008-18 = 'm'">monthly</xsl:when>
                <xsl:when test="$controlField008-18 = 'q'">quarterly</xsl:when>
                <xsl:when test="$controlField008-18 = 's'">semimonthly</xsl:when>
                <xsl:when test="$controlField008-18 = 't'">three times a year</xsl:when>
                <xsl:when test="$controlField008-18 = 'u'">unknown</xsl:when>
                <xsl:when test="$controlField008-18 = 'w'">weekly</xsl:when>
                <xsl:when test="$controlField008-18 = ' '">completely irregular</xsl:when>
                <xsl:when test="$controlField008-18 = '#'">completely irregular</xsl:when>
                <xsl:otherwise/>
              </xsl:choose>
            </freq>
          </xsl:for-each>
        </xsl:if>
      </xsl:variable>
      <xsl:for-each select="distinct-values($frequency/*:freq)">
        <frequency>
          <xsl:value-of select="."/>
        </frequency>
      </xsl:for-each>
    </originInfo>

    <xsl:for-each select="*:datafield[@tag = '264'][@ind2 = '0']">
      <originInfo eventType="production">
        <!-- Template checks for altRepGroup - 880 $6 -->
        <xsl:call-template name="xxx880"/>
        <place>
          <placeTerm type="text">
            <xsl:value-of select="replace(*:subfield[@code = 'a'], '[:,;/\[\]\s]+$', '')"/>
          </placeTerm>
        </place>
        <publisher>
          <xsl:value-of select="replace(*:subfield[@code = 'b'], '[:,;/\s]+$', '')"/>
        </publisher>
        <dateOther type="production">
          <xsl:value-of select="*:subfield[@code = 'c']"/>
        </dateOther>
      </originInfo>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '264'][@ind2 = '1']">
      <originInfo eventType="publication">
        <!-- Template checks for altRepGroup - 880 $6 1.88 20130829 added chopPunc-->
        <xsl:call-template name="xxx880"/>
        <xsl:for-each select="*:subfield[@code = 'a']">
          <place>
            <placeTerm type="text">
              <xsl:value-of select="replace(., '[:,;/\s]+$', '')"/>
            </placeTerm>
          </place>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'b']">
          <publisher>
            <xsl:value-of select="replace(., '[:,;/\s]+$', '')"/>
          </publisher>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'c']">
          <dateIssued>
            <xsl:value-of
              select="replace(replace(., '^[\.:,;/\[\]\s]+', ''), '[\.:,;/\[\]\s]+$', '')"/>
          </dateIssued>
        </xsl:for-each>
      </originInfo>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '264'][@ind2 = '2']">
      <originInfo eventType="distribution">
        <!-- Template checks for altRepGroup - 880 $6 -->
        <xsl:call-template name="xxx880"/>
        <xsl:for-each select="*:subfield[@code = 'a']">
          <place>
            <placeTerm type="text">
              <xsl:value-of select="replace(., '[:,;/\[\]\s]+$', '')"/>
            </placeTerm>
          </place>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'b']">
          <publisher>
            <xsl:value-of select="replace(., '[:,;/\s]+$', '')"/>
          </publisher>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'c']">
          <dateOther type="distribution">
            <xsl:value-of select="."/>
          </dateOther>
        </xsl:for-each>
      </originInfo>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '264'][@ind2 = '3']">
      <originInfo eventType="manufacture">
        <!-- Template checks for altRepGroup - 880 $6 -->
        <xsl:call-template name="xxx880"/>
        <xsl:for-each select="*:subfield[@code = 'a']">
          <place>
            <placeTerm type="text">
              <xsl:value-of select="replace(., '[:,;/\[\]\s]+$', '')"/>
            </placeTerm>
          </place>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'b']">
          <publisher>
            <xsl:value-of select="replace(., '[:,;/\s]+$', '')"/>
          </publisher>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'c']">
          <dateOther type="manufacture">
            <xsl:value-of select="."/>
          </dateOther>
        </xsl:for-each>
      </originInfo>
    </xsl:for-each>

    <!-- 880 -->
    <xsl:for-each select="*:datafield[@tag = '880']">
      <xsl:variable name="related_datafield" select="substring-before(*:subfield[@code = '6'], '-')"/>
      <xsl:variable name="occurence_number"
        select="substring(substring-after(*:subfield[@code = '6'], '-'), 1, 2)"/>
      <xsl:variable name="hit"
        select="../*:datafield[@tag = $related_datafield and contains(*:subfield[@code = '6'], concat('880-', $occurence_number))]/@tag"/>
      <xsl:choose>
        <xsl:when test="$hit = '260'">
          <originInfo>
            <xsl:call-template name="scriptCode"/>
            <xsl:for-each
              select="../*:datafield[@tag = '260' and *:subfield[@code = 'a' or code = 'b' or @code = 'c' or code = 'g']]">
              <xsl:call-template name="z2xx880"/>
            </xsl:for-each>
            <xsl:for-each select="*:subfield[@code = 'a']">
              <place>
                <placeTerm type="text">
                  <xsl:value-of select="."/>
                </placeTerm>
              </place>
            </xsl:for-each>
            <xsl:for-each select="*:subfield[@code = 'b']">
              <publisher>
                <xsl:value-of select="."/>
              </publisher>
            </xsl:for-each>
            <xsl:for-each select="*:subfield[@code = 'c']">
              <dateIssued>
                <xsl:value-of
                  select="replace(replace(., '^[\.:,;/\[\]\s]+', ''), '[\.:,;/\[\]\s]+$', '')"/>
              </dateIssued>
            </xsl:for-each>
            <xsl:for-each select="*:subfield[@code = 'g']">
              <dateCreated>
                <xsl:value-of
                  select="replace(replace(., '^[\.:,;/\[\]\s]+', ''), '[\.:,;/\[\]\s]+$', '')"/>
              </dateCreated>
            </xsl:for-each>
            <xsl:for-each
              select="../*:datafield[@tag = '880']/*:subfield[@code = '6'][contains(text(), '250')]">
              <edition>
                <xsl:value-of select="following-sibling::*:subfield"/>
              </edition>
            </xsl:for-each>
          </originInfo>
        </xsl:when>
        <xsl:when test="$hit = '300'">
          <physicalDescription>
            <xsl:for-each select="../*:datafield[@tag = '300']">
              <xsl:call-template name="z3xx880"/>
            </xsl:for-each>
            <extent>
              <xsl:for-each select="*:subfield">
                <xsl:if test="@code = 'a' or @code = '3' or @code = 'b' or @code = 'c'">
                  <xsl:value-of select="."/>
                  <xsl:text> </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </extent>
            <!-- form 337 338 -->
            <form>
              <xsl:attribute name="authority">
                <xsl:call-template name="chopPunctuationBack">
                  <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
                  <xsl:with-param name="punctuation">
                    <xsl:text>.:,;/ </xsl:text>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:attribute>
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">a</xsl:with-param>
              </xsl:call-template>
            </form>
          </physicalDescription>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>

    <!-- language from control field 008 -->
    <xsl:variable name="controlField008-35-37"
      select="normalize-space(translate(substring($controlField008, 36, 3), '|#', ''))"/>
    <xsl:if test="$controlField008-35-37">
      <language>
        <languageTerm authority="iso639-2b" type="code">
          <xsl:value-of select="substring($controlField008, 36, 3)"/>
        </languageTerm>
      </language>
    </xsl:if>

    <!-- language from 041 -->
    <xsl:for-each select="*:datafield[@tag = '041'] | *:datafield[@tag = '377']">
      <xsl:for-each select="*:subfield[matches(@code, '[abdefghijkmnpqrt]')]">
        <xsl:variable name="langCodes" select="."/>
        <xsl:choose>
          <xsl:when test="../*:subfield[@code = '2'] = 'rfc3066'">
            <!-- not stacked but could be repeated -->
            <xsl:call-template name="rfcLanguages">
              <xsl:with-param name="nodeNum">
                <xsl:value-of select="1"/>
              </xsl:with-param>
              <xsl:with-param name="usedLanguages">
                <xsl:text/>
              </xsl:with-param>
              <xsl:with-param name="controlField008-35-37">
                <xsl:value-of select="$controlField008-35-37"/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- iso -->
            <xsl:variable name="allLanguages">
              <xsl:copy-of select="$langCodes"/>
            </xsl:variable>
            <xsl:variable name="currentLanguage">
              <xsl:value-of select="substring($allLanguages, 1, 3)"/>
            </xsl:variable>
            <xsl:call-template name="isoLanguage">
              <xsl:with-param name="currentLanguage">
                <xsl:value-of select="substring($allLanguages, 1, 3)"/>
              </xsl:with-param>
              <xsl:with-param name="remainingLanguages">
                <xsl:value-of select="substring($allLanguages, 4, string-length($allLanguages) - 3)"
                />
              </xsl:with-param>
              <xsl:with-param name="usedLanguages">
                <xsl:if test="$controlField008-35-37">
                  <xsl:value-of select="$controlField008-35-37"/>
                </xsl:if>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:for-each>

    <!-- physicalDescription -->
    <xsl:variable name="physicalDescription">
      <xsl:if test="($typeOf008 = 'CF' and *:controlfield[@tag = '007'][substring(., 12, 1) = 'a'])">
        <digitalOrigin>reformatted digital</digitalOrigin>
      </xsl:if>
      <xsl:if test="$typeOf008 = 'CF' and *:controlfield[@tag = '007'][substring(., 12, 1) = 'b']">
        <digitalOrigin>digitized microfilm</digitalOrigin>
      </xsl:if>
      <xsl:if test="$typeOf008 = 'CF' and *:controlfield[@tag = '007'][substring(., 12, 1) = 'd']">
        <digitalOrigin>digitized other analog</digitalOrigin>
      </xsl:if>
      <xsl:variable name="controlField008-23" select="substring($controlField008, 24, 1)"/>
      <xsl:variable name="controlField008-29" select="substring($controlField008, 30, 1)"/>
      <xsl:variable name="check008-23">
        <xsl:if
          test="$typeOf008 = 'BK' or $typeOf008 = 'MU' or $typeOf008 = 'SE' or $typeOf008 = 'MM'">
          <xsl:value-of select="true()"/>
        </xsl:if>
      </xsl:variable>
      <xsl:variable name="check008-29">
        <xsl:if test="$typeOf008 = 'MP' or $typeOf008 = 'VM'">
          <xsl:value-of select="true()"/>
        </xsl:if>
      </xsl:variable>
      <xsl:choose>
        <xsl:when
          test="($check008-23 and $controlField008-23 = 'f') or ($check008-29 and $controlField008-29 = 'f')">
          <form authority="marcform">braille</form>
        </xsl:when>
        <xsl:when
          test="($controlField008-23 = ' ' and ($leader6 = 'c' or $leader6 = 'd')) or (($typeOf008 = 'BK' or $typeOf008 = 'SE') and ($controlField008-23 = ' ' or $controlField008 = 'r'))">
          <form authority="marcform">print</form>
        </xsl:when>
        <xsl:when
          test="$leader6 = 'm' or ($check008-23 and $controlField008-23 = 's') or ($check008-29 and $controlField008-29 = 's')">
          <form authority="marcform">electronic</form>
        </xsl:when>
        <xsl:when test="$leader6 = 'o'">
          <form authority="marcform">kit</form>
        </xsl:when>
        <xsl:when
          test="($check008-23 and $controlField008-23 = 'b') or ($check008-29 and $controlField008-29 = 'b')">
          <form authority="marcform">microfiche</form>
        </xsl:when>
        <xsl:when
          test="($check008-23 and $controlField008-23 = 'a') or ($check008-29 and $controlField008-29 = 'a')">
          <form authority="marcform">microfilm</form>
        </xsl:when>
      </xsl:choose>
      <xsl:if test="*:datafield[@tag = '130']/*:subfield[@code = 'h']">
        <form authority="gmd">
          <xsl:call-template name="chopBrackets">
            <xsl:with-param name="chopString">
              <xsl:value-of select="*:datafield[@tag = '130']/*:subfield[@code = 'h']"/>
            </xsl:with-param>
          </xsl:call-template>
        </form>
      </xsl:if>
      <xsl:if test="*:datafield[@tag = '240']/*:subfield[@code = 'h']">
        <form authority="gmd">
          <xsl:call-template name="chopBrackets">
            <xsl:with-param name="chopString">
              <xsl:value-of select="*:datafield[@tag = '240']/*:subfield[@code = 'h']"/>
            </xsl:with-param>
          </xsl:call-template>
        </form>
      </xsl:if>
      <xsl:if test="*:datafield[@tag = '242']/*:subfield[@code = 'h']">
        <form authority="gmd">
          <xsl:call-template name="chopBrackets">
            <xsl:with-param name="chopString">
              <xsl:value-of select="*:datafield[@tag = '242']/*:subfield[@code = 'h']"/>
            </xsl:with-param>
          </xsl:call-template>
        </form>
      </xsl:if>
      <xsl:if test="*:datafield[@tag = '245']/*:subfield[@code = 'h']">
        <form authority="gmd">
          <xsl:call-template name="chopBrackets">
            <xsl:with-param name="chopString">
              <xsl:value-of select="*:datafield[@tag = '245']/*:subfield[@code = 'h']"/>
            </xsl:with-param>
          </xsl:call-template>
        </form>
      </xsl:if>
      <xsl:if test="*:datafield[@tag = '246']/*:subfield[@code = 'h']">
        <form authority="gmd">
          <xsl:call-template name="chopBrackets">
            <xsl:with-param name="chopString">
              <xsl:value-of select="*:datafield[@tag = '246']/*:subfield[@code = 'h']"/>
            </xsl:with-param>
          </xsl:call-template>
        </form>
      </xsl:if>
      <xsl:if test="*:datafield[@tag = '730']/*:subfield[@code = 'h']">
        <form authority="gmd">
          <xsl:call-template name="chopBrackets">
            <xsl:with-param name="chopString">
              <xsl:value-of select="*:datafield[@tag = '730']/*:subfield[@code = 'h']"/>
            </xsl:with-param>
          </xsl:call-template>
        </form>
      </xsl:if>
      <xsl:for-each select="*:datafield[@tag = '256']/*:subfield[@code = 'a']">
        <form>
          <xsl:value-of select="."/>
        </form>
      </xsl:for-each>
      <xsl:for-each select="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c']">
        <xsl:choose>
          <xsl:when test="substring(text(), 14, 1) = 'a'">
            <reformattingQuality>access</reformattingQuality>
          </xsl:when>
          <xsl:when test="substring(text(), 14, 1) = 'p'">
            <reformattingQuality>preservation</reformattingQuality>
          </xsl:when>
          <xsl:when test="substring(text(), 14, 1) = 'r'">
            <reformattingQuality>replacement</reformattingQuality>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'b']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">chip cartridge</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">computer optical disc cartridge</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'j']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">magnetic disc</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'm']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">magneto-optical disc</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'o']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">optical disc</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'r']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">remote</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'a']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">tape cartridge</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'f']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">tape cassette</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 2, 1) = 'h']">
        <form authority="marccategory">electronic resource</form>
        <form authority="marcsmd">tape reel</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'd'][substring(text(), 2, 1) = 'a']">
        <form authority="marccategory">globe</form>
        <form authority="marcsmd">celestial globe</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'd'][substring(text(), 2, 1) = 'e']">
        <form authority="marccategory">globe</form>
        <form authority="marcsmd">earth moon globe</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'd'][substring(text(), 2, 1) = 'b']">
        <form authority="marccategory">globe</form>
        <form authority="marcsmd">planetary or lunar globe</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'd'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">globe</form>
        <form authority="marcsmd">terrestrial globe</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'o'][substring(text(), 2, 1) = 'o']">
        <form authority="marccategory">kit</form>
        <form authority="marcsmd">kit</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'd']">
        <form authority="marccategory">map</form>
        <form authority="marcsmd">atlas</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'g']">
        <form authority="marccategory">map</form>
        <form authority="marcsmd">diagram</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'j']">
        <form authority="marccategory">map</form>
        <form authority="marcsmd">map</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'q']">
        <form authority="marccategory">map</form>
        <form authority="marcsmd">model</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'k']">
        <form authority="marccategory">map</form>
        <form authority="marcsmd">profile</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'r']">
        <form authority="marcsmd">remote-sensing image</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 's']">
        <form authority="marccategory">map</form>
        <form authority="marcsmd">section</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 2, 1) = 'y']">
        <form authority="marccategory">map</form>
        <form authority="marcsmd">view</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 2, 1) = 'a']">
        <form authority="marccategory">microform</form>
        <form authority="marcsmd">aperture card</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 2, 1) = 'e']">
        <form authority="marccategory">microform</form>
        <form authority="marcsmd">microfiche</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 2, 1) = 'f']">
        <form authority="marccategory">microform</form>
        <form authority="marcsmd">microfiche cassette</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 2, 1) = 'b']">
        <form authority="marccategory">microform</form>
        <form authority="marcsmd">microfilm cartridge</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">microform</form>
        <form authority="marcsmd">microfilm cassette</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 2, 1) = 'd']">
        <form authority="marccategory">microform</form>
        <form authority="marcsmd">microfilm reel</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 2, 1) = 'g']">
        <form authority="marccategory">microform</form>
        <form authority="marcsmd">microopaque</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">motion picture</form>
        <form authority="marcsmd">film cartridge</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 2, 1) = 'f']">
        <form authority="marccategory">motion picture</form>
        <form authority="marcsmd">film cassette</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 2, 1) = 'r']">
        <form authority="marccategory">motion picture</form>
        <form authority="marcsmd">film reel</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'n']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">chart</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">collage</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'd']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">drawing</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'o']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">flash card</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'e']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">painting</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'f']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">photomechanical print</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'g']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">photonegative</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'h']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">photoprint</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'i']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">picture</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'j']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">print</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'k'][substring(text(), 2, 1) = 'l']">
        <form authority="marccategory">nonprojected graphic</form>
        <form authority="marcsmd">technical drawing</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'q'][substring(text(), 2, 1) = 'q']">
        <form authority="marccategory">notated music</form>
        <form authority="marcsmd">notated music</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 2, 1) = 'd']">
        <form authority="marccategory">projected graphic</form>
        <form authority="marcsmd">filmslip</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">projected graphic</form>
        <form authority="marcsmd">filmstrip cartridge</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 2, 1) = 'o']">
        <form authority="marccategory">projected graphic</form>
        <form authority="marcsmd">filmstrip roll</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 2, 1) = 'f']">
        <form authority="marccategory">projected graphic</form>
        <form authority="marcsmd">other filmstrip type</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 2, 1) = 's']">
        <form authority="marccategory">projected graphic</form>
        <form authority="marcsmd">slide</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 2, 1) = 't']">
        <form authority="marccategory">projected graphic</form>
        <form authority="marcsmd">transparency</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'r'][substring(text(), 2, 1) = 'r']">
        <form authority="marccategory">remote-sensing image</form>
        <form authority="marcsmd">remote-sensing image</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'e']">
        <form authority="marccategory">sound recording</form>
        <form authority="marcsmd">cylinder</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'q']">
        <form authority="marccategory">sound recording</form>
        <form authority="marcsmd">roll</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'g']">
        <form authority="marccategory">sound recording</form>
        <form authority="marcsmd">sound cartridge</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 's']">
        <form authority="marccategory">sound recording</form>
        <form authority="marcsmd">sound cassette</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'd']">
        <form authority="marccategory">sound recording</form>
        <form authority="marcsmd">sound disc</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 't']">
        <form authority="marccategory">sound recording</form>
        <form authority="marcsmd">sound-tape reel</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'i']">
        <form authority="marccategory">sound recording</form>
        <form authority="marcsmd">sound-track film</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'w']">
        <form authority="marccategory">sound recording</form>
        <form authority="marcsmd">wire recording</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">tactile material</form>
        <form authority="marcsmd">braille</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 2, 1) = 'b']">
        <form authority="marccategory">tactile material</form>
        <form authority="marcsmd">combination</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 2, 1) = 'a']">
        <form authority="marccategory">tactile material</form>
        <form authority="marcsmd">moon</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 2, 1) = 'd']">
        <form authority="marccategory">tactile material</form>
        <form authority="marcsmd">tactile, with no writing system</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 't'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">text</form>
        <form authority="marcsmd">braille</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 't'][substring(text(), 2, 1) = 'b']">
        <form authority="marccategory">text</form>
        <form authority="marcsmd">large print</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 't'][substring(text(), 2, 1) = 'a']">
        <form authority="marccategory">text</form>
        <form authority="marcsmd">regular print</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 't'][substring(text(), 2, 1) = 'd']">
        <form authority="marccategory">text</form>
        <form authority="marcsmd">text in looseleaf binder</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 2, 1) = 'c']">
        <form authority="marccategory">videorecording</form>
        <form authority="marcsmd">videocartridge</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 2, 1) = 'f']">
        <form authority="marccategory">videorecording</form>
        <form authority="marcsmd">videocassette</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 2, 1) = 'd']">
        <form authority="marccategory">videorecording</form>
        <form authority="marcsmd">videodisc</form>
      </xsl:if>
      <xsl:if
        test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 2, 1) = 'r']">
        <form authority="marccategory">videorecording</form>
        <form authority="marcsmd">videoreel</form>
      </xsl:if>
      <xsl:for-each select="*:datafield[@tag = '337']">
        <form type="media">
          <xsl:attribute name="authority">
            <xsl:call-template name="chopPunctuationBack">
              <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">a</xsl:with-param>
          </xsl:call-template>
        </form>
      </xsl:for-each>
      <xsl:for-each select="*:datafield[@tag = '338']">
        <form type="carrier">
          <xsl:attribute name="authority">
            <xsl:call-template name="chopPunctuationBack">
              <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">a</xsl:with-param>
          </xsl:call-template>
        </form>
      </xsl:for-each>

      <xsl:for-each
        select="*:datafield[@tag = '856']/*:subfield[@code = 'q'][normalize-space(.) != '']">
        <internetMediaType>
          <xsl:value-of select="."/>
        </internetMediaType>
      </xsl:for-each>

      <xsl:for-each select="*:datafield[@tag = '300']">
        <extent>
          <xsl:if test="*:subfield[@code = 'f']">
            <xsl:attribute name="unit">
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">f</xsl:with-param>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">abce3g</xsl:with-param>
          </xsl:call-template>
        </extent>
      </xsl:for-each>

      <xsl:for-each select="*:datafield[@tag = '351']">
        <note type="arrangement">
          <xsl:for-each select="*:subfield[@code = '3']">
            <xsl:value-of select="."/>
            <xsl:text>: </xsl:text>
          </xsl:for-each>
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">abc</xsl:with-param>
          </xsl:call-template>
        </note>
      </xsl:for-each>

      <xsl:variable name="physDetails">
        <!-- Physical details in 007 -->
        <!-- Characteristics shared by multiple formats -->
        <!-- Color content (map, electronic resource, globe, projected graphic, microform, nonprojected graphic, motion picture, videorecording) -->
        <xsl:if
          test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|c|d|g|h|k|m|v)')]">
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|c|d|g|k|m|v)')][substring(text(), 4, 1) = 'a'] | *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 10, 1) = 'a']">
            <note type="{$notePrefix}colorContent">one color</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|c|d|g|k|m|v)')][substring(text(), 4, 1) = 'b'] | *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 10, 1) = 'b']">
            <note type="{$notePrefix}colorContent">black and white</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|c|d|g|k|m|v)')][substring(text(), 4, 1) = 'c'] | *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 10, 1) = 'c']">
            <note type="{$notePrefix}colorContent">color</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|c|d|g|k|m|v)')][substring(text(), 4, 1) = 'm'] | *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 10, 1) = 'm']">
            <note type="{$notePrefix}colorContent">mixed color</note>
          </xsl:if>
        </xsl:if>
        <!-- Configuration of playback channels (motion picture, sound recording, videorecording)-->
        <xsl:if test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(m|s|v)')]">
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(m|v)')][substring(text(), 9, 1) = 'k'] | *:controlfield[@tag = '007'][matches(substring(text(), 1, 1), 's')][substring(text(), 5, 1) = 'k']">
            <note type="{$notePrefix}playbackChannels">mixed</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(m|v)')][substring(text(), 9, 1) = 'm'] | *:controlfield[@tag = '007'][matches(substring(text(), 1, 1), 's')][substring(text(), 5, 1) = 'm']">
            <note type="{$notePrefix}playbackChannels">mono</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(m|v)')][substring(text(), 9, 1) = 'q'] | *:controlfield[@tag = '007'][matches(substring(text(), 1, 1), 's')][substring(text(), 5, 1) = 'q']">
            <note type="{$notePrefix}playbackChannels">surround</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(m|v)')][substring(text(), 9, 1) = 's'] | *:controlfield[@tag = '007'][matches(substring(text(), 1, 1), 's')][substring(text(), 5, 1) = 's']">
            <note type="{$notePrefix}playbackChannels">stereo</note>
          </xsl:if>
        </xsl:if>
        <!-- Sound content (motion picture, videorecording) -->
        <xsl:if test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(m|v)')]">
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(m|v)')][substring(text(), 6, 1) = ' ' or substring(text(), 7, 1) = ' ']">
            <note type="{$notePrefix}soundContent">silent</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(m|v)')][matches(substring(text(), 6, 1), '[ab]') or matches(substring(text(), 7, 1), '[abcdefghi]')]">
            <note type="{$notePrefix}soundContent">sound</note>
          </xsl:if>
        </xsl:if>
        <!-- Physical dimensions (electronic resource, projected graphic, microform, motion picture, sound recording, videorecording) -->
        <xsl:if
          test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(c|g|h|m|s|v)')]">
          <!-- Electronic resource -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 5, 1) = 'a']">
            <note type="{$notePrefix}physDimensions">3 1/2 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 5, 1) = 'e']">
            <note type="{$notePrefix}physDimensions">12 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 5, 1) = 'g']">
            <note type="{$notePrefix}physDimensions">4 3/4 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 5, 1) = 'i']">
            <note type="{$notePrefix}physDimensions">1 1/8 x 2 3/8 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 5, 1) = 'j']">
            <note type="{$notePrefix}physDimensions">3 7/8 x 2 1/2 in.</note>
          </xsl:if>
          <!-- Projected graphic -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'a']">
            <note type="{$notePrefix}physDimensions">8 mm. (standard)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'b']">
            <note type="{$notePrefix}physDimensions">8 mm. (super/single)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'c']">
            <note type="{$notePrefix}physDimensions">9.5 mm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'd']">
            <note type="{$notePrefix}physDimensions">16 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'e']">
            <note type="{$notePrefix}physDimensions">28 mm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'f']">
            <note type="{$notePrefix}physDimensions">35 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'g']">
            <note type="{$notePrefix}physDimensions">70 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'j']">
            <note type="{$notePrefix}physDimensions">2x2 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'k']">
            <note type="{$notePrefix}physDimensions">2 1/4 x 2 1/4 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 's']">
            <note type="{$notePrefix}physDimensions">4x5 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 't']">
            <note type="{$notePrefix}physDimensions">5x7 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'v']">
            <note type="{$notePrefix}physDimensions">8x10 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'w']">
            <note type="{$notePrefix}physDimensions">9x9 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'x']">
            <note type="{$notePrefix}physDimensions">10x10 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'g'][substring(text(), 8, 1) = 'y']">
            <note type="{$notePrefix}physDimensions">7x7 in.</note>
          </xsl:if>
          <!-- Microform -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'a']">
            <note type="{$notePrefix}physDimensions">8 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'd']">
            <note type="{$notePrefix}physDimensions">16 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'f']">
            <note type="{$notePrefix}physDimensions">35 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'g']">
            <note type="{$notePrefix}physDimensions">70 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'h']">
            <note type="{$notePrefix}physDimensions">105 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'l']">
            <note type="{$notePrefix}physDimensions">3x5 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'm']">
            <note type="{$notePrefix}physDimensions">4x6 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'o']">
            <note type="{$notePrefix}physDimensions">6x9 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 5, 1) = 'p']">
            <note type="{$notePrefix}physDimensions">3 1/4 x 7 3/8 in.</note>
          </xsl:if>
          <!-- Motion picture -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 8, 1) = 'a']">
            <note type="{$notePrefix}physDimensions">8 mm. (standard)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 8, 1) = 'b']">
            <note type="{$notePrefix}physDimensions">8 mm. (super/standard)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 8, 1) = 'c']">
            <note type="{$notePrefix}physDimensions">9.5 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 8, 1) = 'd']">
            <note type="{$notePrefix}physDimensions">16 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 8, 1) = 'e']">
            <note type="{$notePrefix}physDimensions">28 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 8, 1) = 'f']">
            <note type="{$notePrefix}physDimensions">35 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 8, 1) = 'g']">
            <note type="{$notePrefix}physDimensions">70 mm.</note>
          </xsl:if>
          <!-- Sound recording -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'a']">
            <note type="{$notePrefix}physDimensions">3 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'b']">
            <note type="{$notePrefix}physDimensions">5 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'c']">
            <note type="{$notePrefix}physDimensions">7 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'd']">
            <note type="{$notePrefix}physDimensions">10 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'e']">
            <note type="{$notePrefix}physDimensions">12 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'f']">
            <note type="{$notePrefix}physDimensions">16 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'g']">
            <note type="{$notePrefix}physDimensions">4 3/4 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'j']">
            <note type="{$notePrefix}physDimensions">3 7/8 x 2 1/2 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 'o']">
            <note type="{$notePrefix}physDimensions">5 1/4 x 3 7/8 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 7, 1) = 's']">
            <note type="{$notePrefix}physDimensions">2 3/4 x 4 in.</note>
          </xsl:if>
          <!-- Videorecording -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 8, 1) = 'a']">
            <note type="{$notePrefix}physDimensions">8 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 8, 1) = 'm']">
            <note type="{$notePrefix}physDimensions">1/4 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 8, 1) = 'o']">
            <note type="{$notePrefix}physDimensions">1/2 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 8, 1) = 'p']">
            <note type="{$notePrefix}physDimensions">1 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 8, 1) = 'q']">
            <note type="{$notePrefix}physDimensions">2 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 8, 1) = 'r']">
            <note type="{$notePrefix}physDimensions">3/4 in.</note>
          </xsl:if>
        </xsl:if>
        <!-- Generation (microform, motion picture) -->
        <xsl:if test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')]">
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')][substring(text(), 12, 1) = 'a']">
            <note type="{$notePrefix}generation">first generation (master)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')][substring(text(), 12, 1) = 'b']">
            <note type="{$notePrefix}generation">printing master</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')][substring(text(), 12, 1) = 'c']">
            <note type="{$notePrefix}generation">service copy</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')][substring(text(), 12, 1) = 'd']">
            <note type="{$notePrefix}generation">duplicate</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')][substring(text(), 12, 1) = 'e']">
            <note type="{$notePrefix}generation">master</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')][substring(text(), 12, 1) = 'm']">
            <note type="{$notePrefix}generation">mixed generation</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')][substring(text(), 12, 1) = 'o']">
            <note type="{$notePrefix}generation">original</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(h|m)')][substring(text(), 12, 1) = 'r']">
            <note type="{$notePrefix}generation">reference print/viewing copy</note>
          </xsl:if>
        </xsl:if>
        <!-- Physical medium and reproduction type (map, globe) -->
        <xsl:if test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')]">
          <!-- Map and globe -->
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'a']">
            <note type="{$notePrefix}physMedium">paper</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'b']">
            <note type="{$notePrefix}physMedium">wood</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'c']">
            <note type="{$notePrefix}physMedium">stone</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'd']">
            <note type="{$notePrefix}physMedium">metal</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'e']">
            <note type="{$notePrefix}physMedium">synthetic</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'f']">
            <note type="{$notePrefix}physMedium">skin</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'g']">
            <note type="{$notePrefix}physMedium">textile</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'i']">
            <note type="{$notePrefix}physMedium">plastic</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'j']">
            <note type="{$notePrefix}physMedium">glass</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'l']">
            <note type="{$notePrefix}physMedium">vinyl</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'n']">
            <note type="{$notePrefix}physMedium">vellum</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'p']">
            <note type="{$notePrefix}physMedium">plaster</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'q']">
            <note type="{$notePrefix}physMedium">flexible base photographic, positive</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'r']">
            <note type="{$notePrefix}physMedium">flexible base photographic, negative</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 's']">
            <note type="{$notePrefix}physMedium">non-flexible base photographic, positive</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 't']">
            <note type="{$notePrefix}physMedium">non-flexible base photographic, negative</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'v']">
            <note type="{$notePrefix}physMedium">leather</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'w']">
            <note type="{$notePrefix}physMedium">parchment</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 5, 1) = 'y']">
            <note type="{$notePrefix}physMedium">photographic medium</note>
          </xsl:if>
          <!-- Reproduction type -->
          <xsl:if
            test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|d)')][substring(text(), 6, 1) = 'f']">
            <note type="{$notePrefix}reproductionType">facsimile</note>
          </xsl:if>
        </xsl:if>
        <!-- Positive/Negative aspect (map, nonprojected graphic, motion picture) -->
        <xsl:if test="*:controlfield[@tag = '007'][matches(substring(text(), 1, 1), '(a|h|m)')]">
          <!-- Map, microform, and motion picture -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 8, 1) = 'a'] or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 4, 1) = 'a'] or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 11, 1) = 'a']">
            <note type="{$notePrefix}positiveNegative">positive</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 8, 1) = 'b'] or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 4, 1) = 'b'] or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 11, 1) = 'b']">
            <note type="{$notePrefix}positiveNegative">negative</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'a'][substring(text(), 8, 1) = 'm'] or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'h'][substring(text(), 4, 1) = 'm'] or *:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 11, 1) = 'm']">
            <note type="{$notePrefix}positiveNegative">negative</note>
          </xsl:if>
        </xsl:if>

        <!-- Physical details in 007 -->
        <!-- Electronic resource -->
        <xsl:if test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c']">
          <!-- Image bit depth -->
          <xsl:for-each
            select="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][matches(substring(text(), 7, 3), '\d\d\d')]">
            <note type="{$notePrefix}imageBitDepth">
              <xsl:value-of select="substring(text(), 7, 3)"/>
            </note>
          </xsl:for-each>
          <xsl:for-each
            select="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][matches(substring(text(), 7, 3), 'mmm')]">
            <note type="{$notePrefix}imageBitDepth">mixed</note>
          </xsl:for-each>
          <!-- Level of compression -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 13, 1) = 'a']">
            <note type="{$notePrefix}compressionLevel">uncompressed</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 13, 1) = 'b']">
            <note type="{$notePrefix}compressionLevel">lossless</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 13, 1) = 'd']">
            <note type="{$notePrefix}compressionLevel">lossy</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'c'][substring(text(), 13, 1) = 'm']">
            <note type="{$notePrefix}compressionLevel">mixed</note>
          </xsl:if>
        </xsl:if>
        <!-- Tactile material -->
        <xsl:if test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f']">
          <!-- Braille class -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 4, 1) = 'a' or substring(text(), 5, 1) = 'a']">
            <note type="{$notePrefix}brailleClass">literary Braille</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 4, 1) = 'b' or substring(text(), 5, 1) = 'b']">
            <note type="{$notePrefix}brailleClass">format code Braille</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 4, 1) = 'c' or substring(text(), 5, 1) = 'c']">
            <note type="{$notePrefix}brailleClass">mathematics and scientific Braille</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 4, 1) = 'd' or substring(text(), 5, 1) = 'd']">
            <note type="{$notePrefix}brailleClass">computer Braille</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 4, 1) = 'e' or substring(text(), 5, 1) = 'e']">
            <note type="{$notePrefix}brailleClass">music Braille</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 4, 1) = 'm' or substring(text(), 5, 1) = 'm']">
            <note type="{$notePrefix}brailleClass">multiple Braille types</note>
          </xsl:if>
          <!-- Braille music format -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'a' or substring(text(), 8, 1) = 'a' or substring(text(), 9, 1) = 'a']">
            <note type="{$notePrefix}brailleMusicFormat">bar over bar</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'b' or substring(text(), 8, 1) = 'b' or substring(text(), 9, 1) = 'b']">
            <note type="{$notePrefix}brailleMusicFormat">bar by bar</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'c' or substring(text(), 8, 1) = 'c' or substring(text(), 9, 1) = 'c']">
            <note type="{$notePrefix}brailleMusicFormat">line over line</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'd' or substring(text(), 8, 1) = 'd' or substring(text(), 9, 1) = 'd']">
            <note type="{$notePrefix}brailleMusicFormat">paragraph</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'e' or substring(text(), 8, 1) = 'e' or substring(text(), 9, 1) = 'e']">
            <note type="{$notePrefix}brailleMusicFormat">single line</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'f' or substring(text(), 8, 1) = 'f' or substring(text(), 9, 1) = 'f']">
            <note type="{$notePrefix}brailleMusicFormat">section by section</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'g' or substring(text(), 8, 1) = 'g' or substring(text(), 9, 1) = 'g']">
            <note type="{$notePrefix}brailleMusicFormat">line by line</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'h' or substring(text(), 8, 1) = 'h' or substring(text(), 9, 1) = 'h']">
            <note type="{$notePrefix}brailleMusicFormat">open score</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'i' or substring(text(), 8, 1) = 'i' or substring(text(), 9, 1) = 'i']">
            <note type="{$notePrefix}brailleMusicFormat">spanner short form scoring</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'j' or substring(text(), 8, 1) = 'j' or substring(text(), 9, 1) = 'j']">
            <note type="{$notePrefix}brailleMusicFormat">short form scoring</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'k' or substring(text(), 8, 1) = 'k' or substring(text(), 9, 1) = 'k']">
            <note type="{$notePrefix}brailleMusicFormat">outline</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'f'][substring(text(), 7, 1) = 'l' or substring(text(), 8, 1) = 'l' or substring(text(), 9, 1) = 'l']">
            <note type="{$notePrefix}brailleMusicFormat">vertical score</note>
          </xsl:if>
        </xsl:if>
        <!-- Sound recording -->
        <xsl:if test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's']">
          <!-- Playing speed -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'd'][substring(text(), 4, 1) = 'a']">
            <note type="{$notePrefix}playingSpeed">16 rpm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'd'][substring(text(), 4, 1) = 'b']">
            <note type="{$notePrefix}playingSpeed">33 1/3 rpm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'd'][substring(text(), 4, 1) = 'c']">
            <note type="{$notePrefix}playingSpeed">45 rpm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'd'][substring(text(), 4, 1) = 'd']">
            <note type="{$notePrefix}playingSpeed">78 rpm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'd'][substring(text(), 4, 1) = 'e']">
            <note type="{$notePrefix}playingSpeed">8 rpm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 2, 1) = 'd'][substring(text(), 4, 1) = 'f']">
            <note type="{$notePrefix}playingSpeed">1.4 m/s</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 4, 1) = 'h']">
            <note type="{$notePrefix}playingSpeed">120 rpm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 4, 1) = 'i']">
            <note type="{$notePrefix}playingSpeed">160 rpm</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 4, 1) = 'k']">
            <note type="{$notePrefix}playingSpeed">15/16 ips</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 4, 1) = 'l']">
            <note type="{$notePrefix}playingSpeed">1 7/8 ips</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 4, 1) = 'm']">
            <note type="{$notePrefix}playingSpeed">3 3/4 ips</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 4, 1) = 'o']">
            <note type="{$notePrefix}playingSpeed">7 1/2 ips</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 4, 1) = 'p']">
            <note type="{$notePrefix}playingSpeed">15 ips</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 4, 1) = 'r']">
            <note type="{$notePrefix}playingSpeed">30 ips</note>
          </xsl:if>
          <!-- Groove characteristics -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 6, 1) = 'm']">
            <note type="{$notePrefix}grooveChar">microgroove/fine</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 6, 1) = 's']">
            <note type="{$notePrefix}grooveChar">coarse/standard</note>
          </xsl:if>
          <!-- Tape width -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 8, 1) = 'l']">
            <note type="{$notePrefix}tapeWidth">1/8 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 8, 1) = 'm']">
            <note type="{$notePrefix}tapeWidth">1/4 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 8, 1) = 'o']">
            <note type="{$notePrefix}tapeWidth">1/2 in.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 8, 1) = 'p']">
            <note type="{$notePrefix}tapeWidth">1 in.</note>
          </xsl:if>
          <!-- Tape configuration -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 9, 1) = 'a']">
            <note type="{$notePrefix}tapeConfig">full (1) track</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 9, 1) = 'b']">
            <note type="{$notePrefix}tapeConfig">half (2) track</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 9, 1) = 'c']">
            <note type="{$notePrefix}tapeConfig">quarter (4) track</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 9, 1) = 'd']">
            <note type="{$notePrefix}tapeConfig">eight track</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 9, 1) = 'e']">
            <note type="{$notePrefix}tapeConfig">twelve track</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 9, 1) = 'f']">
            <note type="{$notePrefix}tapeConfig">sixteen track</note>
          </xsl:if>
          <!-- Kind of disc, cylinder or tape -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 10, 1) = 'a']">
            <note type="{$notePrefix}carrierKind">master tape</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 10, 1) = 'b']">
            <note type="{$notePrefix}carrierKind">tape duplication master</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 10, 1) = 'd']">
            <note type="{$notePrefix}carrierKind">disc master (negative)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 10, 1) = 'i']">
            <note type="{$notePrefix}carrierKind">instantaneous (recorded on the spot)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 10, 1) = 'r']">
            <note type="{$notePrefix}carrierKind">mother (positive)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 10, 1) = 's']">
            <note type="{$notePrefix}carrierKind">stamper (negative)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 10, 1) = 't']">
            <note type="{$notePrefix}carrierKind">test pressing</note>
          </xsl:if>
          <!-- Carrier material -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 'a']">
            <note type="{$notePrefix}carrierMaterial">lacquer coating</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 'b']">
            <note type="{$notePrefix}carrierMaterial">cellulose nitrate</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 'g']">
            <note type="{$notePrefix}carrierMaterial">glass with lacquer</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 'i']">
            <note type="{$notePrefix}carrierMaterial">aluminum with lacquer</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 'l']">
            <note type="{$notePrefix}carrierMaterial">metal</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 'p']">
            <note type="{$notePrefix}carrierMaterial">plastic</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 'r']">
            <note type="{$notePrefix}carrierMaterial">paper with lacquer or ferrous oxide</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 's']">
            <note type="{$notePrefix}carrierMaterial">shellac</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 11, 1) = 'w']">
            <note type="{$notePrefix}carrierMaterial">wax</note>
          </xsl:if>
          <!-- Kind of cutting -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 12, 1) = 'h']">
            <note type="{$notePrefix}cuttingType">hill-and-dale cutting</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 12, 1) = 'l']">
            <note type="{$notePrefix}cuttingType">lateral or combined cutting</note>
          </xsl:if>
          <!-- Special playback characteristics -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 13, 1) = 'a']">
            <note type="{$notePrefix}playbackSpecial">NAB standard</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 13, 1) = 'b']">
            <note type="{$notePrefix}playbackSpecial">CCIR standard</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 13, 1) = 'c']">
            <note type="{$notePrefix}playbackSpecial">Dolby-B encoded</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 13, 1) = 'd']">
            <note type="{$notePrefix}playbackSpecial">dbx encoded</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 13, 1) = 'f']">
            <note type="{$notePrefix}playbackSpecial">Dolby-A encoded</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 13, 1) = 'g']">
            <note type="{$notePrefix}playbackSpecial">Dolby-C encoded</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 13, 1) = 'h']">
            <note type="{$notePrefix}playbackSpecial">CX encoded</note>
          </xsl:if>
          <!-- Capture and storage technique -->
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 14, 1) = 'a']">
            <note type="{$notePrefix}soundCaptureStorage">acoustical capture, direct storage</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 14, 1) = 'b']">
            <note type="{$notePrefix}soundCaptureStorage">electrical capture, direct storage</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 14, 1) = 'd']">
            <note type="{$notePrefix}soundCaptureStorage">electrical capture, digital storage</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 's'][substring(text(), 14, 1) = 'e']">
            <note type="{$notePrefix}soundCaptureStorage">electrical capture, analog electrical
              storage</note>
          </xsl:if>
        </xsl:if>
        <!-- Motion picture -->
        <xsl:if test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm']">
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 5, 1) = 'a']">
            <note type="{$notePrefix}filmPresentationFormat">standard sound aperture (reduced
              frame)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 5, 1) = 'b']">
            <note type="{$notePrefix}filmPresentationFormat">nonanamorphic (wide-screen)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 5, 1) = 'c']">
            <note type="{$notePrefix}filmPresentationFormat">3D</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 5, 1) = 'd']">
            <note type="{$notePrefix}filmPresentationFormat">anamorphic (wide-screen)</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 5, 1) = 'e']">
            <note type="{$notePrefix}filmPresentationFormat">wide-screen format</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'm'][substring(text(), 5, 1) = 'f']">
            <note type="{$notePrefix}filmPresentationFormat">standard silent aperture (full
              frame)</note>
          </xsl:if>
        </xsl:if>
        <!-- Videorecording -->
        <xsl:if test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v']">
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'a']">
            <note type="{$notePrefix}videoFormat">Beta</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'b']">
            <note type="{$notePrefix}videoFormat">VHS</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'c']">
            <note type="{$notePrefix}videoFormat">U-matic</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'd']">
            <note type="{$notePrefix}videoFormat">EIAJ</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'e']">
            <note type="{$notePrefix}videoFormat">Type C</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'f']">
            <note type="{$notePrefix}videoFormat">Quadruplex</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'g']">
            <note type="{$notePrefix}videoFormat">Laserdisc</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'h']">
            <note type="{$notePrefix}videoFormat">CED</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'i']">
            <note type="{$notePrefix}videoFormat">Betacam</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'j']">
            <note type="{$notePrefix}videoFormat">Betacam SP</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'k']">
            <note type="{$notePrefix}videoFormat">Super-VHS</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'm']">
            <note type="{$notePrefix}videoFormat">M-II</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'o']">
            <note type="{$notePrefix}videoFormat">D-2</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'p']">
            <note type="{$notePrefix}videoFormat">8 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'q']">
            <note type="{$notePrefix}videoFormat">Hi-8 mm.</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 's']">
            <note type="{$notePrefix}videoFormat">Blu-ray</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '007'][substring(text(), 1, 1) = 'v'][substring(text(), 5, 1) = 'v']">
            <note type="{$notePrefix}videoFormat">DVD</note>
          </xsl:if>
        </xsl:if>

        <!-- Physical details in 008 -->
        <!-- Books -->
        <xsl:if test="$typeOf008 = 'BK'">
          <!-- Illustrations (008/18-21) -->
          <!-- Use only if there's not a 300 giving details -->
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'a')] and not(*:datafield[@tag = '300'][matches(., '(illustrations?|ill(u?s)?\.)')])">
            <note type="{$notePrefix}illustrations">illustrations</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'b')] and not(*:datafield[@tag = '300'][matches(., 'maps?')])">
            <note type="{$notePrefix}illustrations">maps</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'c')] and not(*:datafield[@tag = '300'][matches(., 'portraits?')])">
            <note type="{$notePrefix}illustrations">portraits</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'd')] and not(*:datafield[@tag = '300'][matches(., 'charts?')])">
            <note type="{$notePrefix}illustrations">charts</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'e')] and not(*:datafield[@tag = '300'][matches(., 'plans?')])">
            <note type="{$notePrefix}illustrations">plans</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'f')] and not(*:datafield[@tag = '300'][matches(., 'plates?')])">
            <note type="{$notePrefix}illustrations">plates</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'g')] and not(*:datafield[@tag = '300'][matches(., 'music')])">
            <note type="{$notePrefix}illustrations">music</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'h')] and not(*:datafield[@tag = '300'][matches(., '(facsimiles?|facsims?\.?)')])">
            <note type="{$notePrefix}illustrations">facsimiles</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'i')] and not(*:datafield[@tag = '300'][matches(., 'coats? of arms')])">
            <note type="{$notePrefix}illustrations">coats of arms</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'j')] and not(*:datafield[@tag = '300'][matches(., 'genealogical tables?')])">
            <note type="{$notePrefix}illustrations">genealogical tables</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'k')] and not(*:datafield[@tag = '300'][matches(., 'forms?')])">
            <note type="{$notePrefix}illustrations">forms</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'l')] and not(*:datafield[@tag = '300'][matches(., 'samples')])">
            <note type="{$notePrefix}illustrations">samples</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'm')] and not(*:datafield[@tag = '300'][matches(., 'phono[^ ]+s?')])">
            <note type="{$notePrefix}illustrations">phonodisc</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'o')] and not(*:datafield[@tag = '300'][matches(., 'photo(graphs?|s?)')])">
            <note type="{$notePrefix}illustrations">photographs</note>
          </xsl:if>
          <xsl:if
            test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'p')] and not(*:datafield[@tag = '300'][matches(., 'illuminations?')])">
            <note type="{$notePrefix}illustrations">illuminations</note>
          </xsl:if>
        </xsl:if>
        <!-- Maps -->
        <xsl:if test="$typeOf008 = 'MP'">
          <!-- Relief (008/18-21) -->
          <xsl:if test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'a')]">
            <note type="{$notePrefix}relief">contours</note>
          </xsl:if>
          <xsl:if test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'b')]">
            <note type="{$notePrefix}relief">shading</note>
          </xsl:if>
          <xsl:if test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'c')]">
            <note type="{$notePrefix}relief">gradient and bathymetric tints</note>
          </xsl:if>
          <xsl:if test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'd')]">
            <note type="{$notePrefix}relief">hachures</note>
          </xsl:if>
          <xsl:if test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'e')]">
            <note type="{$notePrefix}relief">bathymetry/soundings</note>
          </xsl:if>
          <xsl:if test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 4), 'f')]">
            <note type="{$notePrefix}relief">form lines</note>
          </xsl:if>
          <!-- Projection (008/22-23) -->
          <xsl:choose>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'aa')]">
              <note type="{$notePrefix}projection">Aitoff</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'ab')]">
              <note type="{$notePrefix}projection">Gnomic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'ac')]">
              <note type="{$notePrefix}projection">Lambert's azimuthal equal area</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'ad')]">
              <note type="{$notePrefix}projection">orthographic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'ae')]">
              <note type="{$notePrefix}projection">azimuthal equidistant</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'af')]">
              <note type="{$notePrefix}projection">sterographic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'am')]">
              <note type="{$notePrefix}projection">modified stereographic for Alaska</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'an')]">
              <note type="{$notePrefix}projection">Chamberlin trimetric</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'ap')]">
              <note type="{$notePrefix}projection">polar stereographic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'au')]">
              <note type="{$notePrefix}projection">azimuthal</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'az')]">
              <note type="{$notePrefix}projection">azimuthal</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'ba')]">
              <note type="{$notePrefix}projection">Gall</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bb')]">
              <note type="{$notePrefix}projection">Goode's homolographic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bc')]">
              <note type="{$notePrefix}projection">Lambert's cylindrical equal area</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bd')]">
              <note type="{$notePrefix}projection">Mercator</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'be')]">
              <note type="{$notePrefix}projection">Miller</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bf')]">
              <note type="{$notePrefix}projection">Mollweide</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bg')]">
              <note type="{$notePrefix}projection">sinusoidal</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bh')]">
              <note type="{$notePrefix}projection">transverse Mercator</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bi')]">
              <note type="{$notePrefix}projection">Gauss-Kruger</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bj')]">
              <note type="{$notePrefix}projection">equirectangular</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bk')]">
              <note type="{$notePrefix}projection">Krovak</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bl')]">
              <note type="{$notePrefix}projection">Cassini-Soldner</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bo')]">
              <note type="{$notePrefix}projection">oblique Mercator</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'br')]">
              <note type="{$notePrefix}projection">Robinson</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bs')]">
              <note type="{$notePrefix}projection">space oblique Mercator</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bu')]">
              <note type="{$notePrefix}projection">cylindrical</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'bz')]">
              <note type="{$notePrefix}projection">cylindrical</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'ca')]">
              <note type="{$notePrefix}projection">Albers equal area</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'cb')]">
              <note type="{$notePrefix}projection">Bonne</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'cc')]">
              <note type="{$notePrefix}projection">Lambert's conformal conic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'ce')]">
              <note type="{$notePrefix}projection">equidistant conic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'cp')]">
              <note type="{$notePrefix}projection">polyconic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'cu')]">
              <note type="{$notePrefix}projection">conic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'cz')]">
              <note type="{$notePrefix}projection">conic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'da')]">
              <note type="{$notePrefix}projection">armadillo</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'db')]">
              <note type="{$notePrefix}projection">butterfly</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'dc')]">
              <note type="{$notePrefix}projection">Eckert</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'dd')]">
              <note type="{$notePrefix}projection">Goode's homolosine</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'de')]">
              <note type="{$notePrefix}projection">Miller's bipolar oblique conformal conic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'df')]">
              <note type="{$notePrefix}projection">van der Grinten</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'dg')]">
              <note type="{$notePrefix}projection">dimaxion</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'dh')]">
              <note type="{$notePrefix}projection">cordiform</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 23, 2), 'dl')]">
              <note type="{$notePrefix}projection">Lambert conformal</note>
            </xsl:when>
          </xsl:choose>
          <!-- Special format characteristics (008/33-34) -->
          <xsl:if test="*:controlfield[@tag = '008'][contains(substring(text(), 24, 2), 'e')]">
            <note type="{$notePrefix}isHandwritten">handwritten</note>
          </xsl:if>
        </xsl:if>
        <!-- Music -->
        <xsl:if test="$typeOf008 = 'MU'">
          <!-- Form of composition (008/18-19) -->
          <xsl:choose>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'an')]">
              <note type="{$notePrefix}formOfComposition">anthems</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'bd')]">
              <note type="{$notePrefix}formOfComposition">ballads</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'bg')]">
              <note type="{$notePrefix}formOfComposition">bluegrass music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'bl')]">
              <note type="{$notePrefix}formOfComposition">blues</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'bt')]">
              <note type="{$notePrefix}formOfComposition">ballets</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ca')]">
              <note type="{$notePrefix}formOfComposition">chaconnes</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cb')]">
              <note type="{$notePrefix}formOfComposition">chants, Other religions</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cc')]">
              <note type="{$notePrefix}formOfComposition">chant, Christian</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cg')]">
              <note type="{$notePrefix}formOfComposition">concerti grossi</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ch')]">
              <note type="{$notePrefix}formOfComposition">chorales</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cl')]">
              <note type="{$notePrefix}formOfComposition">chorale preludes</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cn')]">
              <note type="{$notePrefix}formOfComposition">canons and rounds</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'co')]">
              <note type="{$notePrefix}formOfComposition">concertos</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cp')]">
              <note type="{$notePrefix}formOfComposition">chansons, polyphonic</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cr')]">
              <note type="{$notePrefix}formOfComposition">carols</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cs')]">
              <note type="{$notePrefix}formOfComposition">chance compositions</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ct')]">
              <note type="{$notePrefix}formOfComposition">cantatas</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cy')]">
              <note type="{$notePrefix}formOfComposition">country music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'cz')]">
              <note type="{$notePrefix}formOfComposition">canzonas</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'df')]">
              <note type="{$notePrefix}formOfComposition">dance forms</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'dv')]">
              <note type="{$notePrefix}formOfComposition">divertimentos, serenades, cassations,
                divertissements, and notturni</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'fg')]">
              <note type="{$notePrefix}formOfComposition">fugues</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'fl')]">
              <note type="{$notePrefix}formOfComposition">flamenco</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'fm')]">
              <note type="{$notePrefix}formOfComposition">folk music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ft')]">
              <note type="{$notePrefix}formOfComposition">fantasias</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'gm')]">
              <note type="{$notePrefix}formOfComposition">gospel music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'hy')]">
              <note type="{$notePrefix}formOfComposition">hymns</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'jz')]">
              <note type="{$notePrefix}formOfComposition">jazz</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'mc')]">
              <note type="{$notePrefix}formOfComposition">musical revues and comedies</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'md')]">
              <note type="{$notePrefix}formOfComposition">madrigals</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'mi')]">
              <note type="{$notePrefix}formOfComposition">minuets</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'mo')]">
              <note type="{$notePrefix}formOfComposition">motets</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'mp')]">
              <note type="{$notePrefix}formOfComposition">motion picture music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'mr')]">
              <note type="{$notePrefix}formOfComposition">marches</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ms')]">
              <note type="{$notePrefix}formOfComposition">masses</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'mu')]">
              <note type="{$notePrefix}formOfComposition">multiple forms</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'mz')]">
              <note type="{$notePrefix}formOfComposition">mazurkas</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'nc')]">
              <note type="{$notePrefix}formOfComposition">nocturnes</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'op')]">
              <note type="{$notePrefix}formOfComposition">operas</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'or')]">
              <note type="{$notePrefix}formOfComposition">oratorios</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ov')]">
              <note type="{$notePrefix}formOfComposition">overtures</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'pg')]">
              <note type="{$notePrefix}formOfComposition">program music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'pm')]">
              <note type="{$notePrefix}formOfComposition">passion music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'po')]">
              <note type="{$notePrefix}formOfComposition">polonaises</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'pp')]">
              <note type="{$notePrefix}formOfComposition">popular music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'pr')]">
              <note type="{$notePrefix}formOfComposition">preludes</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ps')]">
              <note type="{$notePrefix}formOfComposition">passacaglias</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'pt')]">
              <note type="{$notePrefix}formOfComposition">part-songs</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'pv')]">
              <note type="{$notePrefix}formOfComposition">pavans</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'rc')]">
              <note type="{$notePrefix}formOfComposition">rock music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'rd')]">
              <note type="{$notePrefix}formOfComposition">rondos</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'rg')]">
              <note type="{$notePrefix}formOfComposition">ragtime music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ri')]">
              <note type="{$notePrefix}formOfComposition">ricercars</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'rp')]">
              <note type="{$notePrefix}formOfComposition">rhapsodies</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'rq')]">
              <note type="{$notePrefix}formOfComposition">requiems</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'sd')]">
              <note type="{$notePrefix}formOfComposition">square dance music</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'sg')]">
              <note type="{$notePrefix}formOfComposition">songs</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'sn')]">
              <note type="{$notePrefix}formOfComposition">sonatas</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'sp')]">
              <note type="{$notePrefix}formOfComposition">symphonic poems</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'st')]">
              <note type="{$notePrefix}formOfComposition">studies and exercises</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'su')]">
              <note type="{$notePrefix}formOfComposition">suites</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'sy')]">
              <note type="{$notePrefix}formOfComposition">symphonies</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'tc')]">
              <note type="{$notePrefix}formOfComposition">toccatas</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'tl')]">
              <note type="{$notePrefix}formOfComposition">teatro lirico</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'ts')]">
              <note type="{$notePrefix}formOfComposition">trio-sonatas</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'vi')]">
              <note type="{$notePrefix}formOfComposition">villancicos</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'vr')]">
              <note type="{$notePrefix}formOfComposition">variations</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'wz')]">
              <note type="{$notePrefix}formOfComposition">waltzes</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 19, 2), 'za')]">
              <note type="{$notePrefix}formOfComposition">zarzuelas</note>
            </xsl:when>
          </xsl:choose>
          <!-- Format of music (008/20) -->
          <xsl:choose>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'a')]">
              <note type="{$notePrefix}scoreFormat">score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'b')]">
              <note type="{$notePrefix}scoreFormat">study score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'c')]">
              <note type="{$notePrefix}scoreFormat">piano score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'd')]">
              <note type="{$notePrefix}scoreFormat">vocal score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'e')]">
              <note type="{$notePrefix}scoreFormat">piano conductor part</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'g')]">
              <note type="{$notePrefix}scoreFormat">condensed score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'h')]">
              <note type="{$notePrefix}scoreFormat">chorus score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'i')]">
              <note type="{$notePrefix}scoreFormat">condensed score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'j')]">
              <note type="{$notePrefix}scoreFormat">performer conductor part</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'k')]">
              <note type="{$notePrefix}scoreFormat">vocal score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'l')]">
              <note type="{$notePrefix}scoreFormat">score</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 21, 1), 'p')]">
              <note type="{$notePrefix}scoreFormat">piano score</note>
            </xsl:when>
          </xsl:choose>
          <!-- Music parts (008/21) -->
          <xsl:choose>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 22, 1), 'd')]">
              <note type="{$notePrefix}musicParts">instrumental and vocal parts</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 22, 1), 'e')]">
              <note type="{$notePrefix}musicParts">instrumental parts</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 22, 1), 'f')]">
              <note type="{$notePrefix}musicParts">vocal parts</note>
            </xsl:when>
          </xsl:choose>
          <!-- Literary text for sound recording (008/30-31) -->
          <xsl:if test="matches($leader6, 'i|j')">
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'a')">
              <note type="{$notePrefix}literaryText">autobiography</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'b')">
              <note type="{$notePrefix}literaryText">biography</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'c')">
              <note type="{$notePrefix}literaryText">conference publication</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'd')">
              <note type="{$notePrefix}literaryText">drama</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'e')">
              <note type="{$notePrefix}literaryText">essay</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'f')">
              <note type="{$notePrefix}literaryText">fiction</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'g')">
              <note type="{$notePrefix}literaryText">reporting</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'h')">
              <note type="{$notePrefix}literaryText">history</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'i')">
              <note type="{$notePrefix}literaryText">instruction</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'j')">
              <note type="{$notePrefix}literaryText">language instruction</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'k')">
              <note type="{$notePrefix}literaryText">comedy</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'l')">
              <note type="{$notePrefix}literaryText">speech</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'm')">
              <note type="{$notePrefix}literaryText">memoir</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'o')">
              <note type="{$notePrefix}literaryText">folktale</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'p')">
              <note type="{$notePrefix}literaryText">poetry</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 'r')">
              <note type="{$notePrefix}literaryText">rehearsal</note>
            </xsl:if>
            <xsl:if test="matches(substring(*:controlfield[@tag = '008'], 31, 2), 't')">
              <note type="{$notePrefix}literaryText">interview</note>
            </xsl:if>
          </xsl:if>
          <!-- Transposition and arrangement (008/33) -->
          <xsl:choose>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 34, 1), 'a')]">
              <note type="{$notePrefix}transpositionArrangement">transposed</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 34, 1), 'b')]">
              <note type="{$notePrefix}transpositionArrangement">arranged</note>
            </xsl:when>
            <xsl:when test="*:controlfield[@tag = '008'][contains(substring(text(), 34, 1), 'c')]">
              <note type="{$notePrefix}transpositionArrangement">transposed and arranged</note>
            </xsl:when>
          </xsl:choose>
        </xsl:if>
        <!-- Visual material -->
        <xsl:if test="$typeOf008 = 'VM'">
          <!-- Playing time -->
          <xsl:variable name="rawMinutes">
            <xsl:value-of select="substring(*:controlfield[@tag = '008'], 19, 3)"/>
          </xsl:variable>
          <!-- Make sure $rawMinutes is a number greater than 0! -->
          <xsl:if test="number($rawMinutes) and number($rawMinutes) != 0">
            <xsl:variable name="minutes">
              <xsl:value-of select="format-number(($rawMinutes) mod 60, '00')"/>
            </xsl:variable>
            <xsl:variable name="hours">
              <xsl:value-of select="format-number(floor(($rawMinutes) div 60), '###00')"/>
            </xsl:variable>
            <note type="{$notePrefix}playingTime">
              <xsl:value-of select="string-join(($hours, $minutes, '00'), ':')"/>
            </note>
          </xsl:if>
          <xsl:variable name="controlField008-34" select="substring($controlField008, 35, 1)"/>
          <xsl:choose>
            <xsl:when test="$controlField008-34 = 'a'">
              <note type="{$notePrefix}filmVideoTechnique">animation</note>
            </xsl:when>
            <xsl:when test="$controlField008-34 = 'c'">
              <note type="{$notePrefix}filmVideoTechnique">animation and live action</note>
            </xsl:when>
            <xsl:when test="$controlField008-34 = 'l'">
              <note type="{$notePrefix}filmVideoTechnique">live action</note>
            </xsl:when>
          </xsl:choose>
        </xsl:if>

        <!-- Physical details in variable fields -->
        <xsl:for-each select="*:datafield[@tag = '048']">
          <note type="{$notePrefix}instrumentsVoicesCode">
            <xsl:for-each select="*:subfield[matches(@code, 'a|b')]">
              <xsl:if test="position() &gt; 1">
                <xsl:text>, </xsl:text>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </xsl:for-each>
          </note>
          <!-- If no 382, map 048 with MARC code values to note/@type='performanceMedium' -->
          <xsl:if test="not(../*:datafield[@tag = '382']) and @ind2 = ' '">
            <note type="{$notePrefix}performanceMedium">
              <xsl:for-each select="*:subfield[matches(@code, 'a|b')]">
                <xsl:if test="position() &gt; 1">
                  <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:variable name="code">
                  <xsl:value-of select="substring(normalize-space(.), 1, 2)"/>
                </xsl:variable>
                <xsl:variable name="name">
                  <xsl:value-of select="$marcPerfMediumMap/*:instrVoice[@code = $code]"/>
                </xsl:variable>
                <xsl:variable name="count">
                  <xsl:value-of select="substring(normalize-space(.), 3, 2)"/>
                </xsl:variable>
                <xsl:value-of select="$name"/>
                <xsl:if test="number($count) &gt; 1">
                  <xsl:value-of select="concat(' (', number($count), ')')"/>
                </xsl:if>
              </xsl:for-each>
            </note>
          </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '300']">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <xsl:variable name="subfieldA">
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </xsl:variable>
            <!-- The following code doesn't work consistently -->
            <!-- <xsl:if
              test="matches($subfieldA, '\d+ sec(onds|s?\.?)?') or matches($subfieldA, '\d+ min(utes|s?\.?)?')">
              <xsl:variable name="sec">
                <xsl:choose>
                  <xsl:when test="matches(normalize-space($subfieldA), '\d+ sec(onds|s?\.?)?')">
                    <xsl:analyze-string select="normalize-space($subfieldA)" regex="\d+
                      sec(onds|s?\.?)?">
                      <xsl:matching-substring>
                        <xsl:value-of select="number(replace(., '\D', ''))"/>
                      </xsl:matching-substring>
                    </xsl:analyze-string>
                  </xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:variable name="secExcess">
                <xsl:value-of select="floor($sec div 60)"/>
              </xsl:variable>
              <xsl:variable name="seconds">
                <xsl:value-of select="format-number($sec mod 60, '00')"/>
              </xsl:variable>
              <xsl:variable name="min">
                <xsl:choose>
                  <xsl:when test="matches(normalize-space($subfieldA), '\d+ min(utes|s?\.?)?')">
                    <xsl:analyze-string select="normalize-space($subfieldA)" regex="\d+
                      min(utes|s?\.?)?">
                      <xsl:matching-substring>
                        <xsl:value-of select="number(replace(., '\D', ''))"/>
                      </xsl:matching-substring>
                    </xsl:analyze-string>
                  </xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:variable name="minutes">
                <xsl:value-of select="format-number(($min + $secExcess) mod 60, '00')"/>
              </xsl:variable>
              <xsl:variable name="hours">
                <xsl:value-of select="format-number(floor(($min + $secExcess) div 60), '###00')"/>
              </xsl:variable>
              <note type="{$notePrefix}playingTime">
                <xsl:value-of select="string-join(($hours, $minutes, $seconds), ':')"/>
              </note>
            </xsl:if> -->
            <xsl:if test="position() &gt; 1">
              <note type="{$notePrefix}accMatter">
                <xsl:variable name="accMatter">
                  <xsl:value-of select="concat(., ' ')"/>
                  <xsl:value-of select="string-join(following-sibling::*:subfield, ' ')"/>
                </xsl:variable>
                <xsl:value-of select="normalize-space($accMatter)"/>
              </note>
            </xsl:if>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '300']/*:subfield[@code = 'b' or @code = 'e']">
          <xsl:variable name="subfieldBE">
            <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
          </xsl:variable>
          <xsl:analyze-string select="$subfieldBE" regex="(cols?\.|colou?r(ed|s)?|b&amp;w)">
            <xsl:matching-substring>
              <note type="{$notePrefix}colorContent">
                <xsl:value-of
                  select="replace(replace(., '(cols?\.|colou?r(ed|s)?)', 'color'),                   'b&amp;w', 'black and white')"
                />
              </note>
            </xsl:matching-substring>
          </xsl:analyze-string>
          <xsl:analyze-string select="$subfieldBE"
            regex="(illustrations?|ill(u?s)?\.?|maps?|portraits?|ports?\.?|charts?|plans?|plates?|music|facsimiles?|facsims?\.|coats? of arms|genealogical tables?|forms?|samples?|phono[^ ]+s?|photo(graphs?|s?)|illuminations?|lithographs?|diagr(am)?s?)(\s\([^\)]+\))?">
            <xsl:matching-substring>
              <note type="{$notePrefix}illustrations">
                <xsl:value-of
                  select="replace(replace(replace(replace(replace(replace(., 'ill(u?s)?\.', 'illustrations'), 'coat of arms', 'coats of arms'), 'musics', 'music'), 'diagr(am)?s?', 'diagrams'), 'ports?\.?', 'portraits'), 'facsims?\.?', 'facsimiles')"
                />
              </note>
            </xsl:matching-substring>
          </xsl:analyze-string>
          <xsl:analyze-string select="$subfieldBE"
            regex="(quad(\.|raphonic)?|surround|multichannel|stereo(phonic)?|mon(o|aural))">
            <xsl:matching-substring>
              <note type="{$notePrefix}playbackChannels">
                <xsl:value-of
                  select="replace(replace(replace(., 'quad(\.|raphonic)?|multichannel', 'surround'), 'stereophonic', 'stereo'), 'monaural', 'mono')"
                />
              </note>
            </xsl:matching-substring>
          </xsl:analyze-string>
          <xsl:analyze-string select="$subfieldBE"
            regex="(\d+/)?(\d+(\s\d+/\d+|\.\d+)?             (rpm|ips|mps|m(eters?|\.) per sec(ond|\.)))">
            <xsl:matching-substring>
              <note type="{$notePrefix}playingSpeed">
                <xsl:value-of select="replace(., '(mps|m(eters?|\.) per sec(ond|\.))', 'm/s')"/>
              </note>
            </xsl:matching-substring>
          </xsl:analyze-string>
          <xsl:analyze-string select="$subfieldBE" regex="(sd\.|silent|si\.)">
            <xsl:matching-substring>
              <note type="{$notePrefix}soundContent">
                <xsl:value-of select="replace(replace(., 'sd\.', 'sound'), 'si\.', 'silent')"/>
              </note>
            </xsl:matching-substring>
          </xsl:analyze-string>
          <xsl:analyze-string select="$subfieldBE" regex="(analog|digital)">
            <xsl:matching-substring>
              <note type="{$notePrefix}recordingType">
                <xsl:value-of select="."/>
              </note>
            </xsl:matching-substring>
          </xsl:analyze-string>
          <xsl:analyze-string select="$subfieldBE"
            regex="(3D|Cinemiracle|Cinerama|Circarama|IMAX|multiprojector|multiscreen|Panavision|standard             silent aperture|standard sound aperture|stereoscopic|Techniscope)">
            <xsl:matching-substring>
              <note type="{$notePrefix}filmPresentationFormat">
                <xsl:value-of select="."/>
              </note>
            </xsl:matching-substring>
          </xsl:analyze-string>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '300']/*:subfield[@code = 'c'][1]">
          <note type="{$notePrefix}physDimensions">
            <xsl:if test="../*:subfield[@code = '3']">
              <xsl:attribute name="displayLabel">
                <xsl:value-of select="../*:subfield[@code = '3']"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="replace(normalize-space(.), '[,;:]+$', '')"/>
          </note>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '300']/*:subfield[@code = 'e']">
          <note type="{$notePrefix}accMatter">
            <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
          </note>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '306']">
          <!-- Calculate total playing time -->
          <xsl:variable name="collectedSeconds">
            <xsl:for-each select="*:subfield[@code = 'a']">
              <secValue>
                <xsl:value-of select="substring(., 5, 2)"/>
              </secValue>
            </xsl:for-each>
          </xsl:variable>
          <xsl:variable name="sumSeconds">
            <xsl:value-of select="sum($collectedSeconds/*:secValue)"/>
          </xsl:variable>
          <xsl:variable name="collectedMinutes">
            <xsl:for-each select="*:subfield[@code = 'a']">
              <minValue>
                <xsl:value-of select="substring(., 3, 2)"/>
              </minValue>
            </xsl:for-each>
          </xsl:variable>
          <xsl:variable name="sumMinutes">
            <xsl:value-of select="sum($collectedMinutes/*:minValue)"/>
          </xsl:variable>
          <xsl:variable name="collectedHours">
            <xsl:for-each select="*:subfield[@code = 'a']">
              <hourValue>
                <xsl:value-of select="substring(., 1, 2)"/>
              </hourValue>
            </xsl:for-each>
          </xsl:variable>
          <xsl:variable name="sumHours">
            <xsl:value-of select="sum($collectedHours/*:hourValue)"/>
          </xsl:variable>
          <xsl:variable name="seconds">
            <xsl:value-of select="format-number($sumSeconds mod 60, '00')"/>
          </xsl:variable>
          <xsl:variable name="secExcess">
            <xsl:value-of select="floor($sumSeconds div 60)"/>
          </xsl:variable>
          <xsl:variable name="minutes">
            <xsl:value-of select="format-number(($sumMinutes + $secExcess) mod 60, '00')"/>
          </xsl:variable>
          <xsl:variable name="minExcess">
            <xsl:value-of select="floor(($sumMinutes + $secExcess) div 60)"/>
          </xsl:variable>
          <xsl:variable name="hours">
            <xsl:value-of select="format-number($sumHours + $minExcess, '00')"/>
          </xsl:variable>
          <note type="{$notePrefix}playingTime">
            <xsl:value-of select="concat($hours, ':', $minutes, ':', $seconds)"/>
            <!-- Append playing times of parts? -->
            <!--<xsl:if test="count(*:subfield[@code = 'a']) &gt; 1">
              <xsl:text> (</xsl:text>
              <xsl:for-each select="*:subfield[@code = 'a']">
                <xsl:if test="position() &gt; 1">
                  <xsl:text> + </xsl:text>
                </xsl:if>
                <xsl:value-of select="concat(substring(., 1, 2), ':', substring(., 3, 2), ':', substring(., 5, 2))"/>
              </xsl:for-each>
              <xsl:text>)</xsl:text>
            </xsl:if>-->
          </note>
        </xsl:for-each>
        <xsl:for-each
          select="*:datafield[@tag = '336']/*:subfield[@code = 'a'][matches(., 'manuscript|handwritten')]">
          <note type="{$notePrefix}isHandwritten">handwritten</note>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '340']">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <note type="{$notePrefix}physMaterial">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'b']">
            <note type="{$notePrefix}physDimensions">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'c']">
            <note type="{$notePrefix}surfaceMaterial">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'd']">
            <xsl:choose>
              <xsl:when test="matches(., 'manuscript|handwritten')">
                <note type="{$notePrefix}isHandwritten">
                  <xsl:if test="../*:subfield[@code = '3']">
                    <xsl:attribute name="displayLabel">
                      <xsl:value-of select="../*:subfield[@code = '3']"/>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:text>handwritten</xsl:text>
                </note>
              </xsl:when>
              <xsl:otherwise>
                <note type="{$notePrefix}recordingTechnique">
                  <xsl:if test="../*:subfield[@code = '3']">
                    <xsl:attribute name="displayLabel">
                      <xsl:value-of select="../*:subfield[@code = '3']"/>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
                </note>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'e']">
            <note type="{$notePrefix}supportMaterial">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'f']">
            <note type="{$notePrefix}productionRate">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'g']">
            <note type="{$notePrefix}colorContent">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'h']">
            <note type="{$notePrefix}locationWithinMedium">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'i']">
            <note type="{$notePrefix}mediumSpecs">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'j']">
            <note type="{$notePrefix}generation">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'k']">
            <note type="{$notePrefix}layout">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'm']">
            <note type="{$notePrefix}bookFormat">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'n']">
            <note type="{$notePrefix}fontSize">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'o']">
            <note type="{$notePrefix}polarity">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '344']">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <note type="{$notePrefix}recordingType">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'b']">
            <note type="{$notePrefix}recordingMedium">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'c']">
            <note type="{$notePrefix}playingSpeed">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'd']">
            <note type="{$notePrefix}grooveChar">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'e']">
            <note type="{$notePrefix}trackConfig">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'f']">
            <note type="{$notePrefix}tapeConfig">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'g']">
            <note type="{$notePrefix}playbackChannels">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'h']">
            <note type="{$notePrefix}playbackSpecial">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '345']">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <note type="{$notePrefix}filmPresentationFormat">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'b']">
            <note type="{$notePrefix}playingSpeed">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '346']">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <note type="{$notePrefix}videoFormat">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'b']">
            <note type="{$notePrefix}broadcastStandard">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '347']">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <note type="{$notePrefix}fileType">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'b']">
            <note type="{$notePrefix}encodingFormat">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'c']">
            <note type="{$notePrefix}fileSize">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'd']">
            <note type="{$notePrefix}resolution">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'e']">
            <note type="{$notePrefix}regionalEncoding">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'f']">
            <note type="{$notePrefix}bitrate">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '348'] | *:datafield[@tag = '254']">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <note type="{$notePrefix}scoreFormat">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:for-each>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '380']/*:subfield[@code = 'a']">
          <note type="{$notePrefix}work_type">
            <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
          </note>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '382']">
          <note type="{$notePrefix}performanceMedium">
            <xsl:if test="*:subfield[matches(@code, 's|t|r')]">
              <xsl:if test="*:subfield[@code = 's']">
                <xsl:value-of select="concat(*:subfield[@code = 's'], ' performer')"/>
                <xsl:if test="number(*:subfield[@code = 's']) &gt; 1">
                  <xsl:text>s</xsl:text>
                </xsl:if>
              </xsl:if>
              <xsl:if test="*:subfield[@code = 'r']">
                <xsl:if
                  test="*:subfield[@code = 'r']/preceding-sibling::*:subfield[matches(@code, 's|t')]">
                  <xsl:text> + </xsl:text>
                </xsl:if>
                <xsl:value-of select="concat(*:subfield[@code = 'r'], ' soloist')"/>
                <xsl:if test="number(*:subfield[@code = 'r']) &gt; 1">
                  <xsl:text>s</xsl:text>
                </xsl:if>
              </xsl:if>
              <xsl:if test="*:subfield[@code = 't']">
                <xsl:if
                  test="*:subfield[@code = 't']/preceding-sibling::*:subfield[matches(@code, 'r|s')]">
                  <xsl:text> + </xsl:text>
                </xsl:if>
                <xsl:value-of select="concat(*:subfield[@code = 't'], ' ensemble')"/>
                <xsl:if test="number(*:subfield[@code = 't']) &gt; 1">
                  <xsl:text>s</xsl:text>
                </xsl:if>
              </xsl:if>
              <xsl:text>: </xsl:text>
            </xsl:if>
            <xsl:for-each select="*:subfield[matches(@code, 'a|b|d|p|v')]">
              <xsl:choose>
                <xsl:when test="matches(@code, 'a|b|d|p')">
                  <xsl:if test="position() &gt; 1">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
                  <xsl:if
                    test="matches(following-sibling::*:subfield[1]/@code, 'e|n') and normalize-space(following-sibling::*:subfield[1]) != '1'">
                    <xsl:value-of
                      select="concat(' (', normalize-space(following-sibling::*:subfield[1]), ')')"
                    />
                  </xsl:if>
                </xsl:when>
                <xsl:when test="matches(@code, 'v')">
                  <xsl:if test="position() &gt; 1">
                    <xsl:text> </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="concat('[', normalize-space(.), ']')"/>
                </xsl:when>
              </xsl:choose>
            </xsl:for-each>
          </note>
        </xsl:for-each>
        <xsl:for-each
          select="*:datafield[@tag = '384']/*:subfield[@code = 'a'] | *:datafield[matches(@tag, '130|240|243|600|610|630')]/*:subfield[@code = 'r']">
          <note type="{$notePrefix}musicKey">
            <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
          </note>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '386']">
          <note type="{$notePrefix}creatorContributorCharacter">
            <xsl:value-of
              select="normalize-space(replace(string-join(*[matches(@code, '(a|i|m)')], ', '), ':,', ':'))"
            />
          </note>
        </xsl:for-each>
        <xsl:if
          test="*:datafield[matches(@tag, '500|504') and matches(., '(contains|includes).*index', 'i')]">
          <note type="{$notePrefix}containsIndex">
            <xsl:text>yes</xsl:text>
          </note>
        </xsl:if>
        <xsl:if test="*:datafield[matches(@tag, '504') and matches(., 'bibliograph', 'i')]">
          <note type="{$notePrefix}containsBibrefs">
            <xsl:text>yes</xsl:text>
          </note>
        </xsl:if>

        <xsl:for-each select="*:datafield[@tag = '546']/*:subfield[@code = 'b']">
          <xsl:if
            test="matches(., 'Arabic|Chinese|Cyrillic|Devanagari \(Nagari\)|Extended Latin|Greek|Hebrew|Japanese|Korean|Latin|Tamil|Thai', 'i')">
            <note type="{$notePrefix}alphabetScript">
              <xsl:if test="../*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:value-of select="../*:subfield[@code = '3']"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="replace(normalize-space(.), '[.,;:]+$', '')"/>
            </note>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>

      <!-- Sort collected physical details on @type and value -->
      <xsl:variable name="physDetailsSorted">
        <xsl:for-each select="$physDetails/*:note">
          <xsl:sort select="@type"/>
          <xsl:sort select="lower-case(.)"/>
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </xsl:variable>
      <!-- Output unique values and types; this removes duplicates caused by 
        values provided in multiple control fields and variable fields. -->
      <xsl:for-each select="$physDetailsSorted/*:note">
        <xsl:variable name="thisValue">
          <xsl:value-of select="lower-case(.)"/>
        </xsl:variable>
        <xsl:variable name="thisType">
          <xsl:value-of select="@type"/>
        </xsl:variable>
        <xsl:if test="not(preceding-sibling::*[@type eq $thisType][lower-case(.) = $thisValue])">
          <xsl:copy-of select="."/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="string-length(normalize-space($physicalDescription))">
      <physicalDescription>
        <xsl:for-each select="*:datafield[@tag = '300']">
          <!-- Template checks for altRepGroup - 880 $6 -->
          <xsl:call-template name="z3xx880"/>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '337']">
          <!-- Template checks for altRepGroup - 880 $6 -->
          <xsl:call-template name="xxx880"/>
        </xsl:for-each>
        <xsl:for-each select="*:datafield[@tag = '338']">
          <!-- Template checks for altRepGroup - 880 $6 -->
          <xsl:call-template name="xxx880"/>
        </xsl:for-each>
        <xsl:copy-of select="$physicalDescription"/>
      </physicalDescription>
    </xsl:if>

    <!-- abstract -->
    <xsl:for-each select="*:datafield[@tag = '520']">
      <xsl:call-template name="createAbstractFrom520"/>
    </xsl:for-each>

    <!-- tableOfContents -->
    <xsl:for-each select="*:datafield[@tag = '505']">
      <xsl:call-template name="createTOCFrom505"/>
    </xsl:for-each>

    <!-- audience -->
    <xsl:for-each select="*:datafield[@tag = '521']">
      <xsl:call-template name="createTargetAudienceFrom521"/>
    </xsl:for-each>

    <!-- accessCondition -->
    <xsl:for-each select="*:datafield[@tag = '540']">
      <xsl:call-template name="createAccessConditionFrom540"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '506']">
      <xsl:call-template name="createAccessConditionFrom506"/>
    </xsl:for-each>

    <!-- targetAudience from 008 -->
    <xsl:if test="$typeOf008 = 'BK' or $typeOf008 = 'CF' or $typeOf008 = 'MU' or $typeOf008 = 'VM'">
      <xsl:variable name="controlField008-22" select="substring($controlField008, 23, 1)"/>
      <xsl:choose>
        <xsl:when test="$controlField008-22 = 'd'">
          <targetAudience authority="marctarget">adolescent</targetAudience>
        </xsl:when>
        <xsl:when test="$controlField008-22 = 'e'">
          <targetAudience authority="marctarget">adult</targetAudience>
        </xsl:when>
        <xsl:when test="$controlField008-22 = 'g'">
          <targetAudience authority="marctarget">general</targetAudience>
        </xsl:when>
        <xsl:when
          test="$controlField008-22 = 'b' or $controlField008-22 = 'c' or $controlField008-22 = 'j'">
          <targetAudience authority="marctarget">juvenile</targetAudience>
        </xsl:when>
        <xsl:when test="$controlField008-22 = 'a'">
          <targetAudience authority="marctarget">preschool</targetAudience>
        </xsl:when>
        <xsl:when test="$controlField008-22 = 'f'">
          <targetAudience authority="marctarget">specialized</targetAudience>
        </xsl:when>
      </xsl:choose>
    </xsl:if>

    <!-- targetAudience from 385 -->
    <xsl:for-each
      select="*:datafield[@tag = '385'][*:subfield[@code = 'a' and not(matches(., '^(adolescent|adult|general|juvenile|preschool|specialized)$', 'i'))]]">
      <targetAudience>
        <xsl:if test="*:subfield[@code = '2']">
          <xsl:attribute name="authority">
            <xsl:call-template name="chopPunctuationBack">
              <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="normalize-space(string-join(*[@code = 'a'], ', '))"/>
      </targetAudience>
    </xsl:for-each>

    <!-- note -->
    <xsl:for-each select="*:datafield[@tag = '245']">
      <xsl:call-template name="createNoteFrom245c"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '362']">
      <xsl:call-template name="createNoteFrom362"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '500']">
      <xsl:call-template name="createNoteFrom500"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '502']">
      <xsl:call-template name="createNoteFrom502"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '504']">
      <xsl:call-template name="createNoteFrom504"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '508']">
      <xsl:call-template name="createNoteFrom508"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '511']">
      <xsl:call-template name="createNoteFrom511"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '515']">
      <xsl:call-template name="createNoteFrom515"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '518']">
      <xsl:call-template name="createNoteFrom518"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '524']">
      <xsl:call-template name="createNoteFrom524"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '530']">
      <xsl:call-template name="createNoteFrom530"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '533']">
      <xsl:call-template name="createNoteFrom533"/>
    </xsl:for-each>
    <!-- <xsl:for-each select="*:datafield[@tag=534]">
			<xsl:call-template name="createNoteFrom534"/>
		</xsl:for-each> -->
    <xsl:for-each select="*:datafield[@tag = '535']">
      <xsl:call-template name="createNoteFrom535"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '536']">
      <xsl:call-template name="createNoteFrom536"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '538']">
      <xsl:call-template name="createNoteFrom538"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '541']">
      <xsl:call-template name="createNoteFrom541"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '545']">
      <xsl:call-template name="createNoteFrom545"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '546']">
      <xsl:call-template name="createNoteFrom546"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '561']">
      <xsl:call-template name="createNoteFrom561"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '562']">
      <xsl:call-template name="createNoteFrom562"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '581']">
      <xsl:call-template name="createNoteFrom581"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '583']">
      <xsl:call-template name="createNoteFrom583"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '585']">
      <xsl:call-template name="createNoteFrom585"/>
    </xsl:for-each>
    <xsl:for-each
      select="*:datafield[@tag = '501' or @tag = '507' or @tag = '513' or @tag = '514' or @tag = '516' or @tag = '522' or @tag = '525' or @tag = '526' or @tag = '544' or @tag = '547' or @tag = '550' or @tag = '552' or @tag = '555' or @tag = '556' or @tag = '565' or @tag = '567' or @tag = '580' or @tag = '584' or @tag = '586']">
      <xsl:call-template name="createNoteFrom5XX"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[matches(@tag, '^59')]">
      <xsl:call-template name="createNoteFrom59x"/>
    </xsl:for-each>

    <!-- subject -->
    <xsl:for-each select="*:datafield[@tag = '034']">
      <xsl:call-template name="createSubGeoFrom034"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '043']">
      <xsl:if test="$createSubjectFrom043 = 'true'">
        <xsl:call-template name="createSubGeoFrom043"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '045']">
      <xsl:call-template name="createSubTemFrom045"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '255']">
      <xsl:call-template name="createSubGeoFrom255"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '600']">
      <xsl:call-template name="createSubNameFrom600"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '610']">
      <xsl:call-template name="createSubNameFrom610"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '611']">
      <xsl:call-template name="createSubNameFrom611"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '630']">
      <xsl:call-template name="createSubTitleFrom630"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '648']">
      <xsl:call-template name="createSubChronFrom648"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '650']">
      <xsl:call-template name="createSubTopFrom650"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '651']">
      <xsl:call-template name="createSubGeoFrom651"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '653']">
      <xsl:call-template name="createSubFrom653"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '656']">
      <xsl:call-template name="createSubFrom656"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '662']">
      <xsl:call-template name="createSubGeoFrom662752"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '752']">
      <xsl:call-template name="createSubGeoFrom662752"/>
    </xsl:for-each>

    <!-- classification from 0XX -->
    <xsl:for-each select="*:datafield[@tag = '050']">
      <xsl:call-template name="createClassificationFrom050"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '060']">
      <xsl:call-template name="createClassificationFrom060"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '080']">
      <xsl:call-template name="createClassificationFrom080"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '082']">
      <xsl:call-template name="createClassificationFrom082"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '084']">
      <xsl:call-template name="createClassificationFrom084"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '086']">
      <xsl:call-template name="createClassificationFrom086"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '090']">
      <xsl:call-template name="createClassificationFrom090"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '099']">
      <xsl:call-template name="createClassificationFrom099"/>
    </xsl:for-each>

    <!-- location -->
    <xsl:if test="not(*:datafield[@tag = '999'])">
      <xsl:for-each select="*:datafield[@tag = '852']">
        <xsl:call-template name="createLocationFrom852"/>
      </xsl:for-each>
      <xsl:if
        test="*:datafield[matches(@tag, '866|867|868')] and count(*:datafield[@tag = '852']) &gt; 1">
        <xsl:call-template name="createLocationFrom866-868"/>
      </xsl:if>
    </xsl:if>

    <!-- location/relatedItem -->
    <xsl:for-each select="*:datafield[@tag = '856']">
      <xsl:call-template name="createLocationOrRelatedItemFrom856"/>
    </xsl:for-each>

    <!-- relatedItem -->
    <xsl:for-each select="*:datafield[@tag = '440']">
      <relatedItem type="series">
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">av</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '490'][@ind1 = '0']">
      <xsl:call-template name="createRelatedItemFrom490"/>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '510']">
      <relatedItem type="isReferencedBy">
        <xsl:for-each select="*:subfield[@code = 'a']">
          <titleInfo>
            <title>
              <xsl:value-of select="."/>
            </title>
          </titleInfo>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'b']">
          <originInfo>
            <dateOther type="coverage">
              <xsl:value-of select="."/>
            </dateOther>
          </originInfo>
        </xsl:for-each>
        <xsl:if test="*:subfield[matches(@code, '3|c')]">
          <part>
            <detail type="part">
              <xsl:if test="*:subfield[matches(@code, '3')]">
                <title>
                  <xsl:text>(</xsl:text>
                  <xsl:call-template name="chopPunctuation">
                    <xsl:with-param name="chopString">
                      <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">3</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                  <xsl:text>),</xsl:text>
                </title>
              </xsl:if>
              <xsl:if test="*:subfield[matches(@code, 'c')]">
                <number>
                  <xsl:call-template name="chopPunctuation">
                    <xsl:with-param name="chopString">
                      <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">c</xsl:with-param>
                      </xsl:call-template>
                    </xsl:with-param>
                  </xsl:call-template>
                </number>
              </xsl:if>
            </detail>
          </part>
        </xsl:if>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '534']">
      <relatedItem type="original">
        <xsl:call-template name="relatedTitle"/>
        <xsl:call-template name="relatedName"/>
        <xsl:if test="*:subfield[@code = 'b' or @code = 'c']">
          <originInfo>
            <xsl:for-each select="*:subfield[@code = 'c']">
              <publisher>
                <xsl:value-of select="."/>
              </publisher>
            </xsl:for-each>
            <xsl:for-each select="*:subfield[@code = 'b']">
              <edition>
                <xsl:value-of select="."/>
              </edition>
            </xsl:for-each>
          </originInfo>
        </xsl:if>
        <xsl:call-template name="relatedIdentifierISSN"/>
        <xsl:for-each select="*:subfield[@code = 'z']">
          <identifier type="isbn">
            <xsl:call-template name="chopPunctuationBack">
              <xsl:with-param name="chopString" select="."/>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </identifier>
        </xsl:for-each>
        <xsl:call-template name="relatedNote"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '700'][*:subfield[@code = 't']]">
      <relatedItem>
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="constituentOrRelatedType"/>
        <name type="personal">
          <namePart>
            <xsl:call-template name="specialSubfieldSelect">
              <xsl:with-param name="anyCodes">aq</xsl:with-param>
              <xsl:with-param name="axis">t</xsl:with-param>
              <xsl:with-param name="beforeCodes">g</xsl:with-param>
            </xsl:call-template>
          </namePart>
          <xsl:call-template name="termsOfAddress"/>
          <xsl:call-template name="nameDate"/>
          <xsl:call-template name="role"/>
        </name>
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="specialSubfieldSelect">
                  <xsl:with-param name="anyCodes">tfklmorsv</xsl:with-param>
                  <xsl:with-param name="axis">t</xsl:with-param>
                  <xsl:with-param name="afterCodes">g</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
        <xsl:call-template name="relatedForm"/>
        <xsl:call-template name="relatedIdentifierISSN"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '710'][*:subfield[@code = 't']]">
      <relatedItem>
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="constituentOrRelatedType"/>
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="specialSubfieldSelect">
                  <xsl:with-param name="anyCodes">tfklmorsv</xsl:with-param>
                  <xsl:with-param name="axis">t</xsl:with-param>
                  <xsl:with-param name="afterCodes">dg</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="relatedPartNumName"/>
        </titleInfo>
        <name type="corporate">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <namePart>
              <xsl:value-of select="."/>
            </namePart>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'b']">
            <namePart>
              <xsl:value-of select="."/>
            </namePart>
          </xsl:for-each>
          <xsl:variable name="tempNamePart">
            <xsl:call-template name="specialSubfieldSelect">
              <xsl:with-param name="anyCodes">c</xsl:with-param>
              <xsl:with-param name="axis">t</xsl:with-param>
              <xsl:with-param name="beforeCodes">dgn</xsl:with-param>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="normalize-space($tempNamePart)">
            <namePart>
              <xsl:value-of select="$tempNamePart"/>
            </namePart>
          </xsl:if>
          <xsl:call-template name="role"/>
        </name>
        <xsl:call-template name="relatedForm"/>
        <xsl:call-template name="relatedIdentifierISSN"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '711'][*:subfield[@code = 't']]">
      <relatedItem>
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="constituentOrRelatedType"/>
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="specialSubfieldSelect">
                  <xsl:with-param name="anyCodes">tfklsv</xsl:with-param>
                  <xsl:with-param name="axis">t</xsl:with-param>
                  <xsl:with-param name="afterCodes">g</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="relatedPartNumName"/>
        </titleInfo>
        <name type="conference">
          <namePart>
            <xsl:call-template name="specialSubfieldSelect">
              <xsl:with-param name="anyCodes">aqdc</xsl:with-param>
              <xsl:with-param name="axis">t</xsl:with-param>
              <xsl:with-param name="beforeCodes">gn</xsl:with-param>
            </xsl:call-template>
          </namePart>
        </name>
        <xsl:call-template name="relatedForm"/>
        <xsl:call-template name="relatedIdentifierISSN"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '730']">
      <relatedItem>
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="constituentOrRelatedType"/>
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">adfgklmorsv</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
        <xsl:call-template name="relatedForm"/>
        <xsl:call-template name="relatedIdentifierISSN"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '740'][@ind2 = '2']">
      <relatedItem>
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="constituentOrRelatedType"/>
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'a']"/>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
        <xsl:call-template name="relatedForm"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '760']">
      <relatedItem type="series">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '762']">
      <relatedItem type="constituent">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each
      select="*:datafield[@tag = '765'] | *:datafield[@tag = '767'] | *:datafield[@tag = '775']">
      <relatedItem type="otherVersion">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '770'] | *:datafield[@tag = '774']">
      <relatedItem type="constituent">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '772'] | *:datafield[@tag = '773']">
      <relatedItem type="host">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '776']">
      <relatedItem type="otherFormat">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '780']">
      <relatedItem type="preceding">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '785']">
      <relatedItem type="succeeding">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '786']">
      <relatedItem type="original">
        <xsl:if test="*:subfield[@code = 'i']">
          <xsl:attribute name="otherType">
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="*:subfield[@code = 'i']"/>
              </xsl:with-param>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="relatedItem76X-78X"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '800']">
      <relatedItem type="series">
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="specialSubfieldSelect">
                  <xsl:with-param name="anyCodes">tfklmorsv</xsl:with-param>
                  <xsl:with-param name="axis">t</xsl:with-param>
                  <xsl:with-param name="afterCodes">g</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
        <name type="personal">
          <namePart>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="specialSubfieldSelect">
                  <xsl:with-param name="anyCodes">aq</xsl:with-param>
                  <xsl:with-param name="axis">t</xsl:with-param>
                  <xsl:with-param name="beforeCodes">g</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </namePart>
          <xsl:call-template name="termsOfAddress"/>
          <xsl:call-template name="nameDate"/>
          <xsl:call-template name="role"/>
        </name>
        <xsl:call-template name="relatedForm"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '810']">
      <relatedItem type="series">
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="specialSubfieldSelect">
                  <xsl:with-param name="anyCodes">tfklmorsv</xsl:with-param>
                  <xsl:with-param name="axis">t</xsl:with-param>
                  <xsl:with-param name="afterCodes">dg</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="relatedPartNumName"/>
        </titleInfo>
        <name type="corporate">
          <xsl:for-each select="*:subfield[@code = 'a']">
            <namePart>
              <xsl:value-of select="."/>
            </namePart>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'b']">
            <namePart>
              <xsl:value-of select="."/>
            </namePart>
          </xsl:for-each>
          <xsl:if test="*:subfield[@code = 'c']">
            <namePart>
              <xsl:call-template name="specialSubfieldSelect">
                <xsl:with-param name="anyCodes">c</xsl:with-param>
                <xsl:with-param name="axis">t</xsl:with-param>
                <xsl:with-param name="beforeCodes">dgn</xsl:with-param>
              </xsl:call-template>
            </namePart>
          </xsl:if>
          <xsl:call-template name="role"/>
        </name>
        <xsl:call-template name="relatedForm"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '811']">
      <relatedItem type="series">
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="specialSubfieldSelect">
                  <xsl:with-param name="anyCodes">tfklsv</xsl:with-param>
                  <xsl:with-param name="axis">t</xsl:with-param>
                  <xsl:with-param name="afterCodes">g</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="relatedPartNumName"/>
        </titleInfo>
        <name type="conference">
          <namePart>
            <xsl:call-template name="specialSubfieldSelect">
              <xsl:with-param name="anyCodes">aqdc</xsl:with-param>
              <xsl:with-param name="axis">t</xsl:with-param>
              <xsl:with-param name="beforeCodes">gn</xsl:with-param>
            </xsl:call-template>
          </namePart>
          <xsl:call-template name="role"/>
        </name>
        <xsl:call-template name="relatedForm"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '830']">
      <relatedItem type="series">
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">adfgklmorsv</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
        <xsl:call-template name="relatedForm"/>
      </relatedItem>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '880']">
      <xsl:apply-templates select="self::*" mode="trans880"/>
    </xsl:for-each>

    <!-- identifier -->
    <xsl:for-each select="*:datafield[@tag = '020']">
      <xsl:if test="*:subfield[@code = 'a']">
        <identifier type="isbn">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = 'a']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </identifier>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '020']">
      <xsl:for-each select="*:subfield[@code = 'z']">
        <identifier type="isbn" invalid="yes">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="."/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </identifier>
      </xsl:for-each>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '024'][@ind1 = '0']">
      <xsl:if test="*:subfield[@code = 'a']">
        <identifier type="isrc">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = 'a']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </identifier>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '024'][@ind1 = '2']">
      <xsl:if test="*:subfield[@code = 'a']">
        <identifier type="ismn">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = 'a']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </identifier>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '024'][@ind1 = '4']">
      <identifier type="sici">
        <xsl:call-template name="subfieldSelect">
          <xsl:with-param name="codes">ab</xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '024'][@ind1 = '7']">
      <identifier>
        <xsl:if test="*:subfield[@code = '2']">
          <xsl:attribute name="type">
            <xsl:call-template name="chopPunctuationBack">
              <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="*:subfield[@code = 'a']"/>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '024'][@ind1 = '8']">
      <identifier>
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="*:subfield[@code = 'a']"/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '022']/*:subfield[@code = 'a']">
      <identifier type="issn">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="."/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '022']/*:subfield[@code = 'z']">
      <identifier type="issn" invalid="yes">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="."/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '022']/*:subfield[@code = 'y']">
      <identifier type="issn" invalid="yes">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="."/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '022'][*:subfield[@code = 'l']]">
      <xsl:if test="*:subfield[@code = 'l']">
        <identifier type="issn-l">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = 'l']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </identifier>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '022']/*:subfield[@code = 'm']">
      <identifier type="issn-l" invalid="yes">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="*:subfield[@code = 'm']"/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '010']/*:subfield[@code = 'a']">
      <identifier type="lccn">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="."/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '010']/*:subfield[@code = 'z']">
      <identifier type="lccn" invalid="yes">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="."/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '028']">
      <identifier>
        <xsl:attribute name="type">
          <xsl:choose>
            <xsl:when test="@ind1 = '0'">issue number</xsl:when>
            <xsl:when test="@ind1 = '1'">matrix number</xsl:when>
            <xsl:when test="@ind1 = '2'">music plate</xsl:when>
            <xsl:when test="@ind1 = '3'">music publisher</xsl:when>
            <xsl:when test="@ind1 = '4'">videorecording identifier</xsl:when>
          </xsl:choose>
        </xsl:attribute>
        <xsl:call-template name="subfieldSelect">
          <xsl:with-param name="codes">
            <xsl:choose>
              <xsl:when test="@ind1 = '0'">ba</xsl:when>
              <xsl:otherwise>ab</xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
    <xsl:variable name="oclcNumbers">
      <xsl:for-each
        select="*:datafield[@tag = '035'][*:subfield[@code = 'a'][matches(text(), '(OCo?LC)')]]">
        <identifier type="oclc">
          <xsl:value-of
            select="normalize-space(substring-after(replace(*:subfield[@code = 'a'], 'OCo?LC', 'OCoLC'), '(OCoLC)'))"
          />
        </identifier>
      </xsl:for-each>
    </xsl:variable>
    <xsl:for-each select="distinct-values($oclcNumbers/*:identifier)">
      <identifier type="oclc">
        <xsl:value-of select="."/>
      </identifier>
    </xsl:for-each>
    <xsl:for-each
      select="*:datafield[@tag = '035'][*:subfield[@code = 'a'][contains(text(), '(WlCaITV)')]]">
      <identifier type="WlCaITV">
        <xsl:value-of
          select="normalize-space(substring-after(*:subfield[@code = 'a'], '(WlCaITV)'))"/>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '037']">
      <xsl:if test="*:subfield[@code = 'a']">
        <identifier type="stock number">
          <xsl:if test="*:subfield[@code = 'c']">
            <xsl:attribute name="displayLabel">
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">c</xsl:with-param>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">ab</xsl:with-param>
          </xsl:call-template>
        </identifier>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '383' and *:subfield[matches(@code, 'a|b')]]">
      <identifier type="work">
        <xsl:call-template name="subfieldSelect">
          <xsl:with-param name="codes">ab</xsl:with-param>
        </xsl:call-template>
        <xsl:if test="*:subfield[@code = 'e']">
          <xsl:text> (</xsl:text>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:value-of select="*:subfield[@code = 'e']"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:text>)</xsl:text>
        </xsl:if>
      </identifier>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '383' and *:subfield[matches(@code, 'c|d')]]">
      <xsl:for-each select="*:subfield[@code = 'c']">
        <identifier type="work">
          <xsl:value-of select="normalize-space(.)"/>
          <xsl:if test="../*:subfield[@code = 'd']">
            <xsl:text> (</xsl:text>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:value-of select="../*:subfield[@code = 'd']"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:text>)</xsl:text>
          </xsl:if>
        </identifier>
      </xsl:for-each>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '024'][@ind1 = '1']">
      <identifier type="upc">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="*:subfield[@code = 'a']"/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>

    <!-- holdingSimple -->
    <xsl:choose>
      <!-- Barcode parameter present, limit holdings to single item -->
      <xsl:when
        test="normalize-space($barcode) != '' and //*:datafield[@tag = '999'][*:subfield[@code = 'i'][matches(., $barcode)]]">
        <xsl:for-each
          select="//*:datafield[@tag = '999'][*:subfield[@code = 'i'][matches(., $barcode)]]">
          <xsl:call-template name="createHoldingSimpleFrom999"/>
        </xsl:for-each>
      </xsl:when>
      <!-- Process all holdings -->
      <xsl:when test="//*:datafield[@tag = '999']">
        <xsl:for-each select="//*:datafield[@tag = '999']">
          <xsl:sort select="*:subfield[@code = 'a']"/>
          <xsl:call-template name="createHoldingSimpleFrom999"/>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>

    <!-- location -->
    <xsl:for-each select="*:datafield[@tag = '974']">
      <xsl:sort select="*:subfield[@code = 'z']"/>
      <xsl:sort/>
      <xsl:call-template name="createLocationFrom974"/>
    </xsl:for-each>

    <recordInfo>
      <xsl:for-each select="*:leader[substring($leader, 19, 1) = 'a']">
        <descriptionStandard>aacr</descriptionStandard>
      </xsl:for-each>
      <xsl:for-each select="*:datafield[@tag = '040']">
        <xsl:if test="*:subfield[@code = 'e']">
          <descriptionStandard>
            <xsl:value-of select="*:subfield[@code = 'e']"/>
          </descriptionStandard>
        </xsl:if>
        <xsl:variable name="sources">
          <xsl:for-each select="*:subfield[matches(@code, 'a|c|d')]">
            <source>
              <xsl:value-of select="normalize-space(.)"/>
            </source>
          </xsl:for-each>
        </xsl:variable>
        <!-- Dedupe recordContentSource values -->
        <xsl:for-each select="distinct-values($sources/*:source)">
          <recordContentSource authority="marcorg">
            <xsl:value-of select="."/>
          </recordContentSource>
        </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="*:controlfield[@tag = '008']">
        <recordCreationDate encoding="marc">
          <xsl:value-of select="substring(., 1, 6)"/>
        </recordCreationDate>
      </xsl:for-each>
      <xsl:for-each select="*:controlfield[@tag = '005']">
        <recordChangeDate encoding="iso8601">
          <xsl:value-of select="."/>
        </recordChangeDate>
      </xsl:for-each>
      <xsl:for-each select="*:controlfield[@tag = '001']">
        <recordIdentifier>
          <xsl:if test="../*:controlfield[@tag = '003']">
            <xsl:attribute name="source">
              <xsl:value-of select="../*:controlfield[@tag = '003']"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="."/>
        </recordIdentifier>
      </xsl:for-each>

      <recordOrigin>Converted from MARCXML to MODS version 3.6 using <xsl:value-of
          select="$progName"/> (v. <xsl:value-of select="$progVersion"/>) on <xsl:value-of
          select="format-date(current-date(), '[Y]-[M01]-[D01]')"/> at <xsl:value-of
          select="format-time(current-time(), '[h]:[m] [P]')"/></recordOrigin>

      <xsl:for-each select="*:datafield[@tag = '040']/*:subfield[@code = 'b']">
        <languageOfCataloging>
          <languageTerm authority="iso639-2b" type="code">
            <xsl:value-of select="."/>
          </languageTerm>
        </languageOfCataloging>
      </xsl:for-each>
    </recordInfo>
  </xsl:template>

  <xsl:template name="createLocationOrRelatedItemFrom856">
    <xsl:variable name="elementName">
      <xsl:choose>
        <xsl:when test="matches(@ind2, '0')">location</xsl:when>
        <xsl:otherwise>relatedItem</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="{$elementName}">
      <xsl:choose>
        <xsl:when test="$elementName = 'location'">
          <url displayLabel="electronic resource">
            <xsl:variable name="primary">
              <xsl:choose>
                <xsl:when
                  test="@ind2 = '0' and count(preceding-sibling::*:datafield[@tag = '856'][@ind2 = '0']) = 0"
                  >true</xsl:when>
                <xsl:when
                  test="@ind2 = '1' and count(ancestor::*:record//*:datafield[@tag = '856'][@ind2 = '0']) = 0 and count(preceding-sibling::*:datafield[@tag = '856'][@ind2 = '1']) = 0"
                  >true</xsl:when>
                <xsl:when
                  test="@ind2 != '1' and @ind2 != '0' and @ind2 != '2' and count(ancestor::*:record//*:datafield[@tag = '856' and @ind2 = '0']) = 0 and count(ancestor::*:record//*:datafield[@tag = '856' and @ind2 = '1']) = 0 and count(preceding-sibling::*:datafield[@tag = '856'][@ind2]) = 0"
                  >true</xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:if test="$primary = 'true'">
              <xsl:attribute name="usage">primary display</xsl:attribute>
            </xsl:if>
            <xsl:if test="*:subfield[@code = 'y' or @code = '3']">
              <xsl:attribute name="displayLabel">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">y3</xsl:with-param>
                </xsl:call-template>
              </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="*:subfield[@code = 'u']"/>
          </url>
          <xsl:if test="*:subfield[@code = 'z']">
            <note>
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">z</xsl:with-param>
              </xsl:call-template>
            </note>
          </xsl:if>
        </xsl:when>
        <xsl:when test="$elementName = 'relatedItem'">
          <!-- \s, 2, 3, 4, or 8 -->
          <xsl:if test="matches(@ind2, '[134]')">
            <xsl:attribute name="type">
              <xsl:choose>
                <xsl:when test="@ind2 = '1'">otherVersion</xsl:when>
                <xsl:when test="@ind2 = '3' or @ind2 = '4'">constituent</xsl:when>
                <xsl:otherwise>otherFormat</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="*:subfield[@code = 'i']">
            <xsl:attribute name="otherType">
              <xsl:call-template name="chopPunctuation">
                <xsl:with-param name="chopString">
                  <xsl:value-of select="*:subfield[@code = 'i']"/>
                </xsl:with-param>
                <xsl:with-param name="punctuation">
                  <xsl:text>.:,;/ </xsl:text>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>
          <xsl:for-each select="*:subfield[@code = 'n']">
            <accessCondition type="restriction on access">
              <xsl:value-of select="normalize-space(.)"/>
            </accessCondition>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'g']">
            <identifier>
              <xsl:call-template name="chopPunctuationBack">
                <xsl:with-param name="chopString" select="."/>
                <xsl:with-param name="punctuation">
                  <xsl:text>.:,;/ </xsl:text>
                </xsl:with-param>
              </xsl:call-template>
            </identifier>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'q']">
            <internetMediaType>
              <xsl:value-of select="normalize-space(.)"/>
            </internetMediaType>
          </xsl:for-each>
          <location>
            <url>
              <xsl:variable name="primary">
                <xsl:choose>
                  <xsl:when test="count(preceding-sibling::*:datafield[@tag = '856']) = 0"
                    >true</xsl:when>
                  <xsl:when test="count(ancestor::*:record//*:datafield[@tag = '856']) = 0"
                    >true</xsl:when>
                  <xsl:otherwise>false</xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:if test="$primary = 'true'">
                <xsl:attribute name="usage">primary display</xsl:attribute>
              </xsl:if>
              <xsl:if test="*:subfield[@code = '3']">
                <xsl:attribute name="displayLabel">
                  <xsl:call-template name="subfieldSelect">
                    <xsl:with-param name="codes">3</xsl:with-param>
                  </xsl:call-template>
                </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="*:subfield[@code = 'u']"/>
            </url>
          </location>
          <!-- Only public notes are transcoded -->
          <xsl:if test="*:subfield[@code = 'z']">
            <note>
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">z</xsl:with-param>
              </xsl:call-template>
            </note>
          </xsl:if>
          <xsl:for-each select="*:subfield[@code = 'm']">
            <note>
              <xsl:text>Contact for access assistance: </xsl:text>
              <xsl:value-of select="normalize-space(.)"/>
            </note>
          </xsl:for-each>
          <!-- accessCondition from $r and $t -->
          <xsl:for-each select="*:subfield[matches(@code, '[rt]')]">
            <accessCondition type="use and reproduction">
              <xsl:value-of select="."/>
            </accessCondition>
          </xsl:for-each>
        </xsl:when>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:template name="displayForm">
    <xsl:for-each select="*:subfield[@code = 'c']">
      <displayForm>
        <xsl:value-of select="."/>
      </displayForm>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="affiliation">
    <xsl:for-each select="*:subfield[@code = 'u']">
      <affiliation>
        <xsl:value-of select="."/>
      </affiliation>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="uri">
    <xsl:for-each select="*:subfield[@code = 'u'] | *:subfield[@code = '0']">
      <xsl:attribute name="xlink:href">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="role">
    <xsl:for-each select="*:subfield[@code = 'e']">
      <role>
        <roleTerm type="text">
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString" select="."/>
          </xsl:call-template>
        </roleTerm>
      </role>
    </xsl:for-each>
    <xsl:for-each select="*:subfield[@code = '4']">
      <role>
        <roleTerm authority="marcrelator" type="code">
          <xsl:value-of select="."/>
        </roleTerm>
      </role>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="part">
    <xsl:variable name="partNumber">
      <xsl:call-template name="specialSubfieldSelect">
        <xsl:with-param name="axis">n</xsl:with-param>
        <xsl:with-param name="anyCodes">n</xsl:with-param>
        <xsl:with-param name="afterCodes">fgkdmor</xsl:with-param>
        <!--<xsl:with-param name="afterCodes">fgkdlmor</xsl:with-param>-->
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="partName">
      <xsl:call-template name="specialSubfieldSelect">
        <xsl:with-param name="axis">p</xsl:with-param>
        <xsl:with-param name="anyCodes">p</xsl:with-param>
        <xsl:with-param name="afterCodes">fgkdmor</xsl:with-param>
        <!--<xsl:with-param name="afterCodes">fgkdlmor</xsl:with-param>-->
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="string-length(normalize-space($partNumber))">
      <partNumber>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString" select="$partNumber"/>
        </xsl:call-template>
      </partNumber>
    </xsl:if>
    <xsl:if test="string-length(normalize-space($partName))">
      <partName>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString" select="$partName"/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </partName>
    </xsl:if>
  </xsl:template>

  <xsl:template name="relatedPart">
    <xsl:if test="@tag = '773'">
      <xsl:for-each select="*:subfield[@code = 'g']">
        <part>
          <text>
            <xsl:value-of select="."/>
          </text>
        </part>
      </xsl:for-each>
      <xsl:for-each select="*:subfield[@code = 'q']">
        <part>
          <xsl:call-template name="parsePart"/>
        </part>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <xsl:template name="relatedPartNumName">
    <xsl:variable name="partNumber">
      <xsl:call-template name="specialSubfieldSelect">
        <xsl:with-param name="axis">g</xsl:with-param>
        <xsl:with-param name="anyCodes">g</xsl:with-param>
        <xsl:with-param name="afterCodes">pst</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="partName">
      <xsl:call-template name="specialSubfieldSelect">
        <xsl:with-param name="axis">p</xsl:with-param>
        <xsl:with-param name="anyCodes">p</xsl:with-param>
        <xsl:with-param name="afterCodes">fgkdlmor</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="string-length(normalize-space($partNumber))">
      <partNumber>
        <xsl:value-of select="$partNumber"/>
      </partNumber>
    </xsl:if>
    <xsl:if test="string-length(normalize-space($partName))">
      <partName>
        <xsl:value-of select="$partName"/>
      </partName>
    </xsl:if>
  </xsl:template>

  <xsl:template name="relatedName">
    <xsl:for-each select="*:subfield[@code = 'a']">
      <name>
        <namePart>
          <xsl:value-of select="."/>
        </namePart>
      </name>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedForm">
    <xsl:for-each select="*:subfield[@code = 'h']">
      <physicalDescription>
        <form>
          <xsl:value-of select="."/>
        </form>
      </physicalDescription>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedExtent">
    <xsl:for-each select="*:subfield[@code = 'h']">
      <physicalDescription>
        <extent>
          <xsl:value-of select="."/>
        </extent>
      </physicalDescription>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedNote">
    <xsl:for-each select="*:subfield[@code = 'n']">
      <note>
        <xsl:value-of select="."/>
      </note>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedSubject">
    <xsl:for-each select="*:subfield[@code = 'j']">
      <subject>
        <temporal encoding="iso8601">
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString" select="."/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </temporal>
      </subject>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedIdentifierISSN">
    <xsl:for-each select="*:subfield[@code = 'x']">
      <identifier type="issn">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="."/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedIdentifierLocal">
    <xsl:for-each select="*:subfield[@code = 'w']">
      <identifier>
        <xsl:choose>
          <xsl:when test="matches(., 'OCo?LC', 'i')">
            <xsl:attribute name="type">oclc</xsl:attribute>
          </xsl:when>
          <xsl:when test="matches(., '\([^\)]+\)')">
            <xsl:attribute name="type">
              <xsl:value-of
                select="replace(substring-before(substring-after(., '('), ')'), '^DLC$', 'dlc')"/>
            </xsl:attribute>
          </xsl:when>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="matches(., 'OCo?LC', 'i')">
            <xsl:value-of
              select="normalize-space(replace(substring-after(replace(., 'OCo?LC', 'OCoLC'), '(OCoLC)'), '\p{P}+$', ''))"
            />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of
              select="normalize-space(replace(replace(., '\p{P}+$', ''), '\([^\(\)]+\)', ''))"/>
          </xsl:otherwise>
        </xsl:choose>
      </identifier>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedIdentifier">
    <xsl:for-each select="*:subfield[@code = 'o']">
      <identifier>
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="."/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </identifier>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedItem510">
    <xsl:call-template name="displayLabel"/>
    <xsl:call-template name="relatedTitle76X-78X"/>
    <xsl:call-template name="relatedName"/>
    <xsl:call-template name="relatedOriginInfo510"/>
    <xsl:call-template name="relatedLanguage"/>
    <xsl:call-template name="relatedExtent"/>
    <xsl:call-template name="relatedNote"/>
    <xsl:call-template name="relatedSubject"/>
    <xsl:call-template name="relatedIdentifier"/>
    <xsl:call-template name="relatedIdentifierISSN"/>
    <xsl:call-template name="relatedIdentifierLocal"/>
    <xsl:call-template name="relatedPart"/>
  </xsl:template>

  <xsl:template name="relatedItem76X-78X">
    <xsl:call-template name="displayLabel"/>
    <xsl:call-template name="relatedTitle76X-78X"/>
    <xsl:call-template name="relatedName"/>
    <xsl:call-template name="relatedOriginInfo"/>
    <xsl:call-template name="relatedLanguage"/>
    <xsl:call-template name="relatedExtent"/>
    <xsl:call-template name="relatedNote"/>
    <xsl:call-template name="relatedSubject"/>
    <xsl:call-template name="relatedIdentifier"/>
    <xsl:call-template name="relatedIdentifierISSN"/>
    <xsl:call-template name="relatedIdentifierLocal"/>
    <xsl:call-template name="relatedPart"/>
  </xsl:template>

  <xsl:template name="subjectGeographicZ">
    <geographic>
      <xsl:call-template name="chopPunctuation">
        <xsl:with-param name="chopString" select="."/>
        <xsl:with-param name="punctuation">
          <xsl:text>.:,;/ </xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </geographic>
  </xsl:template>

  <xsl:template name="subjectTemporalY">
    <temporal>
      <xsl:call-template name="chopPunctuation">
        <xsl:with-param name="chopString" select="."/>
        <xsl:with-param name="punctuation">
          <xsl:text>.:,;/ </xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </temporal>
  </xsl:template>

  <xsl:template name="subjectTopic">
    <topic>
      <xsl:call-template name="chopPunctuation">
        <xsl:with-param name="chopString" select="."/>
        <xsl:with-param name="punctuation">
          <xsl:text>.:,;/ </xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </topic>
  </xsl:template>

  <xsl:template name="subjectGenre">
    <genre>
      <xsl:call-template name="chopPunctuation">
        <xsl:with-param name="chopString" select="."/>
        <xsl:with-param name="punctuation">
          <xsl:text>.:,;/ </xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </genre>
  </xsl:template>

  <xsl:template name="nameABCDN">
    <xsl:for-each select="*:subfield[@code = 'a']">
      <namePart>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString" select="."/>
          <xsl:with-param name="punctuation">
            <xsl:text>:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </namePart>
    </xsl:for-each>
    <xsl:for-each select="*:subfield[@code = 'b']">
      <namePart>
        <xsl:value-of select="."/>
      </namePart>
    </xsl:for-each>
    <xsl:if test="*:subfield[@code = 'c'] or *:subfield[@code = 'd'] or *:subfield[@code = 'n']">
      <namePart>
        <xsl:call-template name="subfieldSelect">
          <xsl:with-param name="codes">cdn</xsl:with-param>
        </xsl:call-template>
      </namePart>
    </xsl:if>
  </xsl:template>

  <xsl:template name="nameABCDQ">
    <namePart>
      <xsl:call-template name="chopPunctuation">
        <xsl:with-param name="chopString">
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">aq</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="punctuation">
          <xsl:text>:,;/ </xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </namePart>
    <xsl:call-template name="termsOfAddress"/>
    <xsl:call-template name="nameDate"/>
  </xsl:template>

  <xsl:template name="nameACDEQ">
    <namePart>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">acdeq</xsl:with-param>
      </xsl:call-template>
    </namePart>
  </xsl:template>

  <xsl:template name="nameACDENQ">
    <namePart>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">acdenq</xsl:with-param>
      </xsl:call-template>
    </namePart>
  </xsl:template>

  <xsl:template name="nameIdentifier">
    <xsl:if test="*:subfield[@code = '0']">
      <nameIdentifier>
        <xsl:call-template name="subfieldSelect">
          <xsl:with-param name="codes">0</xsl:with-param>
        </xsl:call-template>
      </nameIdentifier>
    </xsl:if>
  </xsl:template>

  <xsl:template name="constituentOrRelatedType">
    <xsl:if test="@ind2 eq '2'">
      <xsl:attribute name="type">constituent</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="relatedTitle">
    <xsl:for-each select="*:subfield[@code = 't']">
      <titleInfo>
        <title>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:value-of select="."/>
            </xsl:with-param>
          </xsl:call-template>
        </title>
      </titleInfo>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedTitle76X-78X">
    <xsl:for-each select="*:subfield[@code = 't']">
      <titleInfo>
        <title>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:value-of select="."/>
            </xsl:with-param>
          </xsl:call-template>
        </title>
        <xsl:if test="*:datafield[@tag != '773'] and *:subfield[@code = 'g']">
          <xsl:call-template name="relatedPartNumName"/>
        </xsl:if>
      </titleInfo>
    </xsl:for-each>
    <xsl:for-each select="*:subfield[@code = 'p']">
      <titleInfo type="abbreviated">
        <title>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:value-of select="."/>
            </xsl:with-param>
          </xsl:call-template>
        </title>
        <xsl:if test="*:datafield[@tag != '773'] and *:subfield[@code = 'g']">
          <xsl:call-template name="relatedPartNumName"/>
        </xsl:if>
      </titleInfo>
    </xsl:for-each>
    <xsl:for-each select="*:subfield[@code = 's']">
      <titleInfo type="uniform">
        <title>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:value-of select="."/>
            </xsl:with-param>
          </xsl:call-template>
        </title>
        <xsl:if test="*:datafield[@tag != '773'] and *:subfield[@code = 'g']">
          <xsl:call-template name="relatedPartNumName"/>
        </xsl:if>
      </titleInfo>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedOriginInfo">
    <xsl:if test="*:subfield[@code = 'b' or @code = 'd'] or *:subfield[@code = 'f']">
      <originInfo>
        <xsl:if test="@tag = '775'">
          <xsl:for-each select="*:subfield[@code = 'f']">
            <place>
              <placeTerm>
                <xsl:attribute name="type">code</xsl:attribute>
                <xsl:attribute name="authority">marcgac</xsl:attribute>
                <xsl:value-of select="."/>
              </placeTerm>
            </place>
          </xsl:for-each>
        </xsl:if>
        <xsl:for-each select="*:subfield[@code = 'd']">
          <publisher>
            <xsl:value-of select="."/>
          </publisher>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'b']">
          <edition>
            <xsl:value-of select="."/>
          </edition>
        </xsl:for-each>
      </originInfo>
    </xsl:if>
  </xsl:template>



  <xsl:template name="relatedOriginInfo510">
    <xsl:for-each select="*:subfield[@code = 'b']">
      <originInfo>
        <dateOther type="coverage">
          <xsl:value-of select="."/>
        </dateOther>
      </originInfo>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="relatedLanguage">
    <xsl:for-each select="*:subfield[@code = 'e']">
      <xsl:call-template name="getLanguage">
        <xsl:with-param name="langString">
          <xsl:value-of select="."/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="nameDate">
    <xsl:for-each select="*:subfield[@code = 'd']">
      <namePart type="date">
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString" select="."/>
        </xsl:call-template>
      </namePart>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="subjectAuthority">
    <xsl:if test="@ind2 != '4'">
      <xsl:if test="@ind2 != ' '">
        <xsl:if test="@ind2 != '8'">
          <xsl:if test="@ind2 != '9'">
            <xsl:attribute name="authority">
              <xsl:choose>
                <xsl:when test="@ind2 = '0'">lcsh</xsl:when>
                <xsl:when test="@ind2 = '1'">lcshac</xsl:when>
                <xsl:when test="@ind2 = '2'">mesh</xsl:when>
                <!-- 1/04 fix -->
                <xsl:when test="@ind2 = '3'">nal</xsl:when>
                <xsl:when test="@ind2 = '5'">csh</xsl:when>
                <xsl:when test="@ind2 = '6'">rvm</xsl:when>
                <xsl:when test="@ind2 = '7'">
                  <xsl:call-template name="chopPunctuationBack">
                    <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
                    <xsl:with-param name="punctuation">
                      <xsl:text>.:,;/ </xsl:text>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:when>
              </xsl:choose>
            </xsl:attribute>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template name="subject653Type">
    <xsl:if test="@ind2 != ' '">
      <xsl:if test="@ind2 != '0'">
        <xsl:if test="@ind2 != '4'">
          <xsl:if test="@ind2 != '5'">
            <xsl:if test="@ind2 != '6'">
              <xsl:if test="@ind2 != '7'">
                <xsl:if test="@ind2 != '8'">
                  <xsl:if test="@ind2 != '9'">
                    <xsl:attribute name="type">
                      <xsl:choose>
                        <xsl:when test="@ind2 = '1'">personal</xsl:when>
                        <xsl:when test="@ind2 = '2'">corporate</xsl:when>
                        <xsl:when test="@ind2 = '3'">conference</xsl:when>
                      </xsl:choose>
                    </xsl:attribute>
                  </xsl:if>
                </xsl:if>
              </xsl:if>
            </xsl:if>
          </xsl:if>
        </xsl:if>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template name="subjectAnyOrder">
    <xsl:for-each select="*:subfield[@code = 'v' or @code = 'x' or @code = 'y' or @code = 'z']">
      <xsl:choose>
        <xsl:when test="@code = 'v'">
          <xsl:call-template name="subjectGenre"/>
        </xsl:when>
        <xsl:when test="@code = 'x'">
          <xsl:call-template name="subjectTopic"/>
        </xsl:when>
        <xsl:when test="@code = 'y'">
          <xsl:call-template name="subjectTemporalY"/>
        </xsl:when>
        <xsl:when test="@code = 'z'">
          <xsl:call-template name="subjectGeographicZ"/>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="specialSubfieldSelect">
    <xsl:param name="anyCodes"/>
    <xsl:param name="axis"/>
    <xsl:param name="beforeCodes"/>
    <xsl:param name="afterCodes"/>
    <xsl:variable name="str">
      <xsl:for-each select="*:subfield">
        <xsl:if
          test="contains($anyCodes, @code) or (contains($beforeCodes, @code) and following-sibling::*:subfield[@code = $axis]) or (contains($afterCodes, @code) and preceding-sibling::*:subfield[@code = $axis])">
          <xsl:value-of select="text()"/>
          <xsl:text> </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="substring($str, 1, string-length($str) - 1)"/>
  </xsl:template>

  <xsl:template match="*:datafield[@tag = '656']">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:if test="*:subfield[@code = '2']">
        <xsl:attribute name="authority">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <occupation>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:value-of select="*:subfield[@code = 'a']"/>
          </xsl:with-param>
        </xsl:call-template>
      </occupation>
    </subject>
  </xsl:template>

  <xsl:template name="termsOfAddress">
    <xsl:if test="*:subfield[@code = 'b' or @code = 'c']">
      <namePart type="termsOfAddress">
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">bc</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </namePart>
    </xsl:if>
  </xsl:template>

  <xsl:template name="displayLabel">
    <xsl:if test="*:subfield[@code = '3']">
      <xsl:attribute name="displayLabel">
        <xsl:value-of select="*:subfield[@code = '3']"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="subtitle">
    <xsl:if test="*:subfield[@code = 'b']">
      <subTitle>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:value-of select="*:subfield[@code = 'b']"/>
          </xsl:with-param>
        </xsl:call-template>
      </subTitle>
    </xsl:if>
  </xsl:template>

  <xsl:template name="script">
    <xsl:param name="scriptCode"/>
    <xsl:attribute name="script">
      <xsl:choose>
        <!-- ISO 15924	and CJK is a local code	20101123-->
        <xsl:when test="$scriptCode = '(3'">Arab</xsl:when>
        <xsl:when test="$scriptCode = '(4'">Arab</xsl:when>
        <xsl:when test="$scriptCode = '(B'">Latn</xsl:when>
        <xsl:when test="$scriptCode = '!E'">Latn</xsl:when>
        <xsl:when test="$scriptCode = '$1'">CJK</xsl:when>
        <xsl:when test="$scriptCode = '(N'">Cyrl</xsl:when>
        <xsl:when test="$scriptCode = '(Q'">Cyrl</xsl:when>
        <xsl:when test="$scriptCode = '(2'">Hebr</xsl:when>
        <xsl:when test="$scriptCode = '(S'">Grek</xsl:when>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>

  <xsl:template name="parsePart">
    <!-- assumes 773$q= 1:2:3<4
		     with up to 3 levels and one optional start page -->
    <xsl:variable name="level1">
      <xsl:choose>
        <xsl:when test="contains(text(), ':')">
          <!-- 1:2 -->
          <xsl:value-of select="substring-before(text(), ':')"/>
        </xsl:when>
        <xsl:when test="not(contains(text(), ':'))">
          <!-- 1 or 1<3 -->
          <xsl:if test="contains(text(), '&lt;')">
            <!-- 1<3 -->
            <xsl:value-of select="substring-before(text(), '&lt;')"/>
          </xsl:if>
          <xsl:if test="not(contains(text(), '&lt;'))">
            <!-- 1 -->
            <xsl:value-of select="text()"/>
          </xsl:if>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="sici2">
      <xsl:choose>
        <xsl:when test="starts-with(substring-after(text(), $level1), ':')">
          <xsl:value-of select="substring(substring-after(text(), $level1), 2)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-after(text(), $level1)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="level2">
      <xsl:choose>
        <xsl:when test="contains($sici2, ':')">
          <!-- 2:3<4 -->
          <xsl:value-of select="substring-before($sici2, ':')"/>
        </xsl:when>
        <xsl:when test="contains($sici2, '&lt;')">
          <!-- 1: 2<4 -->
          <xsl:value-of select="substring-before($sici2, '&lt;')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$sici2"/>
          <!-- 1:2 -->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="sici3">
      <xsl:choose>
        <xsl:when test="starts-with(substring-after($sici2, $level2), ':')">
          <xsl:value-of select="substring(substring-after($sici2, $level2), 2)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-after($sici2, $level2)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="level3">
      <xsl:choose>
        <xsl:when test="contains($sici3, '&lt;')">
          <!-- 2<4 -->
          <xsl:value-of select="substring-before($sici3, '&lt;')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$sici3"/>
          <!-- 3 -->
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="page">
      <xsl:if test="contains(text(), '&lt;')">
        <xsl:value-of select="substring-after(text(), '&lt;')"/>
      </xsl:if>
    </xsl:variable>
    <xsl:if test="$level1">
      <detail level="1">
        <number>
          <xsl:value-of select="$level1"/>
        </number>
      </detail>
    </xsl:if>
    <xsl:if test="$level2">
      <detail level="2">
        <number>
          <xsl:value-of select="$level2"/>
        </number>
      </detail>
    </xsl:if>
    <xsl:if test="$level3">
      <detail level="3">
        <number>
          <xsl:value-of select="$level3"/>
        </number>
      </detail>
    </xsl:if>
    <xsl:if test="$page">
      <extent unit="page">
        <start>
          <xsl:value-of select="$page"/>
        </start>
      </extent>
    </xsl:if>
  </xsl:template>

  <xsl:template name="getLanguage">
    <xsl:param name="langString"/>
    <xsl:param name="controlField008-35-37"/>
    <xsl:variable name="length" select="string-length($langString)"/>
    <xsl:choose>
      <xsl:when test="$length = 0"/>
      <xsl:when test="$controlField008-35-37 = substring($langString, 1, 3)">
        <xsl:call-template name="getLanguage">
          <xsl:with-param name="langString" select="substring($langString, 4, $length)"/>
          <xsl:with-param name="controlField008-35-37" select="$controlField008-35-37"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <language>
          <languageTerm authority="iso639-2b" type="code">
            <xsl:value-of select="substring($langString, 1, 3)"/>
          </languageTerm>
        </language>
        <xsl:call-template name="getLanguage">
          <xsl:with-param name="langString" select="substring($langString, 4, $length)"/>
          <xsl:with-param name="controlField008-35-37" select="$controlField008-35-37"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="isoLanguage">
    <xsl:param name="currentLanguage"/>
    <xsl:param name="usedLanguages"/>
    <xsl:param name="remainingLanguages"/>
    <xsl:choose>
      <xsl:when test="string-length($currentLanguage) = 0"/>
      <xsl:when test="not(contains($usedLanguages, $currentLanguage))">
        <language>
          <xsl:if test="@code != 'a'">
            <xsl:attribute name="objectPart">
              <xsl:choose>
                <xsl:when test="@code = 'b'">summary or abstract</xsl:when>
                <xsl:when test="@code = 'd'">sung or spoken text</xsl:when>
                <xsl:when test="@code = 'e'">libretto</xsl:when>
                <xsl:when test="@code = 'f'">table of contents</xsl:when>
                <xsl:when test="@code = 'g'">accompanying material</xsl:when>
                <xsl:when test="@code = 'h'">original</xsl:when>
                <xsl:when test="@code = 'i'">intertitles</xsl:when>
                <xsl:when test="@code = 'j'">subtitles</xsl:when>
                <xsl:when test="@code = 'k'">intermediate translation</xsl:when>
                <xsl:when test="@code = 'm'">original accompanying materials</xsl:when>
                <xsl:when test="@code = 'n'">original libretto</xsl:when>
                <xsl:when test="@code = 'p'">captions</xsl:when>
                <xsl:when test="@code = 'q'">accessible audio</xsl:when>
                <xsl:when test="@code = 'r'">accessible visual language</xsl:when>
                <xsl:when test="@code = 't'">transcripts</xsl:when>
              </xsl:choose>
            </xsl:attribute>
          </xsl:if>
          <languageTerm authority="iso639-2b" type="code">
            <xsl:value-of select="$currentLanguage"/>
          </languageTerm>
        </language>
        <xsl:call-template name="isoLanguage">
          <xsl:with-param name="currentLanguage">
            <xsl:value-of select="substring($remainingLanguages, 1, 3)"/>
          </xsl:with-param>
          <xsl:with-param name="usedLanguages">
            <xsl:value-of select="concat($usedLanguages, $currentLanguage)"/>
          </xsl:with-param>
          <xsl:with-param name="remainingLanguages">
            <xsl:value-of
              select="substring($remainingLanguages, 4, string-length($remainingLanguages))"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="isoLanguage">
          <xsl:with-param name="currentLanguage">
            <xsl:value-of select="substring($remainingLanguages, 1, 3)"/>
          </xsl:with-param>
          <xsl:with-param name="usedLanguages">
            <xsl:value-of select="concat($usedLanguages, $currentLanguage)"/>
          </xsl:with-param>
          <xsl:with-param name="remainingLanguages">
            <xsl:value-of
              select="substring($remainingLanguages, 4, string-length($remainingLanguages))"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="chopBrackets">
    <xsl:param name="chopString"/>
    <xsl:variable name="string">
      <xsl:call-template name="chopPunctuation">
        <xsl:with-param name="chopString" select="$chopString"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="substring($string, 1, 1) = '['">
      <xsl:value-of select="substring($string, 2, string-length($string) - 2)"/>
    </xsl:if>
    <xsl:if test="substring($string, 1, 1) != '['">
      <xsl:value-of select="$string"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="rfcLanguages">
    <xsl:param name="nodeNum"/>
    <xsl:param name="usedLanguages"/>
    <xsl:param name="controlField008-35-37"/>
    <xsl:variable name="currentLanguage" select="."/>
    <xsl:choose>
      <xsl:when test="not($currentLanguage)"/>
      <xsl:when test="$currentLanguage != $controlField008-35-37 and $currentLanguage != 'rfc3066'">
        <xsl:if test="not(contains($usedLanguages, $currentLanguage))">
          <language>
            <xsl:if test="@code != 'a'">
              <xsl:attribute name="objectPart">
                <xsl:choose>
                  <xsl:when test="@code = 'b'">summary or subtitle</xsl:when>
                  <xsl:when test="@code = 'd'">sung or spoken text</xsl:when>
                  <xsl:when test="@code = 'e'">libretto</xsl:when>
                  <xsl:when test="@code = 'f'">table of contents</xsl:when>
                  <xsl:when test="@code = 'g'">accompanying material</xsl:when>
                  <xsl:when test="@code = 'h'">translation</xsl:when>
                </xsl:choose>
              </xsl:attribute>
            </xsl:if>
            <languageTerm authority="rfc3066" type="code">
              <xsl:value-of select="$currentLanguage"/>
            </languageTerm>
          </language>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise> </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <xsl:template name="dates045b">
    <xsl:param name="str"/>
    <xsl:variable name="first-char" select="substring($str, 1, 1)"/>
    <xsl:choose>
      <xsl:when test="$first-char = 'c'">
        <xsl:value-of select="concat('-', substring($str, 2))"/>
      </xsl:when>
      <xsl:when test="$first-char = 'd'">
        <xsl:value-of select="substring($str, 2)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$str"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="scriptCode">
    <xsl:variable name="sf06" select="normalize-space(child::*:subfield[@code = '6'])"/>
    <xsl:variable name="sf06a" select="substring($sf06, 1, 3)"/>
    <xsl:variable name="sf06b" select="substring($sf06, 5, 2)"/>
    <xsl:variable name="sf06c" select="substring($sf06, 7)"/>
    <xsl:variable name="scriptCode" select="substring($sf06, 8, 2)"/>
    <xsl:if test="//*:datafield/*:subfield[@code = '6']">
      <xsl:attribute name="script">
        <xsl:choose>
          <xsl:when test="$scriptCode = ''">Latn</xsl:when>
          <xsl:when test="$scriptCode = '(3'">Arab</xsl:when>
          <xsl:when test="$scriptCode = '(4'">Arab</xsl:when>
          <xsl:when test="$scriptCode = '(B'">Latn</xsl:when>
          <xsl:when test="$scriptCode = '!E'">Latn</xsl:when>
          <xsl:when test="$scriptCode = '$1'">CJK</xsl:when>
          <xsl:when test="$scriptCode = '(N'">Cyrl</xsl:when>
          <xsl:when test="$scriptCode = '(Q'">Cyrl</xsl:when>
          <xsl:when test="$scriptCode = '(2'">Hebr</xsl:when>
          <xsl:when test="$scriptCode = '(S'">Grek</xsl:when>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>



  <xsl:template name="xxx880">
    <xsl:if test="child::*:subfield[@code = '6']">
      <xsl:variable name="sf06" select="normalize-space(child::*:subfield[@code = '6'])"/>
      <xsl:variable name="sf06a" select="substring($sf06, 1, 3)"/>
      <xsl:variable name="sf06b" select="substring($sf06, 5, 2)"/>
      <xsl:variable name="sf06c" select="substring($sf06, 7)"/>
      <xsl:variable name="scriptCode" select="substring($sf06, 8, 2)"/>
      <xsl:if test="//*:datafield/*:subfield[@code = '6']">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="$sf06b"/>
        </xsl:attribute>
        <xsl:attribute name="script">
          <xsl:choose>
            <xsl:when test="$scriptCode = ''">Latn</xsl:when>
            <xsl:when test="$scriptCode = '(3'">Arab</xsl:when>
            <xsl:when test="$scriptCode = '(4'">Arab</xsl:when>
            <xsl:when test="$scriptCode = '(B'">Latn</xsl:when>
            <xsl:when test="$scriptCode = '!E'">Latn</xsl:when>
            <xsl:when test="$scriptCode = '$1'">CJK</xsl:when>
            <xsl:when test="$scriptCode = '(N'">Cyrl</xsl:when>
            <xsl:when test="$scriptCode = '(Q'">Cyrl</xsl:when>
            <xsl:when test="$scriptCode = '(2'">Hebr</xsl:when>
            <xsl:when test="$scriptCode = '(S'">Grek</xsl:when>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template name="yyy880">
    <xsl:if test="preceding-sibling::*:subfield[@code = '6']">
      <xsl:variable name="sf06" select="normalize-space(preceding-sibling::*:subfield[@code = '6'])"/>
      <xsl:variable name="sf06a" select="substring($sf06, 1, 3)"/>
      <xsl:variable name="sf06b" select="substring($sf06, 5, 2)"/>
      <xsl:variable name="sf06c" select="substring($sf06, 7)"/>
      <xsl:if test="//*:datafield/*:subfield[@code = '6']">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="$sf06b"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template name="z2xx880">
    <!-- Evaluating the 260 field -->
    <xsl:variable name="x260">
      <xsl:choose>
        <xsl:when test="@tag = '260' and *:subfield[@code = '6']">
          <xsl:variable name="sf06260" select="normalize-space(child::*:subfield[@code = '6'])"/>
          <xsl:variable name="sf06260a" select="substring($sf06260, 1, 3)"/>
          <xsl:variable name="sf06260b" select="substring($sf06260, 5, 2)"/>
          <xsl:variable name="sf06260c" select="substring($sf06260, 7)"/>
          <xsl:value-of select="$sf06260b"/>
        </xsl:when>
        <xsl:when test="@tag = '250' and ../*:datafield[@tag = '260']/*:subfield[@code = '6']">
          <xsl:variable name="sf06260"
            select="normalize-space(../*:datafield[@tag = '260']/*:subfield[@code = '6'])"/>
          <xsl:variable name="sf06260a" select="substring($sf06260, 1, 3)"/>
          <xsl:variable name="sf06260b" select="substring($sf06260, 5, 2)"/>
          <xsl:variable name="sf06260c" select="substring($sf06260, 7)"/>
          <xsl:value-of select="$sf06260b"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="x250">
      <xsl:choose>
        <xsl:when test="@tag = '250' and *:subfield[@code = '6']">
          <xsl:variable name="sf06250"
            select="normalize-space(../*:datafield[@tag = '250']/*:subfield[@code = '6'])"/>
          <xsl:variable name="sf06250a" select="substring($sf06250, 1, 3)"/>
          <xsl:variable name="sf06250b" select="substring($sf06250, 5, 2)"/>
          <xsl:variable name="sf06250c" select="substring($sf06250, 7)"/>
          <xsl:value-of select="$sf06250b"/>
        </xsl:when>
        <xsl:when test="@tag = '260' and ../*:datafield[@tag = '250']/*:subfield[@code = '6']">
          <xsl:variable name="sf06250"
            select="normalize-space(../*:datafield[@tag = '250']/*:subfield[@code = '6'])"/>
          <xsl:variable name="sf06250a" select="substring($sf06250, 1, 3)"/>
          <xsl:variable name="sf06250b" select="substring($sf06250, 5, 2)"/>
          <xsl:variable name="sf06250c" select="substring($sf06250, 7)"/>
          <xsl:value-of select="$sf06250b"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$x250 != '' and $x260 != ''">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="concat($x250, $x260)"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$x250 != ''">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="$x250"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$x260 != ''">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="$x260"/>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="//*:datafield/*:subfield[@code = '6']"> </xsl:if>
  </xsl:template>

  <xsl:template name="z3xx880">
    <!-- Evaluating the 300 field -->
    <xsl:variable name="x300">
      <xsl:choose>
        <xsl:when test="@tag = '300' and *:subfield[@code = '6']">
          <xsl:variable name="sf06300" select="normalize-space(child::*:subfield[@code = '6'])"/>
          <xsl:variable name="sf06300a" select="substring($sf06300, 1, 3)"/>
          <xsl:variable name="sf06300b" select="substring($sf06300, 5, 2)"/>
          <xsl:variable name="sf06300c" select="substring($sf06300, 7)"/>
          <xsl:value-of select="$sf06300b"/>
        </xsl:when>
        <xsl:when test="@tag = '351' and ../*:datafield[@tag = '300']/*:subfield[@code = '6']">
          <xsl:variable name="sf06300"
            select="normalize-space(../*:datafield[@tag = '300']/*:subfield[@code = '6'])"/>
          <xsl:variable name="sf06300a" select="substring($sf06300, 1, 3)"/>
          <xsl:variable name="sf06300b" select="substring($sf06300, 5, 2)"/>
          <xsl:variable name="sf06300c" select="substring($sf06300, 7)"/>
          <xsl:value-of select="$sf06300b"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="x351">
      <xsl:choose>
        <xsl:when test="@tag = '351' and *:subfield[@code = '6']">
          <xsl:variable name="sf06351"
            select="normalize-space(../*:datafield[@tag = '351']/*:subfield[@code = '6'])"/>
          <xsl:variable name="sf06351a" select="substring($sf06351, 1, 3)"/>
          <xsl:variable name="sf06351b" select="substring($sf06351, 5, 2)"/>
          <xsl:variable name="sf06351c" select="substring($sf06351, 7)"/>
          <xsl:value-of select="$sf06351b"/>
        </xsl:when>
        <xsl:when test="@tag = '300' and ../*:datafield[@tag = '351']/*:subfield[@code = '6']">
          <xsl:variable name="sf06351"
            select="normalize-space(../*:datafield[@tag = '351']/*:subfield[@code = '6'])"/>
          <xsl:variable name="sf06351a" select="substring($sf06351, 1, 3)"/>
          <xsl:variable name="sf06351b" select="substring($sf06351, 5, 2)"/>
          <xsl:variable name="sf06351c" select="substring($sf06351, 7)"/>
          <xsl:value-of select="$sf06351b"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="x337">
      <xsl:if test="@tag = '337' and *:subfield[@code = '6']">
        <xsl:variable name="sf06337" select="normalize-space(child::*:subfield[@code = '6'])"/>
        <xsl:variable name="sf06337a" select="substring($sf06337, 1, 3)"/>
        <xsl:variable name="sf06337b" select="substring($sf06337, 5, 2)"/>
        <xsl:variable name="sf06337c" select="substring($sf06337, 7)"/>
        <xsl:value-of select="$sf06337b"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="x338">
      <xsl:if test="@tag = '338' and *:subfield[@code = '6']">
        <xsl:variable name="sf06338" select="normalize-space(child::*:subfield[@code = '6'])"/>
        <xsl:variable name="sf06338a" select="substring($sf06338, 1, 3)"/>
        <xsl:variable name="sf06338b" select="substring($sf06338, 5, 2)"/>
        <xsl:variable name="sf06338c" select="substring($sf06338, 7)"/>
        <xsl:value-of select="$sf06338b"/>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$x351 != '' and $x300 != ''">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="concat($x351, $x300, $x337, $x338)"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$x351 != ''">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="$x351"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$x300 != ''">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="$x300"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$x337 != ''">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="$x351"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$x338 != ''">
        <xsl:attribute name="altRepGroup">
          <xsl:value-of select="$x300"/>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="//*:datafield/*:subfield[@code = '6']"> </xsl:if>
  </xsl:template>

  <xsl:template name="true880">
    <xsl:variable name="sf06" select="normalize-space(*:subfield[@code = '6'])"/>
    <xsl:variable name="sf06a" select="substring($sf06, 1, 3)"/>
    <xsl:variable name="sf06b" select="substring($sf06, 5, 2)"/>
    <xsl:variable name="sf06c" select="substring($sf06, 7)"/>
    <xsl:if test="//*:datafield/*:subfield[@code = '6']">
      <xsl:attribute name="altRepGroup">
        <xsl:value-of select="$sf06b"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*:datafield" mode="trans880">
    <xsl:variable name="dataField880" select="//*:datafield"/>
    <xsl:variable name="sf06" select="normalize-space(*:subfield[@code = '6'])"/>
    <xsl:variable name="sf06a" select="substring($sf06, 1, 3)"/>
    <xsl:variable name="sf06b" select="substring($sf06, 4)"/>
    <xsl:choose>

      <!--tranforms 880 equiv -->
      <xsl:when test="$sf06a = '047'">
        <xsl:call-template name="createGenreFrom047"/>
      </xsl:when>
      <xsl:when test="$sf06a = '336'">
        <xsl:call-template name="createGenreFrom336"/>
      </xsl:when>
      <xsl:when test="$sf06a = '655'">
        <xsl:call-template name="createGenreFrom655"/>
      </xsl:when>
      <xsl:when test="$sf06a = '050'">
        <xsl:call-template name="createClassificationFrom050"/>
      </xsl:when>
      <xsl:when test="$sf06a = '060'">
        <xsl:call-template name="createClassificationFrom060"/>
      </xsl:when>
      <xsl:when test="$sf06a = '080'">
        <xsl:call-template name="createClassificationFrom080"/>
      </xsl:when>
      <xsl:when test="$sf06a = '082'">
        <xsl:call-template name="createClassificationFrom082"/>
      </xsl:when>
      <xsl:when test="$sf06a = '084'">
        <xsl:call-template name="createClassificationFrom080"/>
      </xsl:when>
      <xsl:when test="$sf06a = '086'">
        <xsl:call-template name="createClassificationFrom082"/>
      </xsl:when>
      <xsl:when test="$sf06a = '100'">
        <xsl:call-template name="createNameFrom100"/>
      </xsl:when>
      <xsl:when test="$sf06a = '110'">
        <xsl:call-template name="createNameFrom110"/>
      </xsl:when>
      <xsl:when test="$sf06a = '111'">
        <xsl:call-template name="createNameFrom110"/>
      </xsl:when>
      <xsl:when test="$sf06a = '700'">
        <xsl:call-template name="createNameFrom700"/>
      </xsl:when>
      <xsl:when test="$sf06a = '710'">
        <xsl:call-template name="createNameFrom710"/>
      </xsl:when>
      <xsl:when test="$sf06a = '711'">
        <xsl:call-template name="createNameFrom710"/>
      </xsl:when>
      <xsl:when test="$sf06a = '210'">
        <xsl:call-template name="createTitleInfoFrom210"/>
      </xsl:when>
      <xsl:when test="$sf06a = '245'">
        <xsl:call-template name="createTitleInfoFrom245"/>
        <xsl:call-template name="createNoteFrom245c"/>
      </xsl:when>
      <xsl:when test="$sf06a = '246'">
        <xsl:call-template name="createTitleInfoFrom246"/>
      </xsl:when>
      <xsl:when test="$sf06a = '240'">
        <xsl:call-template name="createTitleInfoFrom240"/>
      </xsl:when>
      <xsl:when test="$sf06a = '740'">
        <xsl:call-template name="createTitleInfoFrom740"/>
      </xsl:when>
      <xsl:when test="$sf06a = '130'">
        <xsl:call-template name="createTitleInfoFrom130"/>
      </xsl:when>
      <xsl:when test="$sf06a = '730'">
        <xsl:call-template name="createTitleInfoFrom730"/>
      </xsl:when>
      <xsl:when test="$sf06a = '505'">
        <xsl:call-template name="createTOCFrom505"/>
      </xsl:when>
      <xsl:when test="$sf06a = '520'">
        <xsl:call-template name="createAbstractFrom520"/>
      </xsl:when>
      <xsl:when test="$sf06a = '521'">
        <xsl:call-template name="createTargetAudienceFrom521"/>
      </xsl:when>
      <xsl:when test="$sf06a = '506'">
        <xsl:call-template name="createAccessConditionFrom506"/>
      </xsl:when>
      <xsl:when test="$sf06a = '540'">
        <xsl:call-template name="createAccessConditionFrom540"/>
      </xsl:when>
      <!-- note 245 362 etc	-->
      <xsl:when test="$sf06a = '245'">
        <xsl:call-template name="createNoteFrom245c"/>
      </xsl:when>
      <xsl:when test="$sf06a = '362'">
        <xsl:call-template name="createNoteFrom362"/>
      </xsl:when>
      <xsl:when test="$sf06a = '500'">
        <xsl:call-template name="createNoteFrom500"/>
      </xsl:when>
      <xsl:when test="$sf06a = '502'">
        <xsl:call-template name="createNoteFrom502"/>
      </xsl:when>
      <xsl:when test="$sf06a = '504'">
        <xsl:call-template name="createNoteFrom504"/>
      </xsl:when>
      <xsl:when test="$sf06a = '508'">
        <xsl:call-template name="createNoteFrom508"/>
      </xsl:when>
      <xsl:when test="$sf06a = '511'">
        <xsl:call-template name="createNoteFrom511"/>
      </xsl:when>
      <xsl:when test="$sf06a = '515'">
        <xsl:call-template name="createNoteFrom515"/>
      </xsl:when>
      <xsl:when test="$sf06a = '518'">
        <xsl:call-template name="createNoteFrom518"/>
      </xsl:when>
      <xsl:when test="$sf06a = '524'">
        <xsl:call-template name="createNoteFrom524"/>
      </xsl:when>
      <xsl:when test="$sf06a = '530'">
        <xsl:call-template name="createNoteFrom530"/>
      </xsl:when>
      <xsl:when test="$sf06a = '533'">
        <xsl:call-template name="createNoteFrom533"/>
      </xsl:when>
      <!-- <xsl:when test="$sf06a='534'">
				<xsl:call-template name="createNoteFrom534"/>
			</xsl:when> -->
      <xsl:when test="$sf06a = '535'">
        <xsl:call-template name="createNoteFrom535"/>
      </xsl:when>
      <xsl:when test="$sf06a = '536'">
        <xsl:call-template name="createNoteFrom536"/>
      </xsl:when>
      <xsl:when test="$sf06a = '538'">
        <xsl:call-template name="createNoteFrom538"/>
      </xsl:when>
      <xsl:when test="$sf06a = '541'">
        <xsl:call-template name="createNoteFrom541"/>
      </xsl:when>
      <xsl:when test="$sf06a = '545'">
        <xsl:call-template name="createNoteFrom545"/>
      </xsl:when>
      <xsl:when test="$sf06a = '546'">
        <xsl:call-template name="createNoteFrom546"/>
      </xsl:when>
      <xsl:when test="$sf06a = '561'">
        <xsl:call-template name="createNoteFrom561"/>
      </xsl:when>
      <xsl:when test="$sf06a = '562'">
        <xsl:call-template name="createNoteFrom562"/>
      </xsl:when>
      <xsl:when test="$sf06a = '581'">
        <xsl:call-template name="createNoteFrom581"/>
      </xsl:when>
      <xsl:when test="$sf06a = '583'">
        <xsl:call-template name="createNoteFrom583"/>
      </xsl:when>
      <xsl:when test="$sf06a = '585'">
        <xsl:call-template name="createNoteFrom585"/>
      </xsl:when>
      <!-- note 5XX	-->
      <xsl:when test="$sf06a = '501'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '507'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '513'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '514'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '516'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '522'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '525'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '526'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '544'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '552'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '555'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '556'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '565'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '567'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '580'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '584'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <xsl:when test="$sf06a = '586'">
        <xsl:call-template name="createNoteFrom5XX"/>
      </xsl:when>
      <!-- subject 034 043 045 255 656 662 752 -->
      <xsl:when test="$sf06a = '034'">
        <xsl:call-template name="createSubGeoFrom034"/>
      </xsl:when>
      <xsl:when test="$sf06a = '043'">
        <xsl:if test="$createSubjectFrom043 = 'true'">
          <xsl:call-template name="createSubGeoFrom043"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="$sf06a = '045'">
        <xsl:call-template name="createSubTemFrom045"/>
      </xsl:when>
      <xsl:when test="$sf06a = '255'">
        <xsl:call-template name="createSubGeoFrom255"/>
      </xsl:when>

      <xsl:when test="$sf06a = '600'">
        <xsl:call-template name="createSubNameFrom600"/>
      </xsl:when>
      <xsl:when test="$sf06a = '610'">
        <xsl:call-template name="createSubNameFrom610"/>
      </xsl:when>
      <xsl:when test="$sf06a = '611'">
        <xsl:call-template name="createSubNameFrom611"/>
      </xsl:when>

      <xsl:when test="$sf06a = '630'">
        <xsl:call-template name="createSubTitleFrom630"/>
      </xsl:when>

      <xsl:when test="$sf06a = '648'">
        <xsl:call-template name="createSubChronFrom648"/>
      </xsl:when>
      <xsl:when test="$sf06a = '650'">
        <xsl:call-template name="createSubTopFrom650"/>
      </xsl:when>
      <xsl:when test="$sf06a = '651'">
        <xsl:call-template name="createSubGeoFrom651"/>
      </xsl:when>

      <xsl:when test="$sf06a = '653'">
        <xsl:call-template name="createSubFrom653"/>
      </xsl:when>
      <xsl:when test="$sf06a = '656'">
        <xsl:call-template name="createSubFrom656"/>
      </xsl:when>
      <xsl:when test="$sf06a = '662'">
        <xsl:call-template name="createSubGeoFrom662752"/>
      </xsl:when>
      <xsl:when test="$sf06a = '752'">
        <xsl:call-template name="createSubGeoFrom662752"/>
      </xsl:when>
      <!-- location  852 856 -->
      <xsl:when test="$sf06a = '852'">
        <xsl:call-template name="createLocationFrom852"/>
      </xsl:when>
      <xsl:when test="$sf06a = '856'">
        <xsl:call-template name="createLocationOrRelatedItemFrom856"/>
      </xsl:when>
      <xsl:when test="$sf06a = '490'">
        <xsl:call-template name="createRelatedItemFrom490"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- titleInfo 130 730 245 246 240 740 210 -->
  <xsl:template name="createTitleInfoFrom130">
    <titleInfo type="uniform">
      <title>
        <xsl:variable name="str">
          <xsl:for-each select="*:subfield">
            <xsl:if test="(contains('s', @code))">
              <xsl:value-of select="text()"/>
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if
              test="(contains('adfklmors', @code) and (not(../*:subfield[@code = 'n' or @code = 'p']) or (following-sibling::*:subfield[@code = 'n' or @code = 'p'])))">
              <xsl:value-of select="text()"/>
              <xsl:text> </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:value-of select="substring($str, 1, string-length($str) - 1)"/>
          </xsl:with-param>
        </xsl:call-template>
      </title>
      <xsl:call-template name="part"/>
    </titleInfo>
  </xsl:template>

  <xsl:template name="createTitleInfoFrom730">
    <titleInfo type="uniform">
      <title>
        <xsl:variable name="str">
          <xsl:for-each select="*:subfield">
            <xsl:if test="(contains('s', @code))">
              <xsl:value-of select="text()"/>
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if
              test="(contains('adfklmors', @code) and (not(../*:subfield[@code = 'n' or @code = 'p']) or (following-sibling::*:subfield[@code = 'n' or @code = 'p'])))">
              <xsl:value-of select="text()"/>
              <xsl:text> </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:value-of select="substring($str, 1, string-length($str) - 1)"/>
          </xsl:with-param>
        </xsl:call-template>
      </title>
      <xsl:call-template name="part"/>
    </titleInfo>
  </xsl:template>

  <xsl:template name="createTitleInfoFrom210">
    <titleInfo type="abbreviated">
      <xsl:if test="*:datafield[@tag = '210'][@ind2 = '2']">
        <xsl:attribute name="authority">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="xxx880"/>
      <title>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">a</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </title>
      <xsl:call-template name="subtitle"/>
    </titleInfo>
  </xsl:template>

  <xsl:template name="createTitleInfoFrom245">
    <titleInfo>
      <xsl:call-template name="xxx880"/>
      <xsl:variable name="title">
        <xsl:choose>
          <xsl:when test="*:subfield[@code = 'b']">
            <xsl:call-template name="specialSubfieldSelect">
              <xsl:with-param name="axis">b</xsl:with-param>
              <xsl:with-param name="beforeCodes">afgks</xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">abfgks</xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="titleChop">
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:value-of select="$title"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="number(@ind2) &gt; 0">
          <xsl:if test="@tag != '880'">
            <nonSort xml:space="preserve"><xsl:value-of select="normalize-space(substring($titleChop, 1, @ind2))"/> </nonSort>
          </xsl:if>
          <title>
            <xsl:value-of select="substring($titleChop, @ind2 + 1)"/>
          </title>
        </xsl:when>
        <xsl:otherwise>
          <title>
            <xsl:value-of select="$titleChop"/>
          </title>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="*:subfield[@code = 'b']">
        <subTitle>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:call-template name="specialSubfieldSelect">
                <xsl:with-param name="axis">b</xsl:with-param>
                <xsl:with-param name="anyCodes">b</xsl:with-param>
                <xsl:with-param name="afterCodes">afgks</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </subTitle>
      </xsl:if>
      <xsl:call-template name="part"/>
    </titleInfo>
  </xsl:template>

  <xsl:template name="createTitleInfoFrom246">
    <titleInfo type="alternative">
      <xsl:call-template name="xxx880"/>
      <xsl:for-each select="*:subfield[@code = 'i']">
        <xsl:attribute name="displayLabel">
          <xsl:value-of select="text()"/>
        </xsl:attribute>
      </xsl:for-each>
      <title>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">af</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </title>
      <xsl:call-template name="subtitle"/>
      <xsl:call-template name="part"/>
    </titleInfo>
  </xsl:template>

  <!-- 240 nameTitleGroup-->
  <xsl:template name="createTitleInfoFrom240">
    <titleInfo type="uniform">
      <xsl:if
        test="//*:datafield[@tag = '100'] | //*:datafield[@tag = '110'] | //*:datafield[@tag = '111']">
        <xsl:attribute name="nameTitleGroup">
          <xsl:text>1</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="xxx880"/>
      <title>
        <xsl:variable name="str">
          <xsl:for-each select="*:subfield">
            <xsl:if
              test="(contains('adfklmors', @code) and (not(../*:subfield[@code = 'n' or @code = 'p']) or (following-sibling::*:subfield[@code = 'n' or @code = 'p'])))">
              <xsl:value-of select="text()"/>
              <xsl:text> </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:value-of select="substring($str, 1, string-length($str) - 1)"/>
          </xsl:with-param>
        </xsl:call-template>
      </title>
      <xsl:call-template name="part"/>
    </titleInfo>
  </xsl:template>

  <xsl:template name="createTitleInfoFrom740">
    <titleInfo type="alternative">
      <xsl:call-template name="xxx880"/>
      <title>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">ah</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </title>
      <xsl:call-template name="part"/>
    </titleInfo>
  </xsl:template>

  <xsl:template name="createNameFrom100">
    <xsl:if test="@ind1 = '0' or @ind1 = '1'">
      <name type="personal">
        <xsl:attribute name="usage">
          <xsl:text>primary</xsl:text>
        </xsl:attribute>
        <xsl:call-template name="xxx880"/>
        <xsl:if test="//*:datafield[@tag = '240']">
          <xsl:attribute name="nameTitleGroup">
            <xsl:text>1</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="nameABCDQ"/>
        <xsl:call-template name="affiliation"/>
        <xsl:call-template name="role"/>
        <xsl:call-template name="nameIdentifier"/>
      </name>
    </xsl:if>
    <xsl:if test="@ind1 = '3'">
      <name type="family">
        <xsl:attribute name="usage">
          <xsl:text>primary</xsl:text>
        </xsl:attribute>
        <xsl:call-template name="xxx880"/>

        <xsl:if test="ancestor::marcrecord//*:datafield[@tag = '240']">
          <xsl:attribute name="nameTitleGroup">
            <xsl:text>1</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:call-template name="nameABCDQ"/>
        <xsl:call-template name="affiliation"/>
        <xsl:call-template name="role"/>
        <xsl:call-template name="nameIdentifier"/>
      </name>
    </xsl:if>
  </xsl:template>

  <xsl:template name="createNameFrom110">
    <name type="corporate">
      <xsl:call-template name="xxx880"/>
      <xsl:if test="//*:datafield[@tag = '240']">
        <xsl:attribute name="nameTitleGroup">
          <xsl:text>1</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="nameABCDN"/>
      <xsl:call-template name="role"/>
      <xsl:call-template name="nameIdentifier"/>
    </name>
  </xsl:template>

  <xsl:template name="createNameFrom111">
    <name type="conference">
      <xsl:call-template name="xxx880"/>
      <xsl:if test="//*:datafield[@tag = '240']">
        <xsl:attribute name="nameTitleGroup">
          <xsl:text>1</xsl:text>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="nameACDENQ"/>
      <xsl:call-template name="role"/>
      <xsl:call-template name="nameIdentifier"/>
    </name>
  </xsl:template>

  <!-- name 700 710 711 720 -->
  <xsl:template name="createNameFrom700">
    <xsl:if test="@ind1 = '0' or @ind1 = '1'">
      <name type="personal">
        <xsl:call-template name="xxx880"/>
        <xsl:call-template name="nameABCDQ"/>
        <xsl:call-template name="affiliation"/>
        <xsl:call-template name="role"/>
        <xsl:call-template name="nameIdentifier"/>
      </name>
    </xsl:if>
    <xsl:if test="@ind1 = '3'">
      <name type="family">
        <xsl:call-template name="xxx880"/>
        <xsl:call-template name="nameABCDQ"/>
        <xsl:call-template name="affiliation"/>
        <xsl:call-template name="role"/>
        <xsl:call-template name="nameIdentifier"/>
      </name>
    </xsl:if>
  </xsl:template>

  <xsl:template name="createNameFrom710">
    <name type="corporate">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="nameABCDN"/>
      <xsl:call-template name="role"/>
      <xsl:call-template name="nameIdentifier"/>
    </name>
  </xsl:template>

  <xsl:template name="createNameFrom711">
    <name type="conference">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="nameACDENQ"/>
      <xsl:call-template name="role"/>
      <xsl:call-template name="nameIdentifier"/>
    </name>
  </xsl:template>

  <xsl:template name="createNameFrom720">
    <xsl:if test="not(*:subfield[@code = 't'])">
      <name>
        <xsl:if test="@ind1 = '1'">
          <xsl:attribute name="type">
            <xsl:text>personal</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <namePart>
          <xsl:value-of select="*:subfield[@code = 'a']"/>
        </namePart>
        <xsl:call-template name="role"/>
      </name>
    </xsl:if>
  </xsl:template>

  <!-- genre 047 336 655 -->
  <xsl:template name="createGenreFrom047">
    <genre>
      <xsl:choose>
        <xsl:when test="@ind2 = ' '">
          <xsl:attribute name="authority">
            <xsl:text>marcmuscomp</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind2 = '7'">
          <xsl:if test="*:subfield[@code = '2']">
            <xsl:attribute name="authority">
              <xsl:call-template name="chopPunctuationBack">
                <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
                <xsl:with-param name="punctuation">
                  <xsl:text>.:,;/ </xsl:text>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>
        </xsl:when>
      </xsl:choose>
      <xsl:attribute name="type">
        <xsl:text>musical form codes</xsl:text>
      </xsl:attribute>
      <!-- Template checks for altRepGroup - 880 $6 -->
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">abcdef</xsl:with-param>
        <xsl:with-param name="delimeter"> -- </xsl:with-param>
      </xsl:call-template>
    </genre>
  </xsl:template>

  <xsl:template name="createGenreFrom336">
    <genre>
      <xsl:if test="*:subfield[@code = '2']">
        <xsl:attribute name="authority">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <!-- Template checks for altRepGroup - 880 $6 -->
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">a</xsl:with-param>
        <xsl:with-param name="delimeter">-</xsl:with-param>
      </xsl:call-template>
    </genre>
  </xsl:template>

  <xsl:template name="createGenreFrom655">
    <genre authority="marcgt">
      <xsl:choose>
        <xsl:when test="*:subfield[@code = '2']">
          <xsl:attribute name="authority">
            <xsl:call-template name="chopPunctuationBack">
              <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
              <xsl:with-param name="punctuation">
                <xsl:text>.:,;/ </xsl:text>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind2 = '0'">
          <xsl:attribute name="authority">
            <xsl:text>lcsh</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind2 = '1'">
          <xsl:attribute name="authority">
            <xsl:text>lcshac</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind2 = '2'">
          <xsl:attribute name="authority">
            <xsl:text>mesh</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind2 = '3'">
          <xsl:attribute name="authority">
            <xsl:text>nal</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind2 = '5'">
          <xsl:attribute name="authority">
            <xsl:text>csh</xsl:text>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind2 = '6'">
          <xsl:attribute name="authority">
            <xsl:text>rvm</xsl:text>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <!-- Template checks for altRepGroup - 880 $6 -->
      <xsl:call-template name="xxx880"/>
      <xsl:variable name="stringValue">
        <xsl:call-template name="subfieldSelect">
          <xsl:with-param name="codes">abvxyz</xsl:with-param>
          <xsl:with-param name="delimeter">-</xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="replace($stringValue, '[\.,;:]+$', '')"/>
    </genre>
  </xsl:template>

  <!-- TOC 505 -->
  <xsl:template name="createTOCFrom505">
    <tableOfContents>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">agrt</xsl:with-param>
      </xsl:call-template>
    </tableOfContents>
  </xsl:template>

  <!-- abstract 520 -->
  <xsl:template name="createAbstractFrom520">
    <abstract>
      <xsl:choose>
        <xsl:when test="@ind1 = ' '">
          <xsl:attribute name="type">Summary</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '0'">
          <xsl:attribute name="type">Subject</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '1'">
          <xsl:attribute name="type">Review</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '2'">
          <xsl:attribute name="type">Scope and content</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '3'">
          <xsl:attribute name="type">Abstract</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '4'">
          <xsl:attribute name="type">Content advice</xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="abstractText">
        <xsl:variable name="abstractText">
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">
              <xsl:choose>
                <!-- subfied $a is a single word, just use $b -->
                <xsl:when test="not(matches(normalize-space(*:subfield[@code = 'a']), '\s'))">
                  <xsl:text>b</xsl:text>
                </xsl:when>
                <xsl:otherwise>ab</xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$abstractText"/>
        <xsl:if test="*:subfield[@code = 'c']">
          <xsl:if test="normalize-space($abstractText) != ''">
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:value-of select="concat('[', normalize-space(*:subfield[@code = 'c']), ']')"/>
        </xsl:if>
        <xsl:if test="*:subfield[@code = '2']">
          <xsl:if test="normalize-space($abstractText) != ''">
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:value-of select="concat('[', normalize-space(*:subfield[@code = '2']), ']')"/>
        </xsl:if>
      </xsl:variable>
      <!-- Remove markup -->
      <xsl:variable name="abstractTextWithoutMarkup">
        <xsl:call-template name="removeEscapedMarkup">
          <xsl:with-param name="string">
            <xsl:value-of select="normalize-space(replace($abstractText, '&amp;#160;', ' '))"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="normalize-space($abstractTextWithoutMarkup)"/>
    </abstract>
  </xsl:template>

  <xsl:template name="removeEscapedMarkup">
    <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="contains($string, '&lt;')">
        <xsl:value-of select="concat(substring-before($string, '&lt;'), ' ')"/>
        <xsl:call-template name="removeEscapedMarkup">
          <xsl:with-param name="string" select="concat(' ', substring-after($string, '&gt;'))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- targetAudience 521 -->
  <xsl:template name="createTargetAudienceFrom521">
    <targetAudience>
      <xsl:choose>
        <xsl:when test="@ind1 = ' '">
          <xsl:attribute name="displayLabel">Audience</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '0'">
          <xsl:attribute name="displayLabel">Reading grade level</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '1'">
          <xsl:attribute name="displayLabel">Interest age level</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '2'">
          <xsl:attribute name="displayLabel">Interest grade level</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '3'">
          <xsl:attribute name="displayLabel">Special audience characteristics</xsl:attribute>
        </xsl:when>
        <xsl:when test="@ind1 = '4'">
          <xsl:attribute name="displayLabel">Motivation/interest level</xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">ab</xsl:with-param>
      </xsl:call-template>
    </targetAudience>
  </xsl:template>

  <!-- note 245c thru 585 -->
  <xsl:template name="createNoteFrom245c">
    <xsl:if test="*:subfield[@code = 'c']">
      <note type="statement of responsibility">
        <!--<xsl:attribute name="altRepGroup">
          <xsl:text>00</xsl:text>
        </xsl:attribute>-->
        <xsl:call-template name="scriptCode"/>
        <xsl:call-template name="subfieldSelect">
          <xsl:with-param name="codes">c</xsl:with-param>
        </xsl:call-template>
      </note>
    </xsl:if>
  </xsl:template>

  <xsl:template name="createNoteFrom362">
    <note type="date/sequential designation">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom500">
    <note type="general">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:value-of select="normalize-space(*:subfield[@code = 'a'])"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom502">
    <note type="thesis">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom504">
    <note type="bibliography">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom508">
    <note type="creation/production credits">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each
          select="*:subfield[@code != 'u' and @code != '3' and @code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom511">
    <note type="performers">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom515">
    <note type="numbering">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom518">
    <note type="venue">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '3' and @code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom524">
    <note type="preferred citation">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom530">
    <note type="additional physical form">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each
          select="*:subfield[@code != 'u' and @code != '3' and @code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom533">
    <note type="reproduction">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom535">
    <note type="original location">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom536">
    <note type="funding">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom538">
    <note type="system details">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom541">
    <note type="acquisition">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:choose>
          <!-- Exclude subfields a, b, f, and h -->
          <xsl:when test="@ind1 = '0' or $redact541 = 'true'">
            <xsl:for-each
              select="*:subfield[@code != '6' and @code != '8' and @code != 'a' and @code != 'b' and @code != 'f' and @code != 'h']">
              <xsl:value-of select="."/>
              <xsl:if test="position() ne last()">
                <xsl:text> </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
              <xsl:value-of select="."/>
              <xsl:if test="position() ne last()">
                <xsl:text> </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:value-of select="normalize-space($str)"/>
    </note>
    <!-- Place acquisition info in private note -->
    <xsl:if test="@ind1 = '0' or $redact541 = 'true'">
      <note type="private_541">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:if test="position() ne last()">
            <xsl:text> </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </note>
    </xsl:if>
  </xsl:template>

  <xsl:template name="createNoteFrom545">
    <note type="biographical/historical">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom546">
    <note type="language">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom561">
    <note type="ownership">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom562">
    <note type="version identification">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom581">
    <note type="publications">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom583">
    <note type="action">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom585">
    <note type="exhibitions">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="."/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 1))"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom59x">
    <note>
      <xsl:attribute name="type">
        <xsl:value-of select="concat('local_', @tag)"/>
      </xsl:attribute>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:value-of select="*:subfield[@code = 'a']"/>
    </note>
  </xsl:template>

  <xsl:template name="createNoteFrom5XX">
    <note>
      <xsl:variable name="noteType">
        <xsl:choose>
          <xsl:when test="@tag = '501'">with</xsl:when>
          <xsl:when test="@tag = '507'">scale</xsl:when>
          <xsl:when test="@tag = '513'">report</xsl:when>
          <xsl:when test="@tag = '514'">data_quality</xsl:when>
          <xsl:when test="@tag = '516'">file_type</xsl:when>
          <xsl:when test="@tag = '522'">geographic</xsl:when>
          <xsl:when test="@tag = '525'">supplement</xsl:when>
          <xsl:when test="@tag = '526'">study_program</xsl:when>
          <xsl:when test="@tag = '544' and @ind1 = ' '">archival</xsl:when>
          <xsl:when test="@tag = '544' and @ind1 = '0'">separated_material</xsl:when>
          <xsl:when test="@tag = '544' and @ind1 = '1'">related_material</xsl:when>
          <!--<xsl:when test="@tag = '544'">archival</xsl:when>-->
          <xsl:when test="@tag = '547'">title_complexity</xsl:when>
          <xsl:when test="@tag = '550'">issuing_body</xsl:when>
          <xsl:when test="@tag = '552'">entity-attribute</xsl:when>
          <xsl:when test="@tag = '555'">index/finding_aid</xsl:when>
          <xsl:when test="@tag = '556'">documentation</xsl:when>
          <xsl:when test="@tag = '565'">case_file</xsl:when>
          <xsl:when test="@tag = '567'">methodology</xsl:when>
          <xsl:when test="@tag = '580'">linking_complexity</xsl:when>
          <xsl:when test="@tag = '584'">accumulation/frequency</xsl:when>
          <xsl:when test="@tag = '586'">awards</xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:if test="$noteType ne ''">
        <xsl:attribute name="type">
          <xsl:value-of select="$noteType"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="uri"/>
      <xsl:variable name="str">
        <xsl:for-each select="*:subfield[@code != '6' and @code != '8']">
          <xsl:value-of select="normalize-space(.)"/>
          <xsl:choose>
            <xsl:when test="matches(normalize-space(.), '[.,;:]$')">
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>; </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(substring($str, 1, string-length($str) - 2))"/>
    </note>
  </xsl:template>

  <!-- subject Geo 034 043 045 255 656 662 752 -->
  <xsl:template name="createSubGeoFrom034">
    <xsl:if
      test="*:datafield[@tag = '034'][*:subfield[@code = 'd' or @code = 'e' or @code = 'f' or @code = 'g']]">
      <subject>
        <xsl:call-template name="xxx880"/>
        <cartographics>
          <coordinates>
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">defg</xsl:with-param>
            </xsl:call-template>
          </coordinates>
        </cartographics>
      </subject>
    </xsl:if>
  </xsl:template>

  <xsl:template name="createSubGeoFrom043">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:for-each select="*:subfield[@code = 'a' or @code = 'b' or @code = 'c']">
        <geographicCode>
          <xsl:attribute name="authority">
            <xsl:if test="@code = 'a'">
              <xsl:text>marcgac</xsl:text>
            </xsl:if>
            <xsl:if test="@code = 'b'">
              <xsl:value-of select="following-sibling::*:subfield[@code = '2']"/>
            </xsl:if>
            <xsl:if test="@code = 'c'">
              <xsl:text>iso3166</xsl:text>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="self::*:subfield"/>
        </geographicCode>
      </xsl:for-each>
    </subject>
  </xsl:template>

  <xsl:template name="createSubGeoFrom255">
    <subject>
      <xsl:call-template name="xxx880"/>
      <cartographics>
        <xsl:for-each select="*:subfield[@code = 'a' or @code = 'b' or @code = 'c']">
          <xsl:if test="@code = 'a'">
            <scale>
              <xsl:value-of select="."/>
            </scale>
          </xsl:if>
          <xsl:if test="@code = 'b'">
            <projection>
              <xsl:value-of select="."/>
            </projection>
          </xsl:if>
          <xsl:if test="@code = 'c'">
            <coordinates>
              <xsl:value-of select="."/>
            </coordinates>
          </xsl:if>
        </xsl:for-each>
      </cartographics>
    </subject>
  </xsl:template>

  <xsl:template name="createSubNameFrom600">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subjectAuthority"/>
      <name type="personal">
        <namePart>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">aq</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </namePart>
        <xsl:call-template name="termsOfAddress"/>
        <xsl:call-template name="nameDate"/>
        <xsl:call-template name="affiliation"/>
        <xsl:call-template name="role"/>
      </name>
      <xsl:if test="*:subfield[@code = 't']">
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">t</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
      </xsl:if>
      <xsl:call-template name="subjectAnyOrder"/>
    </subject>
  </xsl:template>

  <xsl:template name="createSubNameFrom610">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subjectAuthority"/>
      <name type="corporate">
        <xsl:for-each select="*:subfield[@code = 'a']">
          <namePart>
            <xsl:value-of select="."/>
          </namePart>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'b']">
          <namePart>
            <xsl:value-of select="."/>
          </namePart>
        </xsl:for-each>
        <xsl:if test="*:subfield[@code = 'c' or @code = 'd' or @code = 'n' or @code = 'p']">
          <namePart>
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">cdnp</xsl:with-param>
            </xsl:call-template>
          </namePart>
        </xsl:if>
        <xsl:call-template name="role"/>
      </name>
      <xsl:if test="*:subfield[@code = 't']">
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">t</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
      </xsl:if>
      <xsl:call-template name="subjectAnyOrder"/>
    </subject>
  </xsl:template>

  <xsl:template name="createSubNameFrom611">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subjectAuthority"/>
      <name type="conference">
        <namePart>
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">abcdeqnp</xsl:with-param>
          </xsl:call-template>
        </namePart>
        <xsl:for-each select="*:subfield[@code = '4']">
          <role>
            <roleTerm authority="marcrelator" type="code">
              <xsl:value-of select="."/>
            </roleTerm>
          </role>
        </xsl:for-each>
      </name>
      <xsl:if test="*:subfield[@code = 't']">
        <titleInfo>
          <title>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString">
                <xsl:call-template name="subfieldSelect">
                  <xsl:with-param name="codes">tpn</xsl:with-param>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:call-template>
          </title>
          <xsl:call-template name="part"/>
        </titleInfo>
      </xsl:if>
      <xsl:call-template name="subjectAnyOrder"/>
    </subject>
  </xsl:template>

  <xsl:template name="createSubTitleFrom630">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subjectAuthority"/>
      <titleInfo>
        <title>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">adfhklor</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </title>
        <xsl:call-template name="part"/>
      </titleInfo>
      <xsl:call-template name="subjectAnyOrder"/>
    </subject>
  </xsl:template>

  <xsl:template name="createSubChronFrom648">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:if test="*:subfield[@code = '2']">
        <xsl:attribute name="authority">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = 'a']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="uri"/>
      <xsl:call-template name="subjectAuthority"/>
      <temporal>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">abcd</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </temporal>
      <xsl:call-template name="subjectAnyOrder"/>
    </subject>
  </xsl:template>

  <xsl:template name="createSubTopFrom650">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subjectAuthority"/>
      <topic>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:call-template name="subfieldSelect">
              <xsl:with-param name="codes">abcd</xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </topic>
      <xsl:call-template name="subjectAnyOrder"/>
    </subject>
  </xsl:template>

  <xsl:template name="createSubGeoFrom651">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subjectAuthority"/>
      <xsl:for-each select="*:subfield[@code = 'a']">
        <geographic>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString" select="."/>
          </xsl:call-template>
        </geographic>
      </xsl:for-each>
      <xsl:call-template name="subjectAnyOrder"/>
    </subject>
  </xsl:template>

  <xsl:template name="createSubFrom653">
    <xsl:if test="@ind2 = ' '">
      <subject>
        <topic>
          <xsl:value-of select="."/>
        </topic>
      </subject>
    </xsl:if>
    <xsl:if test="@ind2 = '0'">
      <subject>
        <topic>
          <xsl:value-of select="."/>
        </topic>
      </subject>
    </xsl:if>

    <xsl:if test="@ind = ' ' or @ind1 = '0' or @ind1 = '1'">
      <subject>
        <name type="personal">
          <namePart>
            <xsl:value-of select="."/>
          </namePart>
        </name>
      </subject>
    </xsl:if>
    <xsl:if test="@ind1 = '3'">
      <subject>
        <name type="family">
          <namePart>
            <xsl:value-of select="."/>
          </namePart>
        </name>
      </subject>
    </xsl:if>
    <xsl:if test="@ind2 = '2'">
      <subject>
        <name type="corporate">
          <namePart>
            <xsl:value-of select="."/>
          </namePart>
        </name>
      </subject>
    </xsl:if>
    <xsl:if test="@ind2 = '3'">
      <subject>
        <name type="conference">
          <namePart>
            <xsl:value-of select="."/>
          </namePart>
        </name>
      </subject>
    </xsl:if>
    <xsl:if test="@ind2 = '4'">
      <subject>
        <temporal>
          <xsl:value-of select="."/>
        </temporal>
      </subject>
    </xsl:if>
    <xsl:if test="@ind2 = '5'">
      <subject>
        <geographic>
          <xsl:value-of select="."/>
        </geographic>
      </subject>
    </xsl:if>

    <xsl:if test="@ind2 = '6'">
      <subject>
        <genre>
          <xsl:value-of select="."/>
        </genre>
      </subject>
    </xsl:if>
  </xsl:template>

  <xsl:template name="createSubFrom656">
    <subject>
      <xsl:call-template name="xxx880"/>
      <xsl:if test="*:subfield[@code = '2']">
        <xsl:attribute name="authority">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <occupation>
        <xsl:call-template name="chopPunctuation">
          <xsl:with-param name="chopString">
            <xsl:value-of select="*:subfield[@code = 'a']"/>
          </xsl:with-param>
        </xsl:call-template>
      </occupation>
    </subject>
  </xsl:template>

  <xsl:template name="createSubGeoFrom662752">
    <subject>
      <xsl:call-template name="xxx880"/>
      <hierarchicalGeographic>
        <xsl:if test="*:subfield[@code = '0']">
          <xsl:attribute name="valueURI">
            <xsl:value-of select="*:subfield[@code = '0']"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:for-each select="*:subfield[@code = 'a']">
          <country>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString" select="."/>
            </xsl:call-template>
          </country>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'b']">
          <state>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString" select="."/>
            </xsl:call-template>
          </state>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'c']">
          <county>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString" select="."/>
            </xsl:call-template>
          </county>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'd']">
          <city>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString" select="."/>
            </xsl:call-template>
          </city>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'e']">
          <citySection>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString" select="."/>
            </xsl:call-template>
          </citySection>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'g']">
          <area>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString" select="."/>
            </xsl:call-template>
          </area>
        </xsl:for-each>
        <xsl:for-each select="*:subfield[@code = 'h']">
          <extraterrestrialArea>
            <xsl:call-template name="chopPunctuation">
              <xsl:with-param name="chopString" select="."/>
            </xsl:call-template>
          </extraterrestrialArea>
        </xsl:for-each>
      </hierarchicalGeographic>
    </subject>
  </xsl:template>

  <xsl:template name="createSubTemFrom045">
    <xsl:if test="*:self[@ind1 = '2'][*:subfield[@code = 'b' or @code = 'c']]">
      <subject>
        <xsl:call-template name="xxx880"/>
        <temporal encoding="iso8601" point="start">
          <xsl:call-template name="dates045b">
            <xsl:with-param name="str" select="*:subfield[@code = 'b' or @code = 'c'][1]"/>
          </xsl:call-template>
        </temporal>
        <temporal encoding="iso8601" point="end">
          <xsl:call-template name="dates045b">
            <xsl:with-param name="str" select="*:subfield[@code = 'b' or @code = 'c'][2]"/>
          </xsl:call-template>
        </temporal>
      </subject>
    </xsl:if>
  </xsl:template>

  <!-- classification 050 060 080 082 084 086 -->
  <xsl:template name="createClassificationFrom050">
    <xsl:for-each select="*:subfield[@code = 'b']">
      <classification authority="lcc">
        <xsl:call-template name="xxx880"/>
        <xsl:if test="../*:subfield[@code = '3']">
          <xsl:attribute name="displayLabel">
            <xsl:value-of select="../*:subfield[@code = '3']"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="preceding-sibling::*:subfield[@code = 'a'][1]"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="text()"/>
      </classification>
    </xsl:for-each>
    <xsl:for-each select="*:subfield[@code = 'a'][not(following-sibling::*:subfield[@code = 'b'])]">
      <classification authority="lcc">
        <xsl:call-template name="xxx880"/>
        <xsl:if test="../*:subfield[@code = '3']">
          <xsl:attribute name="displayLabel">
            <xsl:value-of select="../*:subfield[@code = '3']"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="text()"/>
      </classification>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="createClassificationFrom060">
    <classification authority="nlm">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">ab</xsl:with-param>
      </xsl:call-template>
    </classification>
  </xsl:template>

  <xsl:template name="createClassificationFrom080">
    <classification authority="udc">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">abx</xsl:with-param>
      </xsl:call-template>
    </classification>
  </xsl:template>

  <xsl:template name="createClassificationFrom082">
    <classification authority="ddc">
      <xsl:call-template name="xxx880"/>
      <xsl:if test="*:subfield[@code = '2']">
        <xsl:attribute name="edition">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">ab</xsl:with-param>
      </xsl:call-template>
    </classification>
  </xsl:template>

  <xsl:template name="createClassificationFrom084">
    <classification>
      <xsl:attribute name="authority">
        <xsl:call-template name="chopPunctuationBack">
          <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
          <xsl:with-param name="punctuation">
            <xsl:text>.:,;/ </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">ab</xsl:with-param>
      </xsl:call-template>
    </classification>
  </xsl:template>

  <xsl:template name="createClassificationFrom086">
    <xsl:for-each select="*:datafield[@tag = '086'][@ind1 = '0']">
      <classification authority="sudocs">
        <xsl:call-template name="xxx880"/>
        <xsl:value-of select="*:subfield[@code = 'a']"/>
      </classification>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '086'][@ind1 = '1']">
      <classification authority="candoc">
        <xsl:call-template name="xxx880"/>
        <xsl:value-of select="*:subfield[@code = 'a']"/>
      </classification>
    </xsl:for-each>
    <xsl:for-each select="*:datafield[@tag = '086'][@ind1 != '1' and @ind1 != '0']">
      <classification>
        <xsl:call-template name="xxx880"/>
        <xsl:attribute name="authority">
          <xsl:call-template name="chopPunctuationBack">
            <xsl:with-param name="chopString" select="*:subfield[@code = '2']"/>
            <xsl:with-param name="punctuation">
              <xsl:text>.:,;/ </xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:value-of select="*:subfield[@code = 'a']"/>
      </classification>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="createClassificationFrom090">
    <classification authority="uva">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">ab</xsl:with-param>
      </xsl:call-template>
    </classification>
  </xsl:template>

  <xsl:template name="createClassificationFrom099">
    <classification authority="uva">
      <xsl:call-template name="xxx880"/>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">ab</xsl:with-param>
      </xsl:call-template>
    </classification>
  </xsl:template>

  <xsl:template name="createRelatedItemFrom490">
    <relatedItem type="series">
      <xsl:call-template name="xxx880"/>
      <titleInfo>
        <!-- Put initial articles in <nonSort>? -->
        <title>
          <xsl:call-template name="chopPunctuation">
            <xsl:with-param name="chopString">
              <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">av</xsl:with-param>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:call-template>
        </title>
        <xsl:call-template name="part"/>
      </titleInfo>
    </relatedItem>
  </xsl:template>

  <!-- location 852 856 -->
  <xsl:template name="createLocationFrom852">
    <location>
      <xsl:if test="*:subfield[@code = 'a' or @code = 'b' or @code = 'c' or @code = 'e']">
        <physicalLocation>
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">abce</xsl:with-param>
          </xsl:call-template>
        </physicalLocation>
      </xsl:if>
      <xsl:if
        test="*:subfield[@code = 'h' or @code = 'i' or @code = 'j' or @code = 'k' or @code = 'm']">
        <shelfLocator>
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">hijkm</xsl:with-param>
          </xsl:call-template>
        </shelfLocator>
      </xsl:if>
      <xsl:for-each select="*:subfield[@code = 'u']">
        <url>
          <xsl:call-template name="uri"/>
          <xsl:value-of select="."/>
        </url>
      </xsl:for-each>
      <xsl:choose>
        <xsl:when test="*:subfield[@code = 'p' or @code = 't']">
          <holdingSimple>
            <copyInformation>
              <xsl:for-each select="*:subfield[@code = 'p'] | *:subfield[@code = 't']">
                <itemIdentifier>
                  <xsl:choose>
                    <!-- barcode -->
                    <xsl:when test="@code = 'p' and matches(normalize-space(.), '^X\d+$')">
                      <xsl:attribute name="type">
                        <xsl:text>barcode</xsl:text>
                      </xsl:attribute>
                    </xsl:when>
                    <!-- copy number -->
                    <xsl:when test="@code = 't'">
                      <xsl:attribute name="type">
                        <xsl:text>copy number</xsl:text>
                      </xsl:attribute>
                    </xsl:when>
                  </xsl:choose>
                  <xsl:apply-templates select="."/>
                </itemIdentifier>
              </xsl:for-each>
            </copyInformation>
          </holdingSimple>
        </xsl:when>
      </xsl:choose>
    </location>
  </xsl:template>

  <xsl:template name="createLocationFrom866-868">
    <location>
      <xsl:call-template name="createHoldingsSimpleFrom866-868"/>
    </location>
  </xsl:template>

  <xsl:template name="createHoldingsSimpleFrom866-868">
    <holdingSimple>
      <copyInformation>
        <xsl:for-each select="//*:datafield[matches(@tag, '866')]">
          <xsl:sort select="*:subfield[@code = '8']" data-type="number"/>
          <enumerationAndChronology>
            <xsl:attribute name="unitType">
              <xsl:choose>
                <xsl:when test="@ind1 = ' '">1</xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@ind1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="normalize-space(*:subfield[@code = 'a'])"/>
            <xsl:if test="*:subfield[@code = 'z']">
              <xsl:text> [</xsl:text>
              <xsl:value-of select="normalize-space(string-join(*:subfield[@code = 'z'], ', '))"/>
              <xsl:text>]</xsl:text>
            </xsl:if>
          </enumerationAndChronology>
        </xsl:for-each>
        <xsl:for-each select="//*:datafield[matches(@tag, '867')]">
          <xsl:sort select="*:subfield[@code = '8']" data-type="number"/>
          <enumerationAndChronology>
            <xsl:attribute name="unitType">
              <xsl:choose>
                <xsl:when test="@ind1 = ' '">1</xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@ind1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="normalize-space(*:subfield[@code = 'a'])"/>
            <xsl:if test="*:subfield[@code = 'z']">
              <xsl:text> [</xsl:text>
              <xsl:value-of select="normalize-space(string-join(*:subfield[@code = 'z'], ', '))"/>
              <xsl:text>]</xsl:text>
            </xsl:if>
          </enumerationAndChronology>
        </xsl:for-each>
        <xsl:for-each select="//*:datafield[matches(@tag, '868')]">
          <xsl:sort select="*:subfield[@code = '8']" data-type="number"/>
          <enumerationAndChronology>
            <xsl:text>Indexes: </xsl:text>
            <xsl:value-of select="normalize-space(*:subfield[@code = 'a'])"/>
            <xsl:if test="*:subfield[@code = 'z']">
              <xsl:text> [</xsl:text>
              <xsl:value-of select="normalize-space(string-join(*:subfield[@code = 'z'], ', '))"/>
              <xsl:text>]</xsl:text>
            </xsl:if>
          </enumerationAndChronology>
        </xsl:for-each>
      </copyInformation>
    </holdingSimple>
  </xsl:template>

  <xsl:template name="createAccessConditionFrom506">
    <accessCondition type="restriction on access">
      <xsl:call-template name="xxx880"/>
      <xsl:if test="*:subfield[@code = 'u']">
        <xsl:attribute name="xlink:href">
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">u</xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">abcd35</xsl:with-param>
      </xsl:call-template>
    </accessCondition>
  </xsl:template>

  <xsl:template name="createAccessConditionFrom540">
    <accessCondition type="use and reproduction">
      <xsl:call-template name="xxx880"/>
      <xsl:if test="*:subfield[@code = 'u']">
        <xsl:attribute xmlns="http://www.w3.org/1999/xlink" name="xlink:href">
          <xsl:call-template name="subfieldSelect">
            <xsl:with-param name="codes">u</xsl:with-param>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="subfieldSelect">
        <xsl:with-param name="codes">abcdf35</xsl:with-param>
      </xsl:call-template>
    </accessCondition>
  </xsl:template>

  <!-- 880 global copy template -->
  <xsl:template match="* | @*" mode="global_copy">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | text()" mode="global_copy"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="createHoldingSimpleFrom999">
    <location>
      <physicalLocation>
        <xsl:value-of select="normalize-space(*:subfield[@code = 'm'][1])"/>
      </physicalLocation>
      <holdingSimple>
        <copyInformation>
          <xsl:for-each select="*:subfield[@code = 't'][1]">
            <form>
              <xsl:value-of select="normalize-space(.)"/>
            </form>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'm'][position() &gt; 1]">
            <subLocation>
              <xsl:value-of select="normalize-space(.)"/>
            </subLocation>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'l']">
            <subLocation>
              <xsl:value-of select="normalize-space(.)"/>
            </subLocation>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'a']">
            <shelfLocator>
              <xsl:value-of select="normalize-space(.)"/>
            </shelfLocator>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'w']">
            <note type="call_number_sort">
              <xsl:value-of select="normalize-space(.)"/>
            </note>
          </xsl:for-each>
          <xsl:for-each select="*:subfield[@code = 'i']">
            <itemIdentifier>
              <xsl:choose>
                <xsl:when test="matches(., '^X')">
                  <xsl:attribute name="type">
                    <xsl:text>barcode</xsl:text>
                  </xsl:attribute>
                </xsl:when>
                <xsl:when test="matches(., '^\d+-\d+$')">
                  <xsl:attribute name="type">
                    <xsl:text>autogen</xsl:text>
                  </xsl:attribute>
                </xsl:when>
              </xsl:choose>
              <xsl:value-of select="normalize-space(.)"/>
            </itemIdentifier>
          </xsl:for-each>
        </copyInformation>
      </holdingSimple>
    </location>
  </xsl:template>

  <xsl:template name="createLocationFrom974">
    <location>
      <url>
        <xsl:if test="count(../*:datafield[@tag = '974']) = 1">
          <xsl:attribute name="usage">primary</xsl:attribute>
        </xsl:if>
        <xsl:if test="*:subfield[@code = 'z']">
          <xsl:attribute name="displayLabel">
            <xsl:value-of select="*:subfield[@code = 'z']"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:text>http://hdl.handle.net/2027/</xsl:text>
        <xsl:value-of select="*:subfield[@code = 'u']"/>
      </url>
    </location>
  </xsl:template>

</xsl:stylesheet>
