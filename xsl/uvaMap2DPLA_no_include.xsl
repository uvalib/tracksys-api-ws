<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://dplava.lib.virginia.edu" xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:edm="http://www.europeana.eu/schemas/edm/" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xs" version="2.0">

  <!--<xsl:include href="uvaMAP2DPLArightsMap.xsl"/>-->
  <!-- Collection Name - Rights Statement Map -->
  <xsl:variable name="rightsMap">
    <collection>
      <hostName>Digital Library Text Collection</hostName>
      <rights>http://rightsstatements.org/vocab/NoC-US/1.0/</rights>
    </collection>
    <collection>
      <hostName>Frances Benjamin Johnston</hostName>
      <rights>http://rightsstatements.org/vocab/NoC-US/1.0/</rights>
    </collection>
    <collection>
      <hostName>Holsinger</hostName>
      <rights>http://rightsstatements.org/vocab/UND/1.0/</rights>
    </collection>
    <collection>
      <hostName>Jackson Davis</hostName>
      <rights>http://rightsstatements.org/vocab/NoC-US/1.0/</rights>
    </collection>
    <collection>
      <hostName>Medical Artifacts</hostName>
      <rights>http://rightsstatements.org/vocab/InC-NC/1.0/</rights>
    </collection>
    <collection>
      <hostName>Printing Services</hostName>
      <rights>http://rightsstatements.org/vocab/CNE/1.0/</rights>
    </collection>
    <collection>
      <hostName>Vanity Fair</hostName>
      <rights>http://rightsstatements.org/vocab/NoC-US/1.0/</rights>
    </collection>
    <collection>
      <hostName>WSLS</hostName>
      <rights>http://rightsstatements.org/vocab/CNE/1.0/</rights>
    </collection>
  </xsl:variable>

  <!--<xsl:include href="uvaMAP2DPLAgenreMap.xsl"/>-->
  <!-- DPLA genre list to AAT url Map -->
  <xsl:variable name="dplaGenreList">
    <genre valueURI="http://vocab.getty.edu/aat/300193993">advertisements</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300343615">architectural documents</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300028051">books</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026739">broadsides (notices)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300141693">business records</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300028052">cartographic materials</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026832">census records</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300386879">ceramic ware (visual works)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300015635">comics (documents)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026877">correspondence</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300209275">costume (mode of fashion)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300265421">cultural artifacts</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300054168">decorative arts</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300033973">drawings (visual works)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300037680">furniture</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300027015">genealogies (histories)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300027777">government records</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300264849">graphic arts</genre>
    <genre valueURI="http://vocab.getty.edu/aat/30026392">interviews</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300209286">jewelry</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300136900">motion pictures (visual works)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300379591">natural history specimens</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026656">newspapers</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300202595">oral histories (document genre)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300033618">painting (visual works)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300220572">pamphlets</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300069200">performances (creative events)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026657">periodicals</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300046300">photographs</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026816">postcards</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300027221">posters</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300041273">prints (visual works)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300163404">reference sources</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300047090">sculpture (visual works)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026669">sermons</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026430">sheet music</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300028633">sound recordings</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300014063">textiles (visual works)</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300028028">theses</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300024841">tools</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300036926">weapons</genre>
    <genre valueURI="http://vocab.getty.edu/aat/300026646">yearbooks</genre>
  </xsl:variable>

  <xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="text/xml"
    omit-xml-declaration="no" standalone="no"/>
  <xsl:strip-space elements="*"/>

  <!-- ======================================================================= -->
  <!-- GLOBAL VARIABLES                                                        -->
  <!-- ======================================================================= -->

  <!-- program name -->
  <xsl:variable name="progName">
    <xsl:text>uvaMAP2DPLA_no_include.xsl</xsl:text>
  </xsl:variable>

  <!-- program version -->
  <xsl:variable name="progVersion">
    <xsl:text>1.0</xsl:text>
  </xsl:variable>

  <xsl:variable name="runDateTime">
    <xsl:value-of select="format-dateTime(current-dateTime(), '[Y][M02][D02]T[H01][m][s]')"/>
  </xsl:variable>

  <!-- ======================================================================= -->
  <!-- UTILITIES / NAMED TEMPLATES                                             -->
  <!-- ======================================================================= -->

  <xsl:template name="createHeaderComment">
    <xsl:comment>
      <xsl:text>&#32;Generated using </xsl:text>
      <xsl:value-of select="$progName"/>
      <xsl:text> (v. </xsl:text>
      <xsl:value-of select="$progVersion"/>
      <xsl:text>) on </xsl:text>
      <xsl:value-of select="format-date(current-date(), '[Y]-[M01]-[D01]')"/>
      <xsl:text> at </xsl:text><xsl:value-of select="format-time(current-time(), '[h]:[m] [P]')"/>
      <xsl:text>&#32;</xsl:text>
    </xsl:comment>
  </xsl:template>

  <xsl:template name="createTrailingLabel">
    <xsl:choose>
      <xsl:when test="matches(@name, 'comp_')">
        <xsl:choose>
          <xsl:when test="@role">
            <xsl:value-of select="concat(' [', normalize-space(@role), ']')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> [component]</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="matches(@name, 'host_')">
        <xsl:choose>
          <xsl:when test="@role">
            <xsl:value-of select="concat(' [', normalize-space(@role), ']')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> [host]</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="matches(@name, 'orig_')">
        <xsl:choose>
          <xsl:when test="@role">
            <xsl:value-of select="concat(' [', normalize-space(@role), ']')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> [original]</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="matches(@name, 'work_')">
        <xsl:choose>
          <xsl:when test="@role">
            <xsl:value-of select="concat(' [', normalize-space(@role), ']')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> [work]</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- ======================================================================= -->
  <!-- MAIN OUTPUT TEMPLATE                                                    -->
  <!-- ======================================================================= -->

  <xsl:template match="/">
    <xsl:processing-instruction name="xml-model">href="https://dplava.lib.virginia.edu/dplava.xsd" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
    <xsl:call-template name="createHeaderComment"/>
    <xsl:choose>
      <!-- Document element for multiple records is mdRecordGrp -->
      <xsl:when test="count(*:uvaMAP/*:doc) &gt; 1">
        <xsl:apply-templates select="*:uvaMAP"/>
      </xsl:when>
      <!-- Document element for single record is mdRecord -->
      <xsl:otherwise>
        <xsl:apply-templates select="*:uvaMAP/*:doc"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ======================================================================= -->
  <!-- MATCH TEMPLATES FOR ELEMENTS                                            -->
  <!-- ======================================================================= -->

  <xsl:template match="*:uvaMAP">
    <mdRecordGrp xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns="http://dplava.lib.virginia.edu" xmlns:dcterms="http://purl.org/dc/terms/"
      xmlns:edm="http://www.europeana.eu/schemas/edm/"
      xsi:schemaLocation="http://dplava.lib.virginia.edu https://dplava.lib.virginia.edu/dplava.xsd">
      <xsl:apply-templates select="*:doc"/>
    </mdRecordGrp>
  </xsl:template>

  <xsl:template match="*:doc">
    <mdRecord xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns="http://dplava.lib.virginia.edu" xmlns:dcterms="http://purl.org/dc/terms/"
      xmlns:edm="http://www.europeana.eu/schemas/edm/">
      <xsl:if test="position() = 1 and position() = last()">
        <xsl:attribute name="xsi:schemaLocation">
          <xsl:value-of select="
              concat('http://dplava.lib.virginia.edu', ' ',
              'https://dplava.lib.virginia.edu/dplava.xsd')"/>
        </xsl:attribute>
      </xsl:if>
      <!-- Data provider -->
      <dcterms:provenance>University of Virginia</dcterms:provenance>

      <!-- Resource type -->
      <xsl:apply-templates select="*:field[matches(@name, '^(contentType|genre)$')]"/>

      <!-- Identifier -->
      <!-- Select most appropriate identifier -->
      <xsl:choose>
        <!-- PID -->
        <xsl:when
          test="*:field[matches(@name, '^(identifier)$')][matches(normalize-space(lower-case(@type)), '^pid$')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(identifier)$')][matches(normalize-space(lower-case(@type)), '^pid$')][1]"
          />
        </xsl:when>
        <!-- Original identifier -->
        <xsl:when test="*:field[matches(@name, '^(orig_identifier)$')][not(@invalid = 'yes')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(orig_identifier)$')][not(@invalid = 'yes')][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(orig_identifier)$')]">
          <xsl:apply-templates select="*:field[matches(@name, '^(orig_identifier)$')][1]"/>
        </xsl:when>
        <!-- Host identifer; e.g., collection -->
        <xsl:when test="*:field[matches(@name, '^(host_identifier)$')][not(@invalid = 'yes')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(host_identifier)$')][not(@invalid = 'yes')][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(host_identifier)$')]">
          <xsl:apply-templates select="*:field[matches(@name, '^(host_identifier)$')][1]"/>
        </xsl:when>
        <!-- Source record identifier; e.g., Sirsi record number -->
        <xsl:when
          test="*:field[matches(@name, '^(sourceRecordIdentifier)$')][not(@invalid = 'yes')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(sourceRecordIdentifier)$')][not(@invalid = 'yes')][1]"
          />
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(sourceRecordIdentifier)$')]">
          <xsl:apply-templates select="*:field[matches(@name, '^(sourceRecordIdentifier)$')][1]"/>
        </xsl:when>
        <!-- OCLC number -->
        <xsl:when test="*:field[matches(@name, '^(oclcNumber)$')][not(@invalid = 'yes')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(oclcNumber)$')][not(@invalid = 'yes')][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(oclcNumber)$')]">
          <xsl:apply-templates select="*:field[matches(@name, '^(oclcNumber)$')][1]"/>
        </xsl:when>
        <!-- Item ID/barcode -->
        <xsl:when test="*:field[matches(@name, '^(itemID)$')]">
          <xsl:apply-templates select="*:field[matches(@name, '^(itemID)$')][1]"/>
        </xsl:when>
      </xsl:choose>

      <!-- Title -->
      <xsl:apply-templates select="*:field[matches(@name, '^(displayTitle)$')]"/>

      <!-- Other titles -->
      <xsl:variable name="otherTitles">
        <xsl:for-each select="*:field[matches(@name, 'alternativeTitle')]">
          <xsl:sort/>
          <dcterms:title>
            <xsl:value-of select="concat(upper-case(substring(., 1, 1)), substring(., 2))"/>
          </dcterms:title>
        </xsl:for-each>
        <xsl:for-each select="*:field[matches(@name, 'work_title') and not(@supplied eq 'yes')]">
          <xsl:sort/>
          <dcterms:title>
            <xsl:value-of select="concat(upper-case(substring(., 1, 1)), substring(., 2))"/>
          </dcterms:title>
        </xsl:for-each>
      </xsl:variable>
      <xsl:for-each select="$otherTitles/dcterms:title">
        <xsl:if test="not(normalize-space(.) = '') and not(. = preceding-sibling::*)">
          <xsl:copy-of select="."/>
        </xsl:if>
      </xsl:for-each>

      <!-- Creator -->
      <!-- De-dupe language values -->
      <!-- Distinctions between the various kinds/roles of 'creator' are lost! -->
      <xsl:variable name="creators">
        <xsl:copy-of
          select="*:field[matches(@name, '^(comp_|host_|orig_|work_)?(creator|contributor)$')]"/>
      </xsl:variable>
      <xsl:variable name="creatorsSorted">
        <xsl:for-each select="$creators/*:field">
          <xsl:sort/>
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:for-each select="$creatorsSorted/*:field">
        <xsl:if test="not(. = preceding-sibling::*:field)">
          <xsl:apply-templates select="."/>
        </xsl:if>
      </xsl:for-each>

      <!-- Publisher -->
      <xsl:apply-templates select="*:field[matches(@name, '^(pubProdDist)$')]"/>

      <!-- Created -->
      <!-- Select most appropriate date, excluding any that contains 'undated' -->
      <xsl:choose>
        <xsl:when test="*:field[matches(@name, '^(dateIssued)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(dateIssued)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(copyrightDate)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(copyrightDate)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(dateCreated)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(dateCreated)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(dateValid)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(dateValid)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(dateCaptured)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(dateCaptured)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(dateModified)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(dateModified)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(dateOther)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(dateOther)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(orig_dateIssued)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(orig_dateIssued)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when
          test="*:field[matches(@name, '^(orig_copyrightDate)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(orig_copyrightDate)$')][not(matches(., 'undated'))][1]"
          />
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(orig_dateCreated)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(orig_dateCreated)$')][not(matches(., 'undated'))][1]"
          />
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(orig_dateValid)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(orig_dateValid)$')][1][not(matches(., 'undated'))]"/>
        </xsl:when>
        <xsl:when
          test="*:field[matches(@name, '^(orig_dateCaptured)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(orig_dateCaptured)$')][not(matches(., 'undated'))][1]"
          />
        </xsl:when>
        <xsl:when
          test="*:field[matches(@name, '^(orig_dateModified)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(orig_dateModified)$')][not(matches(., 'undated'))][1]"
          />
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(orig_dateOther)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(orig_dateOther)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(host_dateIssued)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(host_dateIssued)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when
          test="*:field[matches(@name, '^(host_copyrightDate)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(host_copyrightDate)$')][not(matches(., 'undated'))][1]"
          />
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(host_dateCreated)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(host_dateCreated)$')][not(matches(., 'undated'))][1]"
          />
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(host_dateValid)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(host_dateValid)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when
          test="*:field[matches(@name, '^(host_dateCaptured)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(host_dateCaptured)$')][not(matches(., 'undated'))][1]"
          />
        </xsl:when>
        <xsl:when
          test="*:field[matches(@name, '^(host_dateModified)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(host_dateModified)$')][not(matches(., 'undated'))][1]"
          />
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(host_dateOther)$')][not(matches(., 'undated'))]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(host_dateOther)$')][not(matches(., 'undated'))][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(keyDate)$')]">
          <xsl:apply-templates select="*:field[matches(@name, '^(keyDate)$')]"/>
        </xsl:when>
      </xsl:choose>

      <!-- Physical extent -->
      <xsl:apply-templates
        select="*:field[matches(@name, '(physDimensions|physExtent|playingTime)$')]"/>
      <xsl:apply-templates select="*:field[matches(@name, '^(accMatter)$')]"/>

      <!-- Physical form -->
      <xsl:apply-templates
        select="*:field[matches(@name, '(brailleMusicFormat|colorContent|filmPresentationFormat|illustrations|physDetails|playbackChannels|playbackSpecial|playingSpeed|projection|relief|scoreFormat|soundContent|videoFormat)$')]"/>

      <!-- Languages -->
      <!-- De-dupe language values -->
      <xsl:variable name="languages">
        <xsl:copy-of select="*:field[matches(@name, '^(language)$')]"/>
      </xsl:variable>
      <xsl:variable name="languagesSorted">
        <xsl:for-each select="$languages/*:field">
          <xsl:sort/>
          <xsl:apply-templates select="."/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:for-each select="$languagesSorted/*:language">
        <xsl:if test="not(. = preceding-sibling::*:language)">
          <xsl:copy-of select="."/>
        </xsl:if>
      </xsl:for-each>

      <!-- Description -->
      <xsl:apply-templates select="
          *:field[matches(@name, '(abstractSummary|contents|credits|culturalContext|editionVersion|originalsNote|performanceMedium|performers|stylePeriod)')]"/>
      <xsl:apply-templates select="
          *:field[matches(@name, '(note)$')][not(matches(@type, 'admin|general|statement of responsibility'))]"/>
      <xsl:apply-templates select="*:field[matches(@name, '(scale)$')]"/>

      <!-- Series/Host -->
      <xsl:apply-templates
        select="*:field[matches(@name, '^(seriesStatement|transliteratedSeriesStatement|host_title)$')]"/>

      <!-- Rights -->
      <xsl:choose>
        <!-- Use @valueURI on field[name='useRestrict'] -->
        <xsl:when
          test="*:field[matches(@name, '^(useRestrict)$')]/@valueURI[not(normalize-space(.) = '')]">
          <dcterms:rights>
            <xsl:value-of
              select="normalize-space(*:field[matches(@name, '^(useRestrict)$')]/@valueURI)"/>
          </dcterms:rights>
        </xsl:when>
        <!-- Use value of field[name='useRestrict'] -->
        <xsl:when
          test="*:field[matches(@name, '^(useRestrict)$')][matches(normalize-space(.), '^http')]">
          <dcterms:rights>
            <xsl:value-of
              select="normalize-space(*:field[matches(@name, '^(useRestrict)$')][matches(normalize-space(.), '^http')])"
            />
          </dcterms:rights>
        </xsl:when>
        <!-- Perform a look-up on the collection name -->
        <xsl:when test="*:field[matches(@name, '^host_title')]">
          <xsl:for-each select="*:field[matches(@name, '^host_title')][1]">
            <xsl:variable name="thisValue">
              <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="exists($rightsMap/*:collection/*:hostName[contains($thisValue, .)])">
                <dcterms:rights>
                  <xsl:value-of
                    select="$rightsMap/*:collection/*:hostName[contains($thisValue, .)]/../*:rights"
                  />
                </dcterms:rights>
              </xsl:when>
              <xsl:otherwise>
                <dcterms:rights>http://rightsstatements.org/vocab/CNE/1.0/</dcterms:rights>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:when>
        <!-- useRestrict missing, supply default -->
        <xsl:when test="not(*:field[matches(@name, '^(useRestrict)$')])">
          <dcterms:rights>http://rightsstatements.org/vocab/CNE/1.0/</dcterms:rights>
        </xsl:when>
      </xsl:choose>

      <!-- Subject -->
      <xsl:apply-templates select="*:field[matches(@name, '^(subject|subjectTemporal)$')]"/>

      <!-- Spatial -->
      <xsl:apply-templates
        select="*:field[matches(@name, '^(subjectGeographic|work_workLocation)$')]"/>

      <!-- URLs -->
      <!-- Choose most appropriate URLs  -->
      <xsl:apply-templates
        select="*:field[matches(@name, '^(uri)')][matches(@access, '(preview)')][1]"/>
      <xsl:choose>
        <!-- Prefer absolute URL -->
        <xsl:when
          test="*:field[matches(@name, '^(uri)')][matches(@access, 'object in context')][matches(., '^([a-z]+://)')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(uri)')][matches(@access, 'object in context')][matches(., '^([a-z]+://)')][1]"
          />
        </xsl:when>
        <xsl:when
          test="*:field[matches(@name, '^(uri)')][matches(@access, 'raw object')][matches(., '^([a-z]+://)')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(uri)')][matches(@access, 'raw object')][matches(., '^([a-z]+://)')][1]"
          />
        </xsl:when>
        <xsl:when
          test="*:field[matches(@name, '^(uri)')][matches(@usage, 'primary')][matches(., '^([a-z]+://)')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(uri)')][matches(@usage, 'primary')][matches(., '^([a-z]+://)')][1]"
          />
        </xsl:when>
        <!-- Relative URL is acceptable, but has to be hand-edited later  -->
        <xsl:when test="*:field[matches(@name, '^(uri)')][matches(@access, 'object in context')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(uri)')][matches(@access, 'object in context')][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(uri)')][matches(@access, 'raw object')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(uri)')][matches(@access, 'raw object')][1]"/>
        </xsl:when>
        <xsl:when test="*:field[matches(@name, '^(uri)')][matches(@usage, 'primary')]">
          <xsl:apply-templates
            select="*:field[matches(@name, '^(uri)')][matches(@usage, 'primary')][1]"/>
        </xsl:when>
        <!-- Any URL is better than none -->
        <xsl:otherwise>
          <xsl:apply-templates select="*:field[matches(@name, '^(uri)')][1]"/>
        </xsl:otherwise>
      </xsl:choose>

    </mdRecord>
  </xsl:template>

  <!-- Type -->
  <!-- Mapping at https://confluence.lib.virginia.edu/pages/viewpage.action?spaceKey=MDS&
        title=MODS+typeOfResource+to+DC+type+Controlled+Value+Crosswalk -->
  <!-- 
  text	=	Text
  cartographic	=	Image
  notated music	=	Text
  sound recording	=	Sound
  sound recording-musical	=	Sound
  sound recording-nonmusical	=	Sound
  still image	=	Still Image
  moving image	=	Moving Image
  three dimensional object	=	Physical Object
  software, multimedia	=	Software
  mixed material	=	do not map; do not include a dcterms:type element for mixed material
  -->
  <xsl:template match="*:field[matches(@name, '^(contentType)$')]">
    <xsl:choose>
      <!--<xsl:when test="matches(., 'mixed material')">
          <dcterms:type>collection</dcterms:type>
        </xsl:when>-->
      <xsl:when test="matches(., 'moving image', 'i')">
        <dcterms:type>moving image</dcterms:type>
      </xsl:when>
      <xsl:when test="matches(., 'three dimensional object', 'i')">
        <dcterms:type>physical object</dcterms:type>
      </xsl:when>
      <xsl:when test="matches(., 'software, multimedia', 'i')">
        <dcterms:type>software</dcterms:type>
      </xsl:when>
      <xsl:when test="matches(., 'sound recording', 'i')">
        <dcterms:type>sound</dcterms:type>
      </xsl:when>
      <xsl:when test="matches(., '(cartographic|still image)', 'i')">
        <dcterms:type>still image</dcterms:type>
      </xsl:when>
      <xsl:when test="matches(., '(text|notated music)', 'i')">
        <dcterms:type>text</dcterms:type>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Genre -->
  <!-- valueURI attribute is provided when genre value matches DPLA-approved genre value -->
  <!-- DPLA values at https://drive.google.com/open?id=1fJEWhnYy5Ch7_ef_-V48-FAViA72OieG -->
  <xsl:template match="*:field[matches(@name, '^(genre)$')]">
    <xsl:variable name="thisGenre">
      <xsl:value-of select="lower-case(replace(normalize-space(.), '\.+$', ''))"/>
    </xsl:variable>
    <xsl:if test="$dplaGenreList/*:genre[. = $thisGenre]">
      <edm:hasType>
        <xsl:for-each select="$dplaGenreList/*:genre[. = $thisGenre]">
          <xsl:copy-of select="@valueURI"/>
        </xsl:for-each>
        <xsl:value-of select="lower-case(normalize-space(.))"/>
      </edm:hasType>
    </xsl:if>
  </xsl:template>

  <!-- Description -->
  <xsl:template
    match="*:field[matches(@name, '(abstractSummary|contents|credits|culturalContext|editionVersion|note|originalsNote|performanceMedium|performers|scale|stylePeriod)$')]">
    <dcterms:description>
      <!--<xsl:if test="normalize-space(@displayLabel) != ''">
        <xsl:value-of select="concat(normalize-space(@displayLabel), ': ')"/>
      </xsl:if>-->
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:call-template name="createTrailingLabel"/>
    </dcterms:description>
  </xsl:template>

  <!-- Title -->
  <xsl:template match="*:field[matches(@name, '^(displayTitle)$')]">
    <dcterms:title>
      <xsl:value-of select="normalize-space(.)"/>
    </dcterms:title>
  </xsl:template>

  <!-- Creator -->
  <xsl:template match="*:field[matches(@name, '^(comp_|host_|orig_|work_)?(creator|contributor)$')]">
    <dcterms:creator>
      <xsl:copy-of select="@valueURI"/>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:call-template name="createTrailingLabel"/>
    </dcterms:creator>
  </xsl:template>

  <!-- Publisher -->
  <xsl:template match="*:field[matches(@name, '^(pubProdDist)$')]">
    <dcterms:publisher>
      <xsl:value-of select="normalize-space(.)"/>
    </dcterms:publisher>
  </xsl:template>

  <!-- Created -->
  <xsl:template
    match="*:field[matches(@name, '^(keyDate|(orig_|host_)?(dateIssued|copyrightDate|dateCreated|dateValid|dateCaptured|dateModified|dateOther))$')]">
    <dcterms:created>
      <xsl:value-of select="replace(replace(normalize-space(.), ' TO ', '/'), '\*', '..')"/>
    </dcterms:created>
  </xsl:template>

  <!-- Language -->
  <xsl:template match="*:field[matches(@name, '^(language)$')]">
    <dcterms:language>
      <xsl:value-of select="normalize-space(.)"/>
    </dcterms:language>
  </xsl:template>

  <!-- isPartOf -->
  <!-- Contains series or host title -->
  <xsl:template
    match="*:field[matches(@name, '^(seriesStatement|transliteratedSeriesStatement|host_title)$')]">
    <dcterms:isPartOf>
      <xsl:value-of select="normalize-space(.)"/>
    </dcterms:isPartOf>
  </xsl:template>

  <!-- Identifier -->
  <xsl:template
    match="*:field[matches(@name, '^(identifier|sourceRecordIdentifier|host_identifier|orig_identifier|oclcNumber|itemID)$')]">
    <dcterms:identifier>
      <xsl:value-of select="normalize-space(.)"/>
    </dcterms:identifier>
  </xsl:template>

  <!-- Extent -->
  <xsl:template match="*:field[matches(@name, '(accMatter|physExtent|playingTime)$')]">
    <dcterms:extent>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:call-template name="createTrailingLabel"/>
    </dcterms:extent>
  </xsl:template>

  <!-- Physical dimensions -->
  <!-- Don't include if the content duplicates what's in <physExtent> -->
  <xsl:template match="*:field[matches(@name, 'physDimensions$')]">
    <xsl:variable name="thisValue">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:variable>
    <xsl:if test="not(matches(../*:field[matches(@name, 'physExtent$')], $thisValue))">
      <dcterms:extent>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:call-template name="createTrailingLabel"/>
      </dcterms:extent>
    </xsl:if>
  </xsl:template>

  <!-- Medium -->
  <xsl:template
    match="*:field[matches(@name, '(brailleMusicFormat|colorContent|filmPresentationFormat|illustrations|physDetails|playbackChannels|playbackSpecial|playingSpeed|projection|relief|scoreFormat|soundContent|videoFormat)$')]">
    <dcterms:medium>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:call-template name="createTrailingLabel"/>
    </dcterms:medium>
  </xsl:template>

  <!-- Subject -->
  <xsl:template match="*:field[matches(@name, '^(subject)$')]">
    <xsl:variable name="thisValue">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:variable>
    <!-- Exclude a subject heading that matches a geographic subject heading -->
    <xsl:if
      test="not(exists(../*:field[matches(@name, '^(subjectGeographic)$')][normalize-space(.) = $thisValue]))">
      <dcterms:subject>
        <xsl:copy-of select="@valueURI"/>
        <xsl:value-of select="normalize-space(.)"/>
      </dcterms:subject>
    </xsl:if>
  </xsl:template>

  <!-- Spatial -->
  <xsl:template match="*:field[matches(@name, '^(subjectGeographic)$')]">
    <xsl:if test="not(@authority = 'marcgac')">
      <dcterms:spatial>
        <xsl:copy-of select="@valueURI"/>
        <xsl:variable name="descendingOrder">
          <xsl:analyze-string select="." regex="--">
            <xsl:non-matching-substring>
              <place>
                <xsl:value-of select="."/>
              </place>
            </xsl:non-matching-substring>
          </xsl:analyze-string>
        </xsl:variable>
        <xsl:variable name="ascendingOrder">
          <xsl:for-each select="$descendingOrder/*:place">
            <xsl:sort select="position()" order="descending"/>
            <xsl:copy-of select="."/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$ascendingOrder/*:place">
          <xsl:if test="position() != 1">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>
        </xsl:for-each>
      </dcterms:spatial>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*:field[matches(@name, '^(work_workLocation)$')]">
    <xsl:variable name="thisValue">
      <xsl:value-of select="lower-case(normalize-space(.))"/>
    </xsl:variable>
    <!-- Exclude a workLocation that matches a subject or subjectGeographic heading -->
    <xsl:if
      test="not(exists(../*:field[matches(@name, '^(subject|subjectGeographic)$')][lower-case(normalize-space(.)) = $thisValue]))">
      <dcterms:spatial>
        <xsl:copy-of select="@valueURI"/>
        <xsl:value-of select="normalize-space(.)"/>
      </dcterms:spatial>
    </xsl:if>
  </xsl:template>

  <!-- Temporal -->
  <xsl:template match="*:field[matches(@name, '^(subjectTemporal)$')]">
    <dcterms:temporal>
      <xsl:value-of select="normalize-space(.)"/>
    </dcterms:temporal>
  </xsl:template>

  <!-- Preview/isShownAt -->
  <xsl:template match="*:field[matches(@name, '^(uri)$')]">
    <xsl:variable name="fieldName">
      <xsl:choose>
        <xsl:when test="@access = 'preview'">
          <xsl:text>edm:preview</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>edm:isShownAt</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="{$fieldName}" xmlns="http://www.europeana.eu/schemas/edm/">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>


  <!-- ======================================================================= -->
  <!-- DEFAULT TEMPLATE                                                        -->
  <!-- ======================================================================= -->

  <xsl:template match="@* | node()" mode="#all">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="#current"/>
    </xsl:copy>
  </xsl:template>


</xsl:stylesheet>
