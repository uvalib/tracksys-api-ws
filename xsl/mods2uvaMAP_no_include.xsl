<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="mods xs" version="2.0">

  <xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="text/xml"
    omit-xml-declaration="no" standalone="no"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="PID" select="''"/>

  <!--<xsl:import href="marcCarrierMap.xsl"/>-->
  <!-- MARC - RDA Carrier Map -->
  <xsl:variable name="marcCarrierMap">
    <carrier rdaType="aperture card">aperture card</carrier>
    <carrier rdaType="audio cartridge">audio cartridge</carrier>
    <carrier rdaType="audio cartridge">sound cartridge</carrier>
    <carrier rdaType="audio cylinder">audio cylinder</carrier>
    <carrier rdaType="audio cylinder">cylinder</carrier>
    <carrier rdaType="audio disc">audio disc</carrier>
    <carrier rdaType="audio disc">sound disc</carrier>
    <carrier rdaType="audio roll">audio roll</carrier>
    <carrier rdaType="audiocassette">audiocassette</carrier>
    <carrier rdaType="audiocassette">sound cassette</carrier>
    <carrier rdaType="audiotape reel">audiotape reel</carrier>
    <carrier rdaType="card">activity card</carrier>
    <carrier rdaType="card">card</carrier>
    <carrier rdaType="card">flash card</carrier>
    <carrier rdaType="card">postcard</carrier>
    <carrier rdaType="computer card">computer card</carrier>
    <carrier rdaType="computer chip cartridge">computer chip cartridge</carrier>
    <carrier rdaType="computer disc cartridge">computer disc cartridge</carrier>
    <carrier rdaType="computer disc">computer disc</carrier>
    <carrier rdaType="computer disc">magnetic disk</carrier>
    <carrier rdaType="computer disc">magneto-optical disc</carrier>
    <carrier rdaType="computer disc">optical disc</carrier>
    <carrier rdaType="computer tape cartridge">computer tape cartridge</carrier>
    <carrier rdaType="computer tape cartridge">tape cartridge</carrier>
    <carrier rdaType="computer tape cassette">computer tape cassette</carrier>
    <carrier rdaType="computer tape cassette">tape cassette</carrier>
    <carrier rdaType="computer tape reel">computer tape reel</carrier>
    <carrier rdaType="computer tape reel">tape reel</carrier>
    <carrier rdaType="film cartridge">film cartridge</carrier>
    <carrier rdaType="film cassette">film cassette</carrier>
    <carrier rdaType="film reel">film reel</carrier>
    <carrier rdaType="film roll">film roll</carrier>
    <carrier rdaType="filmslip">filmslip</carrier>
    <carrier rdaType="filmstrip cartridge">filmstrip cartridge</carrier>
    <carrier rdaType="filmstrip">filmstrip</carrier>
    <carrier rdaType="filmstrip">other filmstrip type</carrier>
    <carrier rdaType="flipchart">flipchart</carrier>
    <carrier rdaType="microfiche cassette">microfiche cassette</carrier>
    <carrier rdaType="microfiche">microfiche</carrier>
    <carrier rdaType="microfilm cartridge">microfilm cartridge</carrier>
    <carrier rdaType="microfilm cassette">microfilm cassette</carrier>
    <carrier rdaType="microfilm reel">microfilm reel</carrier>
    <carrier rdaType="microfilm roll">microfilm roll</carrier>
    <carrier rdaType="microfilm slip">microfilm slip</carrier>
    <carrier rdaType="microopaque">microopaque</carrier>
    <carrier rdaType="microscope slide">microscope slide</carrier>
    <carrier rdaType="object">celestial globe</carrier>
    <carrier rdaType="object">diorama</carrier>
    <carrier rdaType="object">earth moon globe</carrier>
    <carrier rdaType="object">globe</carrier>
    <carrier rdaType="object">model</carrier>
    <carrier rdaType="object">object</carrier>
    <carrier rdaType="object">planetary or lunar globe</carrier>
    <carrier rdaType="object">realia</carrier>
    <carrier rdaType="object">terrestrial globe</carrier>
    <carrier rdaType="online resource">online resource</carrier>
    <carrier rdaType="other audio carrier">other audio carrier</carrier>
    <carrier rdaType="other audio carrier">sound recording</carrier>
    <carrier rdaType="other computer carrier">electronic</carrier>
    <carrier rdaType="other computer carrier">electronic resource</carrier>
    <carrier rdaType="other computer carrier">other computer carrier</carrier>
    <carrier rdaType="other microform carrier">other microform carrier</carrier>
    <carrier rdaType="other microscopic carrier">other microscopic carrier</carrier>
    <carrier rdaType="other projected carrier">motion picture</carrier>
    <carrier rdaType="other projected carrier">other projected carrier</carrier>
    <carrier rdaType="other stereographic carrier">other stereographic carrier</carrier>
    <carrier rdaType="other unmediated carrier">art original</carrier>
    <carrier rdaType="other unmediated carrier">art reproduction</carrier>
    <carrier rdaType="other unmediated carrier">braille</carrier>
    <carrier rdaType="other unmediated carrier">chart</carrier>
    <carrier rdaType="other unmediated carrier">collage</carrier>
    <carrier rdaType="other unmediated carrier">diagram</carrier>
    <carrier rdaType="other unmediated carrier">drawing</carrier>
    <carrier rdaType="other unmediated carrier">game</carrier>
    <carrier rdaType="other unmediated carrier">graphic</carrier>
    <carrier rdaType="other unmediated carrier">icon</carrier>
    <carrier rdaType="other unmediated carrier">large print</carrier>
    <carrier rdaType="other unmediated carrier">map</carrier>
    <carrier rdaType="other unmediated carrier">moon</carrier>
    <carrier rdaType="other unmediated carrier">non-projected graphic</carrier>
    <carrier rdaType="other unmediated carrier">nonprojected graphic</carrier>
    <carrier rdaType="other unmediated carrier">other unmediated carrier</carrier>
    <carrier rdaType="other unmediated carrier">painting</carrier>
    <carrier rdaType="other unmediated carrier">photograph</carrier>
    <carrier rdaType="other unmediated carrier">photomechanical print</carrier>
    <carrier rdaType="other unmediated carrier">photonegative</carrier>
    <carrier rdaType="other unmediated carrier">photoprint</carrier>
    <carrier rdaType="other unmediated carrier">picture</carrier>
    <carrier rdaType="other unmediated carrier">print</carrier>
    <carrier rdaType="other unmediated carrier">profile</carrier>
    <carrier rdaType="other unmediated carrier">regular print</carrier>
    <carrier rdaType="other unmediated carrier">remote-sensing image</carrier>
    <carrier rdaType="other unmediated carrier">section</carrier>
    <carrier rdaType="other unmediated carrier">study print</carrier>
    <carrier rdaType="other unmediated carrier">tactile, with no writing system</carrier>
    <carrier rdaType="other unmediated carrier">technical drawing</carrier>
    <carrier rdaType="other unmediated carrier">text in looseleaf binder</carrier>
    <carrier rdaType="other unmediated carrier">toy</carrier>
    <carrier rdaType="other unmediated carrier">view</carrier>
    <carrier rdaType="other video carrier">other video carrier</carrier>
    <carrier rdaType="overhead transparency">overhead transparency</carrier>
    <carrier rdaType="overhead transparency">transparency</carrier>
    <carrier rdaType="online resource">remote</carrier>
    <!--<carrier rdaType="remote">remote</carrier>-->
    <carrier rdaType="roll">roll</carrier>
    <carrier rdaType="sheet">radiograph</carrier>
    <carrier rdaType="sheet">sheet</carrier>
    <carrier rdaType="slide">slide</carrier>
    <carrier rdaType="sound track reel">sound track reel</carrier>
    <carrier rdaType="sound track reel">sound-tape reel</carrier>
    <carrier rdaType="sound track reel">sound-track film</carrier>
    <carrier rdaType="stereograph card">stereograph card</carrier>
    <carrier rdaType="stereograph disc">stereograph disc</carrier>
    <carrier rdaType="unspecified">kit</carrier>
    <carrier rdaType="unspecified">microform</carrier>
    <carrier rdaType="unspecified">unspecified</carrier>
    <carrier rdaType="unspecified">videorecording</carrier>
    <carrier rdaType="video cartridge">video cartridge</carrier>
    <carrier rdaType="video cartridge">videocartridge</carrier>
    <carrier rdaType="videocassette">videocassette</carrier>
    <carrier rdaType="videodisc">videodisc</carrier>
    <carrier rdaType="videotape reel">videoreel</carrier>
    <carrier rdaType="videotape reel">videotape reel</carrier>
    <carrier rdaType="volume">atlas</carrier>
    <carrier rdaType="volume">volume</carrier>
    <carrier rdaType="wire recording">wire recording</carrier>
  </xsl:variable>

  <!--<xsl:import href="marcMediaMap.xsl"/>-->
  <!-- MARC / GMD - RDA Media Map -->
  <xsl:variable name="marcMediaMap">
    <media rdaType="audio">audio</media>
    <media rdaType="audio">sound recording</media>
    <media rdaType="computer">computer</media>
    <media rdaType="computer">electronic resource</media>
    <media rdaType="computer">electronic</media>
    <media rdaType="computer">remote</media>
    <media rdaType="microform">microfiche</media>
    <media rdaType="microform">microfilm</media>
    <media rdaType="microform">microform</media>
    <media rdaType="microscopic">microscope slide</media>
    <media rdaType="microscopic">microscopic</media>
    <media rdaType="projected">filmstrip</media>
    <media rdaType="projected">motion picture</media>
    <media rdaType="projected">projected graphic</media>
    <media rdaType="projected">projected</media>
    <media rdaType="projected">slide</media>
    <media rdaType="projected">transparency</media>
    <media rdaType="stereographic">stereographic</media>
    <media rdaType="unmediated">activity card</media>
    <media rdaType="unmediated">art original</media>
    <media rdaType="unmediated">art reproduction</media>
    <media rdaType="unmediated">braille</media>
    <media rdaType="unmediated">cartographic material</media>
    <media rdaType="unmediated">chart</media>
    <media rdaType="unmediated">diorama</media>
    <media rdaType="unmediated">flash card</media>
    <media rdaType="unmediated">globe</media>
    <media rdaType="unmediated">large print</media>
    <media rdaType="unmediated">manuscript</media>
    <media rdaType="unmediated">map</media>
    <media rdaType="unmediated">model</media>
    <media rdaType="unmediated">music</media>
    <media rdaType="unmediated">nonprojected graphic</media>
    <media rdaType="unmediated">non-projected graphic</media>
    <media rdaType="unmediated">notated music</media>
    <media rdaType="unmediated">picture</media>
    <media rdaType="unmediated">print</media>
    <media rdaType="unmediated">realia</media>
    <media rdaType="unmediated">remote sensing image</media>
    <media rdaType="unmediated">tactile material</media>
    <media rdaType="unmediated">technical drawing</media>
    <media rdaType="unmediated">text</media>
    <media rdaType="unmediated">toy</media>
    <media rdaType="unmediated">unmediated</media>
    <media rdaType="unspecifed">unspecified</media>
    <media rdaType="unspecified">game</media>
    <media rdaType="unspecified">kit</media>
    <media rdaType="video">video</media>
    <media rdaType="video">videorecording</media>
  </xsl:variable>

  <!--<xsl:import href="resourcetypeMap.xsl"/>-->
  <!-- MODS typeOfResource - RDA media and carrier Map -->
  <xsl:variable name="resourceMap">
    <content resourceType="cartographic">atlas</content>
    <content resourceType="cartographic">cartographic dataset</content>
    <content resourceType="cartographic">cartographic image</content>
    <content resourceType="cartographic">cartographic moving image</content>
    <content resourceType="cartographic">cartographic tactile image</content>
    <content resourceType="cartographic">cartographic tactile three-dimensional form</content>
    <content resourceType="cartographic">cartographic three-dimensional form</content>
    <content resourceType="cartographic">cartographic</content>
    <content resourceType="cartographic">celestial globe</content>
    <content resourceType="cartographic">earth moon globe</content>
    <content resourceType="cartographic">globe</content>
    <content resourceType="cartographic">map</content>
    <content resourceType="cartographic">planetary or lunar globe</content>
    <content resourceType="cartographic">terrestrial globe</content>
    <content resourceType="mixed material">mixed material</content>
    <content resourceType="moving image">film cartridge</content>
    <content resourceType="moving image">film cassette</content>
    <content resourceType="moving image">film reel</content>
    <content resourceType="moving image">film roll</content>
    <content resourceType="moving image">filmslip</content>
    <content resourceType="moving image">filmstrip cartridge</content>
    <content resourceType="moving image">filmstrip</content>
    <content resourceType="moving image">motion picture</content>
    <content resourceType="moving image">moving image</content>
    <content resourceType="moving image">other video carrier</content>
    <content resourceType="moving image">three-dimensional moving image</content>
    <content resourceType="moving image">two-dimensional moving image</content>
    <content resourceType="moving image">video cartridge</content>
    <content resourceType="moving image">video</content>
    <content resourceType="moving image">videocartridge</content>
    <content resourceType="moving image">videocassette</content>
    <content resourceType="moving image">videodisc</content>
    <content resourceType="moving image">videorecording</content>
    <content resourceType="moving image">videoreel</content>
    <content resourceType="moving image">videotape reel</content>
    <content resourceType="notated music">notated music</content>
    <content resourceType="notated music">tactile notated music</content>
    <content resourceType="software, multimedia">computer card</content>
    <content resourceType="software, multimedia">computer chip cartridge</content>
    <content resourceType="software, multimedia">computer dataset</content>
    <content resourceType="software, multimedia">computer disc cartridge</content>
    <content resourceType="software, multimedia">computer disc</content>
    <content resourceType="software, multimedia">computer program</content>
    <content resourceType="software, multimedia">computer tape cartridge</content>
    <content resourceType="software, multimedia">computer tape cassette</content>
    <content resourceType="software, multimedia">computer tape reel</content>
    <content resourceType="software, multimedia">computer</content>
    <content resourceType="software, multimedia">electronic resource</content>
    <content resourceType="software, multimedia">electronic</content>
    <content resourceType="software, multimedia">magnetic disk</content>
    <content resourceType="software, multimedia">magneto-optical disc</content>
    <content resourceType="software, multimedia">online resource</content>
    <content resourceType="software, multimedia">optical disc</content>
    <content resourceType="software, multimedia">other computer carrier</content>
    <content resourceType="software, multimedia">remote</content>
    <content resourceType="software, multimedia">software, multimedia</content>
    <content resourceType="software, multimedia">tape cartridge</content>
    <content resourceType="software, multimedia">tape cassette</content>
    <content resourceType="software, multimedia">tape reel</content>
    <content resourceType="sound recording">audio cartridge</content>
    <content resourceType="sound recording">audio cylinder</content>
    <content resourceType="sound recording">audio disc</content>
    <content resourceType="sound recording">audio roll</content>
    <content resourceType="sound recording">audio</content>
    <content resourceType="sound recording">audiocassette</content>
    <content resourceType="sound recording">audiotape reel</content>
    <content resourceType="sound recording">cylinder</content>
    <content resourceType="sound recording">other audio carrier</content>
    <content resourceType="sound recording">sound cartridge</content>
    <content resourceType="sound recording">sound cassette</content>
    <content resourceType="sound recording">sound disc</content>
    <content resourceType="sound recording">sound recording</content>
    <content resourceType="sound recording">sound track reel</content>
    <content resourceType="sound recording">sound-tape reel</content>
    <content resourceType="sound recording">sound-track film</content>
    <content resourceType="sound recording">wire recording</content>
    <content resourceType="sound recording-musical">performed music</content>
    <content resourceType="sound recording-musical">sound recording-musical</content>
    <content resourceType="sound recording-nonmusical">sound recording-nonmusical</content>
    <content resourceType="sound recording-nonmusical">sounds</content>
    <content resourceType="sound recording-nonmusical">spoken word</content>
    <content resourceType="still image">chart</content>
    <content resourceType="still image">collage</content>
    <content resourceType="still image">diagram</content>
    <content resourceType="still image">drawing</content>
    <content resourceType="still image">microscope slide</content>
    <content resourceType="still image">non-projected graphic</content>
    <content resourceType="still image">nonprojected graphic</content>
    <content resourceType="still image">other microscopic carrier</content>
    <content resourceType="still image">overhead transparency</content>
    <content resourceType="still image">photomechanical print</content>
    <content resourceType="still image">photonegative</content>
    <content resourceType="still image">photoprint</content>
    <content resourceType="still image">picture</content>
    <content resourceType="still image">profile</content>
    <content resourceType="still image">remote sensing image</content>
    <content resourceType="still image">slide</content>
    <content resourceType="still image">stereograph card</content>
    <content resourceType="still image">stereograph disc</content>
    <content resourceType="still image">stereographic</content>
    <content resourceType="still image">still image</content>
    <content resourceType="still image">tactile image</content>
    <content resourceType="still image">technical drawing</content>
    <content resourceType="still image">transparency</content>
    <content resourceType="still image">view</content>
    <content resourceType="text">large print</content>
    <content resourceType="text">notated movement</content>
    <content resourceType="text">print</content>
    <content resourceType="text">regular print</content>
    <content resourceType="text">tactile notated movement</content>
    <content resourceType="text">tactile text</content>
    <content resourceType="text">text in looseleaf binder</content>
    <content resourceType="text">text</content>
    <content resourceType="three dimensional object">art original</content>
    <content resourceType="three dimensional object">diorama</content>
    <content resourceType="three dimensional object">flipchart</content>
    <content resourceType="three dimensional object">game</content>
    <content resourceType="three dimensional object">model</content>
    <content resourceType="three dimensional object">object</content>
    <content resourceType="three dimensional object">painting</content>
    <content resourceType="three dimensional object">realia</content>
    <content resourceType="three dimensional object">tactile three-dimensional form</content>
    <content resourceType="three dimensional object">three dimensional object</content>
    <content resourceType="three dimensional object">three-dimensional object</content>
    <content resourceType="three dimensional object">three dimensional form</content>
    <content resourceType="three dimensional object">three-dimensional form</content>
    <content resourceType="three dimensional object">toy</content>
    <content resourceType="unspecified">aperture card</content>
    <content resourceType="unspecified">art reproduction</content>
    <content resourceType="unspecified">braille</content>
    <content resourceType="unspecified">card</content>
    <content resourceType="unspecified">flash card</content>
    <content resourceType="unspecified">graphic</content>
    <content resourceType="unspecified">kit</content>
    <content resourceType="unspecified">microfiche cassette</content>
    <content resourceType="unspecified">microfiche</content>
    <content resourceType="unspecified">microfilm cartridge</content>
    <content resourceType="unspecified">microfilm cassette</content>
    <content resourceType="unspecified">microfilm reel</content>
    <content resourceType="unspecified">microfilm roll</content>
    <content resourceType="unspecified">microfilm slip</content>
    <content resourceType="unspecified">microfilm</content>
    <content resourceType="unspecified">microform</content>
    <content resourceType="unspecified">microopaque</content>
    <content resourceType="unspecified">moon</content>
    <content resourceType="unspecified">other microform carrier</content>
    <content resourceType="unspecified">other projected carrier</content>
    <content resourceType="unspecified">other stereographic carrier</content>
    <content resourceType="unspecified">other unmediated carrier</content>
    <content resourceType="unspecified">projected graphic</content>
    <content resourceType="unspecified">projected</content>
    <content resourceType="unspecified">roll</content>
    <content resourceType="unspecified">sheet</content>
    <content resourceType="unspecified">tactile material</content>
    <content resourceType="unspecified">tactile, with no writing system</content>
    <content resourceType="unspecified">unspecified</content>
    <content resourceType="unspecified">volume</content>
  </xsl:variable>

  <!--<xsl:import href="marcCountryList.xsl"/>-->
  <!-- MARC Code List for Countries, 2003 Edition [Last updated April 4, 2008] -->
  <xsl:variable name="marcCountryCodes">
    <country code="aa ">Albania</country>
    <country code="abc">Alberta</country>
    <country code="ac " status="obsolete">Ashmore and Cartier Islands</country>
    <country code="aca">Australian Capital Territory</country>
    <country code="ae ">Algeria</country>
    <country code="af ">Afghanistan</country>
    <country code="ag ">Argentina</country>
    <country code="ai " status="obsolete">Anguilla</country>
    <country code="ai ">Armenia (Republic)</country>
    <country code="air" status="obsolete">Armenian S.S.R.</country>
    <country code="aj ">Azerbaijan</country>
    <country code="ajr" status="obsolete">Azerbaijan S.S.R.</country>
    <country code="aku">Alaska</country>
    <country code="alu">Alabama</country>
    <country code="am ">Anguilla</country>
    <country code="an ">Andorra</country>
    <country code="ao ">Angola</country>
    <country code="aq ">Antigua and Barbuda</country>
    <country code="aru">Arkansas</country>
    <country code="as ">American Samoa</country>
    <country code="at ">Australia</country>
    <country code="au ">Austria</country>
    <country code="aw ">Aruba</country>
    <country code="ay ">Antarctica</country>
    <country code="azu">Arizona</country>
    <country code="ba ">Bahrain</country>
    <country code="bb ">Barbados</country>
    <country code="bcc">British Columbia</country>
    <country code="bd ">Burundi</country>
    <country code="be ">Belgium</country>
    <country code="bf ">Bahamas</country>
    <country code="bg ">Bangladesh</country>
    <country code="bh ">Belize</country>
    <country code="bi ">British Indian Ocean Territory</country>
    <country code="bl ">Brazil</country>
    <country code="bm ">Bermuda Islands</country>
    <country code="bn ">Bosnia and Herzegovina</country>
    <country code="bo ">Bolivia</country>
    <country code="bp ">Solomon Islands</country>
    <country code="br ">Burma</country>
    <country code="bs ">Botswana</country>
    <country code="bt ">Bhutan</country>
    <country code="bu ">Bulgaria</country>
    <country code="bv ">Bouvet Island</country>
    <country code="bw ">Belarus</country>
    <country code="bwr" status="obsolete">Byelorussian S.S.R.</country>
    <country code="bx ">Brunei</country>
    <country code="ca ">Caribbean Netherlands</country>
    <country code="cau">California</country>
    <country code="cb ">Cambodia</country>
    <country code="cc ">China</country>
    <country code="cd ">Chad</country>
    <country code="ce ">Sri Lanka</country>
    <country code="cf ">Congo (Brazzaville)</country>
    <country code="cg ">Congo (Democratic Republic)</country>
    <country code="ch ">China (Republic : 1949- )</country>
    <country code="ci ">Croatia</country>
    <country code="cj ">Cayman Islands</country>
    <country code="ck ">Colombia</country>
    <country code="cl ">Chile</country>
    <country code="cm ">Cameroon</country>
    <country code="cn " status="obsolete">Canada</country>
    <country code="co ">Curaçao</country>
    <country code="cou">Colorado</country>
    <country code="cp " status="obsolete">Canton and Enderbury Islands</country>
    <country code="cq ">Comoros</country>
    <country code="cr ">Costa Rica</country>
    <country code="cs " status="obsolete">Czechoslovakia</country>
    <country code="ctu">Connecticut</country>
    <country code="cu ">Cuba</country>
    <country code="cv ">Cabo Verde</country>
    <country code="cw ">Cook Islands</country>
    <country code="cx ">Central African Republic</country>
    <country code="cy ">Cyprus</country>
    <country code="cz " status="obsolete">Canal Zone</country>
    <country code="dcu">District of Columbia</country>
    <country code="deu">Delaware</country>
    <country code="dk ">Denmark</country>
    <country code="dm ">Benin</country>
    <country code="dq ">Dominica</country>
    <country code="dr ">Dominican Republic</country>
    <country code="ea ">Eritrea</country>
    <country code="ec ">Ecuador</country>
    <country code="eg ">Equatorial Guinea</country>
    <country code="em ">Timor-Leste</country>
    <country code="enk">England</country>
    <country code="er ">Estonia</country>
    <country code="err" status="obsolete">Estonia</country>
    <country code="es ">El Salvador</country>
    <country code="et ">Ethiopia</country>
    <country code="fa ">Faroe Islands</country>
    <country code="fg ">French Guiana</country>
    <country code="fi ">Finland</country>
    <country code="fj ">Fiji</country>
    <country code="fk ">Falkland Islands</country>
    <country code="flu">Florida</country>
    <country code="fm ">Micronesia (Federated States)</country>
    <country code="fp ">French Polynesia</country>
    <country code="fr ">France</country>
    <country code="fs ">Terres australes et antarctiques françaises</country>
    <country code="ft ">Djibouti</country>
    <country code="gau">Georgia</country>
    <country code="gb ">Kiribati</country>
    <country code="gd ">Grenada</country>
    <country code="ge " status="obsolete">Germany (East)</country>
    <country code="gg ">Guernsey</country>
    <country code="gh ">Ghana</country>
    <country code="gi ">Gibraltar</country>
    <country code="gl ">Greenland</country>
    <country code="gm ">Gambia</country>
    <country code="gn " status="obsolete">Gilbert and Ellice Islands</country>
    <country code="go ">Gabon</country>
    <country code="gp ">Guadeloupe</country>
    <country code="gr ">Greece</country>
    <country code="gs ">Georgia (Republic)</country>
    <country code="gsr" status="obsolete">Georgian S.S.R.</country>
    <country code="gt ">Guatemala</country>
    <country code="gu ">Guam</country>
    <country code="gv ">Guinea</country>
    <country code="gw ">Germany</country>
    <country code="gy ">Guyana</country>
    <country code="gz ">Gaza Strip</country>
    <country code="hiu">Hawaii</country>
    <country code="hk " status="obsolete">Hong Kong</country>
    <country code="hm ">Heard and McDonald Islands</country>
    <country code="ho ">Honduras</country>
    <country code="ht ">Haiti</country>
    <country code="hu ">Hungary</country>
    <country code="iau">Iowa</country>
    <country code="ic ">Iceland</country>
    <country code="idu">Idaho</country>
    <country code="ie ">Ireland</country>
    <country code="ii ">India</country>
    <country code="ilu">Illinois</country>
    <country code="im ">Isle of Man</country>
    <country code="inu">Indiana</country>
    <country code="io ">Indonesia</country>
    <country code="iq ">Iraq</country>
    <country code="ir ">Iran</country>
    <country code="is ">Israel</country>
    <country code="it ">Italy</country>
    <country code="iu " status="obsolete">Israel-Syria Demilitarized Zones</country>
    <country code="iv ">Côte d'Ivoire</country>
    <country code="iw " status="obsolete">Israel-Jordan Demilitarized Zones</country>
    <country code="iy ">Iraq-Saudi Arabia Neutral Zone</country>
    <country code="ja ">Japan</country>
    <country code="je ">Jersey</country>
    <country code="ji ">Johnston Atoll</country>
    <country code="jm ">Jamaica</country>
    <country code="jn " status="obsolete">Jan Mayen</country>
    <country code="jo ">Jordan</country>
    <country code="ke ">Kenya</country>
    <country code="kg ">Kyrgyzstan</country>
    <country code="kgr" status="obsolete">Kirghiz S.S.R.</country>
    <country code="kn ">Korea (North)</country>
    <country code="ko ">Korea (South)</country>
    <country code="ksu">Kansas</country>
    <country code="ku ">Kuwait</country>
    <country code="kv ">Kosovo</country>
    <country code="kyu">Kentucky</country>
    <country code="kz ">Kazakhstan</country>
    <country code="kzr" status="obsolete">Kazakh S.S.R.</country>
    <country code="lau">Louisiana</country>
    <country code="lb ">Liberia</country>
    <country code="le ">Lebanon</country>
    <country code="lh ">Liechtenstein</country>
    <country code="li ">Lithuania</country>
    <country code="lir" status="obsolete">Lithuania</country>
    <country code="ln " status="obsolete">Central and Southern Line Islands</country>
    <country code="lo ">Lesotho</country>
    <country code="ls ">Laos</country>
    <country code="lu ">Luxembourg</country>
    <country code="lv ">Latvia</country>
    <country code="lvr" status="obsolete">Latvia</country>
    <country code="ly ">Libya</country>
    <country code="mau">Massachusetts</country>
    <country code="mbc">Manitoba</country>
    <country code="mc ">Monaco</country>
    <country code="mdu">Maryland</country>
    <country code="meu">Maine</country>
    <country code="mf ">Mauritius</country>
    <country code="mg ">Madagascar</country>
    <country code="mh " status="obsolete">Macao</country>
    <country code="miu">Michigan</country>
    <country code="mj ">Montserrat</country>
    <country code="mk ">Oman</country>
    <country code="ml ">Mali</country>
    <country code="mm ">Malta</country>
    <country code="mnu">Minnesota</country>
    <country code="mo ">Montenegro</country>
    <country code="mou">Missouri</country>
    <country code="mp ">Mongolia</country>
    <country code="mq ">Martinique</country>
    <country code="mr ">Morocco</country>
    <country code="msu">Mississippi</country>
    <country code="mtu">Montana</country>
    <country code="mu ">Mauritania</country>
    <country code="mv ">Moldova</country>
    <country code="mvr" status="obsolete">Moldavian S.S.R.</country>
    <country code="mw ">Malawi</country>
    <country code="mx ">Mexico</country>
    <country code="my ">Malaysia</country>
    <country code="mz ">Mozambique</country>
    <country code="na " status="obsolete">Netherlands Antilles</country>
    <country code="nbu">Nebraska</country>
    <country code="ncu">North Carolina</country>
    <country code="ndu">North Dakota</country>
    <country code="ne ">Netherlands</country>
    <country code="nfc">Newfoundland and Labrador</country>
    <country code="ng ">Niger</country>
    <country code="nhu">New Hampshire</country>
    <country code="nik">Northern Ireland</country>
    <country code="nju">New Jersey</country>
    <country code="nkc">New Brunswick</country>
    <country code="nl ">New Caledonia</country>
    <country code="nm " status="obsolete">Northern Mariana Islands</country>
    <country code="nmu">New Mexico</country>
    <country code="nn ">Vanuatu</country>
    <country code="no ">Norway</country>
    <country code="np ">Nepal</country>
    <country code="nq ">Nicaragua</country>
    <country code="nr ">Nigeria</country>
    <country code="nsc">Nova Scotia</country>
    <country code="ntc">Northwest Territories</country>
    <country code="nu ">Nauru</country>
    <country code="nuc">Nunavut</country>
    <country code="nvu">Nevada</country>
    <country code="nw ">Northern Mariana Islands</country>
    <country code="nx ">Norfolk Island</country>
    <country code="nyu">New York (State)</country>
    <country code="nz ">New Zealand</country>
    <country code="ohu">Ohio</country>
    <country code="oku">Oklahoma</country>
    <country code="onc">Ontario</country>
    <country code="oru">Oregon</country>
    <country code="ot ">Mayotte</country>
    <country code="pau">Pennsylvania</country>
    <country code="pc ">Pitcairn Island</country>
    <country code="pe ">Peru</country>
    <country code="pf ">Paracel Islands</country>
    <country code="pg ">Guinea-Bissau</country>
    <country code="ph ">Philippines</country>
    <country code="pic">Prince Edward Island</country>
    <country code="pk ">Pakistan</country>
    <country code="pl ">Poland</country>
    <country code="pn ">Panama</country>
    <country code="po ">Portugal</country>
    <country code="pp ">Papua New Guinea</country>
    <country code="pr ">Puerto Rico</country>
    <country code="pt " status="obsolete">Portuguese Timor</country>
    <country code="pw ">Palau</country>
    <country code="py ">Paraguay</country>
    <country code="qa ">Qatar</country>
    <country code="qea">Queensland</country>
    <country code="quc">Québec (Province)</country>
    <country code="rb ">Serbia</country>
    <country code="re ">Réunion</country>
    <country code="rh ">Zimbabwe</country>
    <country code="riu">Rhode Island</country>
    <country code="rm ">Romania</country>
    <country code="ru ">Russia (Federation)</country>
    <country code="rur" status="obsolete">Russian S.F.S.R.</country>
    <country code="rw ">Rwanda</country>
    <country code="ry " status="obsolete">Ryukyu Islands, Southern</country>
    <country code="sa ">South Africa</country>
    <country code="sb " status="obsolete">Svalbard</country>
    <country code="sc ">Saint-Barthélemy</country>
    <country code="scu">South Carolina</country>
    <country code="sd ">South Sudan</country>
    <country code="sdu">South Dakota</country>
    <country code="se ">Seychelles</country>
    <country code="sf ">Sao Tome and Principe</country>
    <country code="sg ">Senegal</country>
    <country code="sh ">Spanish North Africa</country>
    <country code="si ">Singapore</country>
    <country code="sj ">Sudan</country>
    <country code="sk " status="obsolete">Sikkim</country>
    <country code="sl ">Sierra Leone</country>
    <country code="sm ">San Marino</country>
    <country code="sn ">Sint Maarten</country>
    <country code="snc">Saskatchewan</country>
    <country code="so ">Somalia</country>
    <country code="sp ">Spain</country>
    <country code="sq ">Eswatini</country>
    <country code="sr ">Surinam</country>
    <country code="ss ">Western Sahara</country>
    <country code="st ">Saint-Martin</country>
    <country code="stk">Scotland</country>
    <country code="su ">Saudi Arabia</country>
    <country code="sv " status="obsolete">Swan Islands</country>
    <country code="sw ">Sweden</country>
    <country code="sx ">Namibia</country>
    <country code="sy ">Syria</country>
    <country code="sz ">Switzerland</country>
    <country code="ta ">Tajikistan</country>
    <country code="tar" status="obsolete">Tajik S.S.R.</country>
    <country code="tc ">Turks and Caicos Islands</country>
    <country code="tg ">Togo</country>
    <country code="th ">Thailand</country>
    <country code="ti ">Tunisia</country>
    <country code="tk ">Turkmenistan</country>
    <country code="tkr" status="obsolete">Turkmen S.S.R.</country>
    <country code="tl ">Tokelau</country>
    <country code="tma">Tasmania</country>
    <country code="tnu">Tennessee</country>
    <country code="to ">Tonga</country>
    <country code="tr ">Trinidad and Tobago</country>
    <country code="ts ">United Arab Emirates</country>
    <country code="tt " status="obsolete">Trust Territory of the Pacific Islands</country>
    <country code="tu ">Turkey</country>
    <country code="tv ">Tuvalu</country>
    <country code="txu">Texas</country>
    <country code="tz ">Tanzania</country>
    <country code="ua ">Egypt</country>
    <country code="uc ">United States Misc. Caribbean Islands</country>
    <country code="ug ">Uganda</country>
    <country code="ui " status="obsolete">United Kingdom Misc. Islands</country>
    <country code="uik" status="obsolete">United Kingdom Misc. Islands</country>
    <country code="uk " status="obsolete">United Kingdom</country>
    <country code="un ">Ukraine</country>
    <country code="unr" status="obsolete">Ukraine</country>
    <country code="up ">United States Misc. Pacific Islands</country>
    <country code="ur " status="obsolete">Soviet Union</country>
    <country code="us " status="obsolete">United States</country>
    <country code="utu">Utah</country>
    <country code="uv ">Burkina Faso</country>
    <country code="uy ">Uruguay</country>
    <country code="uz ">Uzbekistan</country>
    <country code="uzr" status="obsolete">Uzbek S.S.R.</country>
    <country code="vau">Virginia</country>
    <country code="vb ">British Virgin Islands</country>
    <country code="vc ">Vatican City</country>
    <country code="ve ">Venezuela</country>
    <country code="vi ">Virgin Islands of the United States</country>
    <country code="vm ">Vietnam</country>
    <country code="vn " status="obsolete">Vietnam, North</country>
    <country code="vp ">Various places</country>
    <country code="vra">Victoria</country>
    <country code="vs " status="obsolete">Vietnam, South</country>
    <country code="vtu">Vermont</country>
    <country code="wau">Washington (State)</country>
    <country code="wb " status="obsolete">West Berlin</country>
    <country code="wea">Western Australia</country>
    <country code="wf ">Wallis and Futuna</country>
    <country code="wiu">Wisconsin</country>
    <country code="wj ">West Bank of the Jordan River</country>
    <country code="wk ">Wake Island</country>
    <country code="wlk">Wales</country>
    <country code="ws ">Samoa</country>
    <country code="wvu">West Virginia</country>
    <country code="wyu">Wyoming</country>
    <country code="xa ">Christmas Island (Indian Ocean)</country>
    <country code="xb ">Cocos (Keeling) Islands</country>
    <country code="xc ">Maldives</country>
    <country code="xd ">Saint Kitts-Nevis</country>
    <country code="xe ">Marshall Islands</country>
    <country code="xf ">Midway Islands</country>
    <country code="xga">Coral Sea Islands Territory</country>
    <country code="xh ">Niue</country>
    <country code="xi " status="obsolete">Saint Kitts-Nevis-Anguilla</country>
    <country code="xj ">Saint Helena</country>
    <country code="xk ">Saint Lucia</country>
    <country code="xl ">Saint Pierre and Miquelon</country>
    <country code="xm ">Saint Vincent and the Grenadines</country>
    <country code="xn ">North Macedonia</country>
    <country code="xna">New South Wales</country>
    <country code="xo ">Slovakia</country>
    <country code="xoa">Northern Territory</country>
    <country code="xp ">Spratly Island</country>
    <country code="xr ">Czech Republic</country>
    <country code="xra">South Australia</country>
    <country code="xs ">South Georgia and the South Sandwich Islands</country>
    <country code="xv ">Slovenia</country>
    <country code="xx ">No place, unknown, or undetermined</country>
    <country code="xxc">Canada</country>
    <country code="xxk">United Kingdom</country>
    <country code="xxr" status="obsolete">Soviet Union</country>
    <country code="xxu">United States</country>
    <country code="ye ">Yemen</country>
    <country code="ykc">Yukon Territory</country>
    <country code="ys " status="obsolete">Yemen (People's Democratic Republic)</country>
    <country code="yu " status="obsolete">Serbia and Montenegro</country>
    <country code="za ">Zambia</country>
  </xsl:variable>

  <!--<xsl:import href="marcGeoAreasMap.xsl"/>-->
  <!-- MARC Geographic Areas Code List, 2006 Edition, [Updated April 7, 2008] -->
  <xsl:variable name="geographicAreas">
    <geoArea code="a">Asia</geoArea>
    <geoArea code="a-af">Afghanistan</geoArea>
    <geoArea code="a-ai">Armenia (Republic)</geoArea>
    <geoArea code="a-aj">Azerbaijan</geoArea>
    <geoArea code="a-ba">Bahrain</geoArea>
    <geoArea code="a-bg">Bangladesh</geoArea>
    <geoArea code="a-bn">Borneo</geoArea>
    <geoArea code="a-br">Burma</geoArea>
    <geoArea code="a-bt">Bhutan</geoArea>
    <geoArea code="a-bx">Brunei</geoArea>
    <geoArea code="a-cb">Cambodia</geoArea>
    <geoArea code="a-cc">China</geoArea>
    <geoArea code="a-cc-an">Anhui Sheng (China)</geoArea>
    <geoArea code="a-cc-ch">Zhejiang Sheng (China)</geoArea>
    <geoArea code="a-cc-cq">Chongqing (China)</geoArea>
    <geoArea code="a-cc-fu">Fujian Sheng (China)</geoArea>
    <geoArea code="a-cc-ha">Hainan Sheng (China)</geoArea>
    <geoArea code="a-cc-he">Heilongjiang Sheng (China)</geoArea>
    <geoArea code="a-cc-hh">Hubei Sheng (China)</geoArea>
    <geoArea code="a-cc-hk">Hong Kong (China)</geoArea>
    <geoArea code="a-cc-ho">Henan Sheng (China)</geoArea>
    <geoArea code="a-cc-hp">Hebei Sheng (China)</geoArea>
    <geoArea code="a-cc-hu">Hunan Sheng (China)</geoArea>
    <geoArea code="a-cc-im">Inner Mongolia (China)</geoArea>
    <geoArea code="a-cc-ka">Gansu Sheng (China)</geoArea>
    <geoArea code="a-cc-kc">Guangxi Zhuangzu Zizhiqu (China)</geoArea>
    <geoArea code="a-cc-ki">Jiangxi Sheng (China)</geoArea>
    <geoArea code="a-cc-kn">Guangdong Sheng (China)</geoArea>
    <geoArea code="a-cc-kr">Jilin Sheng (China)</geoArea>
    <geoArea code="a-cc-ku">Jiangsu Sheng (China)</geoArea>
    <geoArea code="a-cc-kw">Guizhou Sheng (China)</geoArea>
    <geoArea code="a-cc-lp">Liaoning Sheng (China)</geoArea>
    <geoArea code="a-cc-mh">Macau (China : Special Administrative Region)</geoArea>
    <geoArea code="a-cc-nn">Ningxia Huizu Zizhiqu (China)</geoArea>
    <geoArea code="a-cc-pe">Beijing (China)</geoArea>
    <geoArea code="a-cc-sh">Shanxi Sheng (China)</geoArea>
    <geoArea code="a-cc-sm">Shanghai (China)</geoArea>
    <geoArea code="a-cc-sp">Shandong Sheng (China)</geoArea>
    <geoArea code="a-cc-ss">Shaanxi Sheng (China)</geoArea>
    <geoArea code="a-cc-su">Xinjiang Uygur Zizhiqu (China)</geoArea>
    <geoArea code="a-cc-sz">Sichuan Sheng (China)</geoArea>
    <geoArea code="a-cc-ti">Tibet (China)</geoArea>
    <geoArea code="a-cc-tn">Tianjin (China)</geoArea>
    <geoArea code="a-cc-ts">Qinghai Sheng (China)</geoArea>
    <geoArea code="a-cc-yu">Yunnan Sheng (China)</geoArea>
    <geoArea code="a-ccg">Yangtze River (China)</geoArea>
    <geoArea code="a-cck">Kunlun Mountains (China and India)</geoArea>
    <geoArea code="a-ccp">Bo Hai (China)</geoArea>
    <geoArea code="a-ccs">Xi River (China)</geoArea>
    <geoArea code="a-ccy">Yellow River (China)</geoArea>
    <geoArea code="a-ce">Sri Lanka</geoArea>
    <geoArea code="a-ch">Taiwan</geoArea>
    <geoArea code="a-cy">Cyprus</geoArea>
    <geoArea code="a-em">Timor-Leste</geoArea>
    <geoArea code="a-gs">Georgia (Republic)</geoArea>
    <geoArea code="a-hk" status="obsolete">Hong Kong</geoArea>
    <geoArea code="a-ii">India</geoArea>
    <geoArea code="a-io">Indonesia</geoArea>
    <geoArea code="a-iq">Iraq</geoArea>
    <geoArea code="a-ir">Iran</geoArea>
    <geoArea code="a-is">Israel</geoArea>
    <geoArea code="a-ja">Japan</geoArea>
    <geoArea code="a-jo">Jordan</geoArea>
    <geoArea code="a-kg">Kyrgyzstan</geoArea>
    <geoArea code="a-kn">Korea (North)</geoArea>
    <geoArea code="a-ko">Korea (South)</geoArea>
    <geoArea code="a-kr">Korea</geoArea>
    <geoArea code="a-ku">Kuwait</geoArea>
    <geoArea code="a-kz">Kazakhstan</geoArea>
    <geoArea code="a-le">Lebanon</geoArea>
    <geoArea code="a-ls">Laos</geoArea>
    <geoArea code="a-mh" status="obsolete">Macao</geoArea>
    <geoArea code="a-mk">Oman</geoArea>
    <geoArea code="a-mp">Mongolia</geoArea>
    <geoArea code="a-my">Malaysia</geoArea>
    <geoArea code="a-np">Nepal</geoArea>
    <geoArea code="a-nw">New Guinea</geoArea>
    <geoArea code="a-ok" status="obsolete">Okinawa</geoArea>
    <geoArea code="a-ph">Philippines</geoArea>
    <geoArea code="a-pk">Pakistan</geoArea>
    <geoArea code="a-pp">Papua New Guinea</geoArea>
    <geoArea code="a-pt" status="obsolete">Portuguese Timor</geoArea>
    <geoArea code="a-qa">Qatar</geoArea>
    <geoArea code="a-si">Singapore</geoArea>
    <geoArea code="a-sk" status="obsolete">Sikkim</geoArea>
    <geoArea code="a-su">Saudi Arabia</geoArea>
    <geoArea code="a-sy">Syria</geoArea>
    <geoArea code="a-ta">Tajikistan</geoArea>
    <geoArea code="a-th">Thailand</geoArea>
    <geoArea code="a-tk">Turkmenistan</geoArea>
    <geoArea code="a-ts">United Arab Emirates</geoArea>
    <geoArea code="a-tu">Turkey</geoArea>
    <geoArea code="a-uz">Uzbekistan</geoArea>
    <geoArea code="a-vn" status="obsolete">Viet Nam, North</geoArea>
    <geoArea code="a-vs" status="obsolete">Viet Nam, South</geoArea>
    <geoArea code="a-vt">Vietnam</geoArea>
    <geoArea code="a-ye">Yemen (Republic)</geoArea>
    <geoArea code="a-ys" status="obsolete">Yemen (People's Democratic Republic)</geoArea>
    <geoArea code="aa">Amur River (China and Russia)</geoArea>
    <geoArea code="ab">Bengal, Bay of</geoArea>
    <geoArea code="ac">Asia, Central</geoArea>
    <geoArea code="ae">East Asia</geoArea>
    <geoArea code="af">Thailand, Gulf of</geoArea>
    <geoArea code="ag">Mekong River</geoArea>
    <geoArea code="ah">Himalaya Mountains</geoArea>
    <geoArea code="ai">Indochina</geoArea>
    <geoArea code="ak">Caspian Sea</geoArea>
    <geoArea code="am">Malaya</geoArea>
    <geoArea code="an">East China Sea</geoArea>
    <geoArea code="ao">South China Sea</geoArea>
    <geoArea code="aopf">Paracel Islands</geoArea>
    <geoArea code="aoxp">Spratly Islands</geoArea>
    <geoArea code="ap">Persian Gulf</geoArea>
    <geoArea code="ar">Arabian Peninsula</geoArea>
    <geoArea code="as">Southeast Asia</geoArea>
    <geoArea code="at">Tien Shan</geoArea>
    <geoArea code="au">Arabian Sea</geoArea>
    <geoArea code="aw">Middle East</geoArea>
    <geoArea code="awba">West Bank</geoArea>
    <geoArea code="awgz">Gaza Strip</geoArea>
    <geoArea code="awiu" status="obsolete">Israel-Syria Demilitarized Zones</geoArea>
    <geoArea code="awiw" status="obsolete">Israel-Jordan Demilitarized Zones</geoArea>
    <geoArea code="awiy" status="obsolete">Iraq-Saudi Arabia Neutral Zone</geoArea>
    <geoArea code="ay">Yellow Sea</geoArea>
    <geoArea code="az">South Asia</geoArea>
    <geoArea code="b">Commonwealth countries</geoArea>
    <geoArea code="c">Intercontinental areas (Western Hemisphere)</geoArea>
    <geoArea code="cc">Caribbean Area; Caribbean Sea</geoArea>
    <geoArea code="cl">Latin America</geoArea>
    <geoArea code="cm" status="obsolete">Middle America</geoArea>
    <geoArea code="cr" status="obsolete">Circumcaribbean</geoArea>
    <geoArea code="d">Developing countries</geoArea>
    <geoArea code="dd">Developed countries</geoArea>
    <geoArea code="e">Europe</geoArea>
    <geoArea code="e-aa">Albania</geoArea>
    <geoArea code="e-an">Andorra</geoArea>
    <geoArea code="e-au">Austria</geoArea>
    <geoArea code="e-be">Belgium</geoArea>
    <geoArea code="e-bn">Bosnia and Herzegovina</geoArea>
    <geoArea code="e-bu">Bulgaria</geoArea>
    <geoArea code="e-bw">Belarus</geoArea>
    <geoArea code="e-ci">Croatia</geoArea>
    <geoArea code="e-cs">Czechoslovakia</geoArea>
    <geoArea code="e-dk">Denmark</geoArea>
    <geoArea code="e-er">Estonia</geoArea>
    <geoArea code="e-fi">Finland</geoArea>
    <geoArea code="e-fr">France</geoArea>
    <geoArea code="e-ge">Germany (East)</geoArea>
    <geoArea code="e-gg">Guernsey</geoArea>
    <geoArea code="e-gi">Gibraltar</geoArea>
    <geoArea code="e-gr">Greece</geoArea>
    <geoArea code="e-gw">Germany (West)</geoArea>
    <geoArea code="e-gx">Germany</geoArea>
    <geoArea code="e-hu">Hungary</geoArea>
    <geoArea code="e-ic">Iceland</geoArea>
    <geoArea code="e-ie">Ireland</geoArea>
    <geoArea code="e-im">Isle of Man</geoArea>
    <geoArea code="e-it">Italy</geoArea>
    <geoArea code="e-je">Jersey</geoArea>
    <geoArea code="e-kv">Kosovo</geoArea>
    <geoArea code="e-lh">Liechtenstein</geoArea>
    <geoArea code="e-li">Lithuania</geoArea>
    <geoArea code="e-lu">Luxembourg</geoArea>
    <geoArea code="e-lv">Latvia</geoArea>
    <geoArea code="e-mc">Monaco</geoArea>
    <geoArea code="e-mm">Malta</geoArea>
    <geoArea code="e-mo">Montenegro</geoArea>
    <geoArea code="e-mv">Moldova</geoArea>
    <geoArea code="e-ne">Netherlands</geoArea>
    <geoArea code="e-no">Norway</geoArea>
    <geoArea code="e-pl">Poland</geoArea>
    <geoArea code="e-po">Portugal</geoArea>
    <geoArea code="e-rb">Serbia</geoArea>
    <geoArea code="e-rm">Romania</geoArea>
    <geoArea code="e-ru">Russia (Federation)</geoArea>
    <geoArea code="e-sm">San Marino</geoArea>
    <geoArea code="e-sp">Spain</geoArea>
    <geoArea code="e-sw">Sweden</geoArea>
    <geoArea code="e-sz">Switzerland</geoArea>
    <geoArea code="e-uk">Great Britain</geoArea>
    <geoArea code="e-uk-en">England</geoArea>
    <geoArea code="e-uk-ni">Northern Ireland</geoArea>
    <geoArea code="e-uk-st">Scotland</geoArea>
    <geoArea code="e-uk-ui" status="obsolete">Great Britain Miscellaneous Island
      Dependencies</geoArea>
    <geoArea code="e-uk-wl">Wales</geoArea>
    <geoArea code="e-un">Ukraine</geoArea>
    <geoArea code="e-ur">Russia. Russian Empire. Soviet Union. Former Soviet Republics</geoArea>
    <geoArea code="e-ur-ai" status="obsolete">Armenia (Republic)</geoArea>
    <geoArea code="e-ur-aj" status="obsolete">Azerbaijan</geoArea>
    <geoArea code="e-ur-bw" status="obsolete">Belarus</geoArea>
    <geoArea code="e-ur-er" status="obsolete">Estonia</geoArea>
    <geoArea code="e-ur-gs" status="obsolete">Georgia (Republic)</geoArea>
    <geoArea code="e-ur-kg" status="obsolete">Kyrgyzstan</geoArea>
    <geoArea code="e-ur-kz" status="obsolete">Kazakhstan</geoArea>
    <geoArea code="e-ur-li" status="obsolete">Lithuania</geoArea>
    <geoArea code="e-ur-lv" status="obsolete">Latvia</geoArea>
    <geoArea code="e-ur-mv" status="obsolete">Moldova</geoArea>
    <geoArea code="e-ur-ru" status="obsolete">Russia (Federation)</geoArea>
    <geoArea code="e-ur-ta" status="obsolete">Tajikistan</geoArea>
    <geoArea code="e-ur-tk" status="obsolete">Turkmenistan</geoArea>
    <geoArea code="e-ur-un" status="obsolete">Ukraine</geoArea>
    <geoArea code="e-ur-uz" status="obsolete">Uzbekistan</geoArea>
    <geoArea code="e-urc">Central Chernozem Region (Russia)</geoArea>
    <geoArea code="e-ure">Siberia, Eastern (Russia)</geoArea>
    <geoArea code="e-urf">Russian Far East (Russia)</geoArea>
    <geoArea code="e-urk">Caucasus</geoArea>
    <geoArea code="e-url" status="obsolete">Central Region, RSFSR</geoArea>
    <geoArea code="e-urn">Soviet Union, Northwestern</geoArea>
    <geoArea code="e-uro" status="obsolete">Soviet Central Asia</geoArea>
    <geoArea code="e-urp">Volga River (Russia)</geoArea>
    <geoArea code="e-urr">Caucasus, Northern (Russia)</geoArea>
    <geoArea code="e-urs">Siberia (Russia)</geoArea>
    <geoArea code="e-uru">Ural Mountains (Russia)</geoArea>
    <geoArea code="e-urv" status="obsolete">Volgo-Viatskii Region, RSFSR</geoArea>
    <geoArea code="e-urw">Siberia, Western (Russia)</geoArea>
    <geoArea code="e-vc">Vatican City</geoArea>
    <geoArea code="e-xn">North Macedonia</geoArea>
    <geoArea code="e-xo">Slovakia</geoArea>
    <geoArea code="e-xr">Czech Republic</geoArea>
    <geoArea code="e-xv">Slovenia</geoArea>
    <geoArea code="e-yu">Serbia and Montenegro; Yugoslavia</geoArea>
    <geoArea code="ea">Alps</geoArea>
    <geoArea code="eb">Baltic States</geoArea>
    <geoArea code="ec">Europe, Central</geoArea>
    <geoArea code="ed">Balkan Peninsula</geoArea>
    <geoArea code="ee">Europe, Eastern</geoArea>
    <geoArea code="ei" status="obsolete">Iberian Peninsula</geoArea>
    <geoArea code="el">Benelux countries</geoArea>
    <geoArea code="en">Europe, Northern</geoArea>
    <geoArea code="eo">Danube River</geoArea>
    <geoArea code="ep">Pyrenees</geoArea>
    <geoArea code="er">Rhine River</geoArea>
    <geoArea code="es">Europe, Southern</geoArea>
    <geoArea code="et" status="obsolete">Europe, East Central</geoArea>
    <geoArea code="ev">Scandinavia</geoArea>
    <geoArea code="ew">Europe, Western</geoArea>
    <geoArea code="f">Africa</geoArea>
    <geoArea code="f-ae">Algeria</geoArea>
    <geoArea code="f-ao">Angola</geoArea>
    <geoArea code="f-bd">Burundi</geoArea>
    <geoArea code="f-bs">Botswana</geoArea>
    <geoArea code="f-by" status="obsolete">Biafra</geoArea>
    <geoArea code="f-cd">Chad</geoArea>
    <geoArea code="f-cf">Congo (Brazzaville)</geoArea>
    <geoArea code="f-cg">Congo (Democratic Republic)</geoArea>
    <geoArea code="f-cm">Cameroon</geoArea>
    <geoArea code="f-cx">Central African Republic</geoArea>
    <geoArea code="f-dm">Benin</geoArea>
    <geoArea code="f-ea">Eritrea</geoArea>
    <geoArea code="f-eg">Equatorial Guinea</geoArea>
    <geoArea code="f-et">Ethiopia</geoArea>
    <geoArea code="f-ft">Djibouti</geoArea>
    <geoArea code="f-gh">Ghana</geoArea>
    <geoArea code="f-gm">Gambia</geoArea>
    <geoArea code="f-go">Gabon</geoArea>
    <geoArea code="f-gv">Guinea</geoArea>
    <geoArea code="f-if" status="obsolete">Ifni</geoArea>
    <geoArea code="f-iv">Côte d'Ivoire</geoArea>
    <geoArea code="f-ke">Kenya</geoArea>
    <geoArea code="f-lb">Liberia</geoArea>
    <geoArea code="f-lo">Lesotho</geoArea>
    <geoArea code="f-ly">Libya</geoArea>
    <geoArea code="f-mg">Madagascar</geoArea>
    <geoArea code="f-ml">Mali</geoArea>
    <geoArea code="f-mr">Morocco</geoArea>
    <geoArea code="f-mu">Mauritania</geoArea>
    <geoArea code="f-mw">Malawi</geoArea>
    <geoArea code="f-mz">Mozambique</geoArea>
    <geoArea code="f-ng">Niger</geoArea>
    <geoArea code="f-nr">Nigeria</geoArea>
    <geoArea code="f-pg">Guinea-Bissau</geoArea>
    <geoArea code="f-rh">Zimbabwe</geoArea>
    <geoArea code="f-rw">Rwanda</geoArea>
    <geoArea code="f-sa">South Africa</geoArea>
    <geoArea code="f-sd">South Sudan</geoArea>
    <geoArea code="f-sf">Sao Tome and Principe</geoArea>
    <geoArea code="f-sg">Senegal</geoArea>
    <geoArea code="f-sh">Spanish North Africa</geoArea>
    <geoArea code="f-sj">Sudan</geoArea>
    <geoArea code="f-sl">Sierra Leone</geoArea>
    <geoArea code="f-so">Somalia</geoArea>
    <geoArea code="f-sq">Eswatini</geoArea>
    <geoArea code="f-ss">Western Sahara</geoArea>
    <geoArea code="f-sx">Namibia</geoArea>
    <geoArea code="f-tg">Togo</geoArea>
    <geoArea code="f-ti">Tunisia</geoArea>
    <geoArea code="f-tz">Tanzania</geoArea>
    <geoArea code="f-ua">Egypt</geoArea>
    <geoArea code="f-ug">Uganda</geoArea>
    <geoArea code="f-uv">Burkina Faso</geoArea>
    <geoArea code="f-za">Zambia</geoArea>
    <geoArea code="fa">Atlas Mountains</geoArea>
    <geoArea code="fb">Africa, Sub-Saharan</geoArea>
    <geoArea code="fc">Africa, Central</geoArea>
    <geoArea code="fd">Sahara</geoArea>
    <geoArea code="fe">Africa, Eastern</geoArea>
    <geoArea code="ff">Africa, North</geoArea>
    <geoArea code="fg">Congo River</geoArea>
    <geoArea code="fh">Africa, Northeast</geoArea>
    <geoArea code="fi">Niger River</geoArea>
    <geoArea code="fl">Nile River</geoArea>
    <geoArea code="fn">Sudan (Region)</geoArea>
    <geoArea code="fq">Africa, French-speaking Equatorial</geoArea>
    <geoArea code="fr">Great Rift Valley</geoArea>
    <geoArea code="fs">Africa, Southern</geoArea>
    <geoArea code="fu">Suez Canal (Egypt)</geoArea>
    <geoArea code="fv">Volta River (Ghana)</geoArea>
    <geoArea code="fw">Africa, West</geoArea>
    <geoArea code="fz">Zambezi River</geoArea>
    <geoArea code="h">French Community</geoArea>
    <geoArea code="i">Indian Ocean</geoArea>
    <geoArea code="i-bi">British Indian Ocean Territory</geoArea>
    <geoArea code="i-cq">Comoros</geoArea>
    <geoArea code="i-fs">Terres australes et antarctiques françaises</geoArea>
    <geoArea code="i-hm">Heard and McDonald Islands</geoArea>
    <geoArea code="i-mf">Mauritius</geoArea>
    <geoArea code="i-my">Mayotte</geoArea>
    <geoArea code="i-re">Réunion</geoArea>
    <geoArea code="i-se">Seychelles</geoArea>
    <geoArea code="i-xa">Christmas Island (Indian Ocean)</geoArea>
    <geoArea code="i-xb">Cocos (Keeling) Islands</geoArea>
    <geoArea code="i-xc">Maldives</geoArea>
    <geoArea code="i-xo" status="obsolete">Socotra Island</geoArea>
    <geoArea code="l">Atlantic Ocean</geoArea>
    <geoArea code="ln">North Atlantic Ocean</geoArea>
    <geoArea code="lnaz">Azores</geoArea>
    <geoArea code="lnbm">Bermuda Islands</geoArea>
    <geoArea code="lnca">Canary Islands</geoArea>
    <geoArea code="lncv">Cabo Verde</geoArea>
    <geoArea code="lnfa">Faroe Islands</geoArea>
    <geoArea code="lnjn">Jan Mayen Island</geoArea>
    <geoArea code="lnma">Madeira Islands</geoArea>
    <geoArea code="lnsb">Svalbard (Norway)</geoArea>
    <geoArea code="ls">South Atlantic Ocean</geoArea>
    <geoArea code="lsai">Ascension Island (Atlantic Ocean)</geoArea>
    <geoArea code="lsbv">Bouvet Island</geoArea>
    <geoArea code="lsfk">Falkland Islands</geoArea>
    <geoArea code="lstd">Tristan da Cunha</geoArea>
    <geoArea code="lsxj">Saint Helena</geoArea>
    <geoArea code="lsxs">South Georgia and South Sandwich Islands</geoArea>
    <geoArea code="m">Intercontinental areas (Eastern Hemisphere)</geoArea>
    <geoArea code="ma">Arab countries</geoArea>
    <geoArea code="mb">Black Sea</geoArea>
    <geoArea code="me">Eurasia</geoArea>
    <geoArea code="mm">Mediterranean Region; Mediterranean Sea</geoArea>
    <geoArea code="mr">Red Sea</geoArea>
    <geoArea code="n">North America</geoArea>
    <geoArea code="n-cn">Canada</geoArea>
    <geoArea code="n-cn-ab">Alberta</geoArea>
    <geoArea code="n-cn-bc">British Columbia</geoArea>
    <geoArea code="n-cn-mb">Manitoba</geoArea>
    <geoArea code="n-cn-nf">Newfoundland and Labrador</geoArea>
    <geoArea code="n-cn-nk">New Brunswick</geoArea>
    <geoArea code="n-cn-ns">Nova Scotia</geoArea>
    <geoArea code="n-cn-nt">Northwest Territories</geoArea>
    <geoArea code="n-cn-nu">Nunavut</geoArea>
    <geoArea code="n-cn-on">Ontario</geoArea>
    <geoArea code="n-cn-pi">Prince Edward Island</geoArea>
    <geoArea code="n-cn-qu">Québec (Province)</geoArea>
    <geoArea code="n-cn-sn">Saskatchewan</geoArea>
    <geoArea code="n-cn-yk">Yukon Territory</geoArea>
    <geoArea code="n-cnh">Hudson Bay</geoArea>
    <geoArea code="n-cnm">Maritime Provinces</geoArea>
    <geoArea code="n-cnp">Prairie Provinces</geoArea>
    <geoArea code="n-gl">Greenland</geoArea>
    <geoArea code="n-mx">Mexico</geoArea>
    <geoArea code="n-us">United States</geoArea>
    <geoArea code="n-us-ak">Alaska</geoArea>
    <geoArea code="n-us-al">Alabama</geoArea>
    <geoArea code="n-us-ar">Arkansas</geoArea>
    <geoArea code="n-us-az">Arizona</geoArea>
    <geoArea code="n-us-ca">California</geoArea>
    <geoArea code="n-us-co">Colorado</geoArea>
    <geoArea code="n-us-ct">Connecticut</geoArea>
    <geoArea code="n-us-dc">Washington (D.C.)</geoArea>
    <geoArea code="n-us-de">Delaware</geoArea>
    <geoArea code="n-us-fl">Florida</geoArea>
    <geoArea code="n-us-ga">Georgia</geoArea>
    <geoArea code="n-us-hi">Hawaii</geoArea>
    <geoArea code="n-us-ia">Iowa</geoArea>
    <geoArea code="n-us-id">Idaho</geoArea>
    <geoArea code="n-us-il">Illinois</geoArea>
    <geoArea code="n-us-in">Indiana</geoArea>
    <geoArea code="n-us-ks">Kansas</geoArea>
    <geoArea code="n-us-ky">Kentucky</geoArea>
    <geoArea code="n-us-la">Louisiana</geoArea>
    <geoArea code="n-us-ma">Massachusetts</geoArea>
    <geoArea code="n-us-md">Maryland</geoArea>
    <geoArea code="n-us-me">Maine</geoArea>
    <geoArea code="n-us-mi">Michigan</geoArea>
    <geoArea code="n-us-mn">Minnesota</geoArea>
    <geoArea code="n-us-mo">Missouri</geoArea>
    <geoArea code="n-us-ms">Mississippi</geoArea>
    <geoArea code="n-us-mt">Montana</geoArea>
    <geoArea code="n-us-nb">Nebraska</geoArea>
    <geoArea code="n-us-nc">North Carolina</geoArea>
    <geoArea code="n-us-nd">North Dakota</geoArea>
    <geoArea code="n-us-nh">New Hampshire</geoArea>
    <geoArea code="n-us-nj">New Jersey</geoArea>
    <geoArea code="n-us-nm">New Mexico</geoArea>
    <geoArea code="n-us-nv">Nevada</geoArea>
    <geoArea code="n-us-ny">New York</geoArea>
    <geoArea code="n-us-oh">Ohio</geoArea>
    <geoArea code="n-us-ok">Oklahoma</geoArea>
    <geoArea code="n-us-or">Oregon</geoArea>
    <geoArea code="n-us-pa">Pennsylvania</geoArea>
    <geoArea code="n-us-ri">Rhode Island</geoArea>
    <geoArea code="n-us-sc">South Carolina</geoArea>
    <geoArea code="n-us-sd">South Dakota</geoArea>
    <geoArea code="n-us-tn">Tennessee</geoArea>
    <geoArea code="n-us-tx">Texas</geoArea>
    <geoArea code="n-us-ut">Utah</geoArea>
    <geoArea code="n-us-va">Virginia</geoArea>
    <geoArea code="n-us-vt">Vermont</geoArea>
    <geoArea code="n-us-wa">Washington (State)</geoArea>
    <geoArea code="n-us-wi">Wisconsin</geoArea>
    <geoArea code="n-us-wv">West Virginia</geoArea>
    <geoArea code="n-us-wy">Wyoming</geoArea>
    <geoArea code="n-usa">Appalachian Mountains</geoArea>
    <geoArea code="n-usc">Middle West</geoArea>
    <geoArea code="n-use">Northeastern States</geoArea>
    <geoArea code="n-usl">Middle Atlantic States</geoArea>
    <geoArea code="n-usm">Mississippi River</geoArea>
    <geoArea code="n-usn">New England</geoArea>
    <geoArea code="n-uso">Ohio River</geoArea>
    <geoArea code="n-usp">West (U.S.)</geoArea>
    <geoArea code="n-usr">East (U.S.)</geoArea>
    <geoArea code="n-uss">Missouri River</geoArea>
    <geoArea code="n-ust">Southwest, New</geoArea>
    <geoArea code="n-usu">Southern States</geoArea>
    <geoArea code="n-usw" status="obsolete">Northwest (U.S.)</geoArea>
    <geoArea code="n-xl">Saint Pierre and Miquelon</geoArea>
    <geoArea code="nc">Central America</geoArea>
    <geoArea code="ncbh">Belize</geoArea>
    <geoArea code="nccr">Costa Rica</geoArea>
    <geoArea code="nccz">Canal Zone</geoArea>
    <geoArea code="nces">El Salvador</geoArea>
    <geoArea code="ncgt">Guatemala</geoArea>
    <geoArea code="ncho">Honduras</geoArea>
    <geoArea code="ncnq">Nicaragua</geoArea>
    <geoArea code="ncpn">Panama</geoArea>
    <geoArea code="nl">Great Lakes (North America); Lake States</geoArea>
    <geoArea code="nm">Mexico, Gulf of</geoArea>
    <geoArea code="np">Great Plains</geoArea>
    <geoArea code="nr">Rocky Mountains</geoArea>
    <geoArea code="nw">West Indies</geoArea>
    <geoArea code="nwaq">Antigua and Barbuda</geoArea>
    <geoArea code="nwaw">Aruba</geoArea>
    <geoArea code="nwbb">Barbados</geoArea>
    <geoArea code="nwbc" status="obsolete">Barbuda</geoArea>
    <geoArea code="nwbf">Bahamas</geoArea>
    <geoArea code="nwbn">Bonaire</geoArea>
    <geoArea code="nwcj">Cayman Islands</geoArea>
    <geoArea code="nwco">Curaçao</geoArea>
    <geoArea code="nwcu">Cuba</geoArea>
    <geoArea code="nwdq">Dominica</geoArea>
    <geoArea code="nwdr">Dominican Republic</geoArea>
    <geoArea code="nweu">Sint Eustatius</geoArea>
    <geoArea code="nwga" status="obsolete">Greater Antilles</geoArea>
    <geoArea code="nwgd">Grenada</geoArea>
    <geoArea code="nwgp">Guadeloupe</geoArea>
    <geoArea code="nwgs" status="obsolete">Grenadines</geoArea>
    <geoArea code="nwhi">Hispaniola</geoArea>
    <geoArea code="nwht">Haiti</geoArea>
    <geoArea code="nwjm">Jamaica</geoArea>
    <geoArea code="nwla">Antilles, Lesser</geoArea>
    <geoArea code="nwli">Leeward Islands (West Indies)</geoArea>
    <geoArea code="nwmj">Montserrat</geoArea>
    <geoArea code="nwmq">Martinique</geoArea>
    <geoArea code="nwna" status="obsolete">Netherlands Antilles</geoArea>
    <geoArea code="nwpr">Puerto Rico</geoArea>
    <geoArea code="nwsb" status="obsolete">Saint-Barthélemy</geoArea>
    <geoArea code="nwsc">Saint-Barthélemy</geoArea>
    <geoArea code="nwsd">Saba</geoArea>
    <geoArea code="nwsn">Sint Maarten</geoArea>
    <geoArea code="nwst">Saint-Martin</geoArea>
    <geoArea code="nwsv">Swan Islands (Honduras)</geoArea>
    <geoArea code="nwtc">Turks and Caicos Islands</geoArea>
    <geoArea code="nwtr">Trinidad and Tobago</geoArea>
    <geoArea code="nwuc">United States Miscellaneous Caribbean Islands</geoArea>
    <geoArea code="nwvb">British Virgin Islands</geoArea>
    <geoArea code="nwvi">Virgin Islands of the United States</geoArea>
    <geoArea code="nwvr" status="obsolete">Virgin Islands</geoArea>
    <geoArea code="nwwi">Windward Islands (West Indies)</geoArea>
    <geoArea code="nwxa">Anguilla</geoArea>
    <geoArea code="nwxi">Saint Kitts and Nevis</geoArea>
    <geoArea code="nwxk">Saint Lucia</geoArea>
    <geoArea code="nwxm">Saint Vincent and the Grenadines</geoArea>
    <geoArea code="p">Pacific Ocean</geoArea>
    <geoArea code="pn">North Pacific Ocean</geoArea>
    <geoArea code="po">Oceania</geoArea>
    <geoArea code="poas">American Samoa</geoArea>
    <geoArea code="pobp">Solomon Islands</geoArea>
    <geoArea code="poci">Caroline Islands</geoArea>
    <geoArea code="pocp" status="obsolete">Canton and Enderbury Islands</geoArea>
    <geoArea code="pocw">Cook Islands</geoArea>
    <geoArea code="poea">Easter Island</geoArea>
    <geoArea code="pofj">Fiji</geoArea>
    <geoArea code="pofp">French Polynesia</geoArea>
    <geoArea code="pogg">Galapagos Islands</geoArea>
    <geoArea code="pogn" status="obsolete">Gilbert and Ellice Islands</geoArea>
    <geoArea code="pogu">Guam</geoArea>
    <geoArea code="poji">Johnston Island</geoArea>
    <geoArea code="pokb">Kiribati</geoArea>
    <geoArea code="poki">Kermadec Islands</geoArea>
    <geoArea code="poln">Line Islands</geoArea>
    <geoArea code="pome">Melanesia</geoArea>
    <geoArea code="pomi">Micronesia (Federated States)</geoArea>
    <geoArea code="ponl">New Caledonia</geoArea>
    <geoArea code="ponn">Vanuatu</geoArea>
    <geoArea code="ponu">Nauru</geoArea>
    <geoArea code="popc">Pitcairn Island</geoArea>
    <geoArea code="popl">Palau</geoArea>
    <geoArea code="pops">Polynesia</geoArea>
    <geoArea code="pory" status="obsolete">Ryukyu Islands, Southern</geoArea>
    <geoArea code="posc" status="obsolete">Santa Cruz Islands</geoArea>
    <geoArea code="posh">Samoan Islands</geoArea>
    <geoArea code="posn" status="obsolete">Solomon Islands</geoArea>
    <geoArea code="potl">Tokelau</geoArea>
    <geoArea code="poto">Tonga</geoArea>
    <geoArea code="pott">Micronesia</geoArea>
    <geoArea code="potv">Tuvalu</geoArea>
    <geoArea code="poup">United States Miscellaneous Pacific Islands</geoArea>
    <geoArea code="powf">Wallis and Futuna Islands</geoArea>
    <geoArea code="powk">Wake Island</geoArea>
    <geoArea code="pows">Samoa</geoArea>
    <geoArea code="poxd">Mariana Islands</geoArea>
    <geoArea code="poxe">Marshall Islands</geoArea>
    <geoArea code="poxf">Midway Islands</geoArea>
    <geoArea code="poxh">Niue</geoArea>
    <geoArea code="ps">South Pacific Ocean</geoArea>
    <geoArea code="q">Cold regions</geoArea>
    <geoArea code="r">Arctic Ocean; Arctic regions</geoArea>
    <geoArea code="s">South America</geoArea>
    <geoArea code="s-ag">Argentina</geoArea>
    <geoArea code="s-bl">Brazil</geoArea>
    <geoArea code="s-bo">Bolivia</geoArea>
    <geoArea code="s-ck">Colombia</geoArea>
    <geoArea code="s-cl">Chile</geoArea>
    <geoArea code="s-ec">Ecuador</geoArea>
    <geoArea code="s-fg">French Guiana</geoArea>
    <geoArea code="s-gy">Guyana</geoArea>
    <geoArea code="s-pe">Peru</geoArea>
    <geoArea code="s-py">Paraguay</geoArea>
    <geoArea code="s-sr">Suriname</geoArea>
    <geoArea code="s-uy">Uruguay</geoArea>
    <geoArea code="s-ve">Venezuela</geoArea>
    <geoArea code="sa">Amazon River</geoArea>
    <geoArea code="sn">Andes</geoArea>
    <geoArea code="sp">Rio de la Plata (Argentina and Uruguay)</geoArea>
    <geoArea code="t">Antarctic Ocean; Antarctica</geoArea>
    <geoArea code="t-ay" status="obsolete">Antarctica</geoArea>
    <geoArea code="u">Australasia</geoArea>
    <geoArea code="u-ac">Ashmore and Cartier Islands</geoArea>
    <geoArea code="u-at">Australia</geoArea>
    <geoArea code="u-at-ac">Australian Capital Territory</geoArea>
    <geoArea code="u-atc">Central Australia</geoArea>
    <geoArea code="u-ate">Eastern Australia</geoArea>
    <geoArea code="u-atn">Northern Australia</geoArea>
    <geoArea code="u-at-ne">New South Wales</geoArea>
    <geoArea code="u-at-no">Northern Territory</geoArea>
    <geoArea code="u-at-qn">Queensland</geoArea>
    <geoArea code="u-at-sa">South Australia</geoArea>
    <geoArea code="u-at-tm">Tasmania</geoArea>
    <geoArea code="u-at-vi">Victoria</geoArea>
    <geoArea code="u-at-we">Western Australia</geoArea>
    <geoArea code="u-cs">Coral Sea Islands</geoArea>
    <geoArea code="u-nz">New Zealand</geoArea>
    <geoArea code="v" status="obsolete">Communist countries</geoArea>
    <geoArea code="w">Tropics</geoArea>
    <geoArea code="x">Earth</geoArea>
    <geoArea code="xa">Eastern Hemisphere</geoArea>
    <geoArea code="xb">Northern Hemisphere</geoArea>
    <geoArea code="xc">Southern Hemisphere</geoArea>
    <geoArea code="xd">Western Hemisphere</geoArea>
    <geoArea code="zd">Deep space</geoArea>
    <geoArea code="zju">Jupiter</geoArea>
    <geoArea code="zma">Mars</geoArea>
    <geoArea code="zme">Mercury</geoArea>
    <geoArea code="zmo">Moon</geoArea>
    <geoArea code="zne">Neptune</geoArea>
    <geoArea code="zo">Outer space</geoArea>
    <geoArea code="zpl">Pluto</geoArea>
    <geoArea code="zs">Solar system</geoArea>
    <geoArea code="zsa">Saturn</geoArea>
    <geoArea code="zsu">Sun</geoArea>
    <geoArea code="zur">Uranus</geoArea>
    <geoArea code="zve">Venus</geoArea>
  </xsl:variable>

  <!--<xsl:import href="marcLangList.xsl"/>-->
  <!-- Based on MARC Code List for Languages, 2007 Edition, https://www.loc.gov/standards/codelists/languages.xml, retrieved 2020/09/25 -->
  <xsl:variable name="marcLangList">
    <lang code="abk">Abkhaz</lang>
    <lang code="ace">Achinese</lang>
    <lang code="ace">Atjeh</lang>
    <lang code="ach">Acoli</lang>
    <lang code="ach">Acholi</lang>
    <lang code="ach">Gang</lang>
    <lang code="ach">Lwo</lang>
    <lang code="ach">Shuli</lang>
    <lang code="ada">Adangme</lang>
    <lang code="ada">Dangme</lang>
    <lang code="ady">Adygei</lang>
    <lang code="ady">Circassian, Lower</lang>
    <lang code="ady">Circassian, West</lang>
    <lang code="ady">Kiakh</lang>
    <lang code="ady">Kjax</lang>
    <lang code="ady">Lower Circassian</lang>
    <lang code="ady">West Circassian</lang>
    <lang code="aar">Afar</lang>
    <lang code="aar">Adaiel</lang>
    <lang code="aar">Danakil</lang>
    <lang code="afh">Afrihili (Artificial language)</lang>
    <lang code="afr">Afrikaans</lang>
    <lang code="afr">Afrikander</lang>
    <lang code="afr">Cape Dutch</lang>
    <lang code="afa">Afroasiatic (Other)</lang>
    <lang code="afa">Angas</lang>
    <lang code="afa">Karan</lang>
    <lang code="afa">Karang (Nigeria)</lang>
    <lang code="afa">Ngas</lang>
    <lang code="afa">Bidiyo</lang>
    <lang code="afa">Bura-Pabir</lang>
    <lang code="afa">Babir</lang>
    <lang code="afa">Babur</lang>
    <lang code="afa">Barburr</lang>
    <lang code="afa">Boura</lang>
    <lang code="afa">Bourrah</lang>
    <lang code="afa">Bura (Chadic)</lang>
    <lang code="afa">Burra</lang>
    <lang code="afa">Huve</lang>
    <lang code="afa">Huviya</lang>
    <lang code="afa">Kwojeffa</lang>
    <lang code="afa">Mya Bura</lang>
    <lang code="afa">Pabir</lang>
    <lang code="afa">Toxrica</lang>
    <lang code="afa">Daba (Cameroon and Nigeria)</lang>
    <lang code="afa">Dangaleat</lang>
    <lang code="afa">Day (Chad)</lang>
    <lang code="afa">Dari (Chad)</lang>
    <lang code="afa">Sara Dai</lang>
    <lang code="afa">Gabri</lang>
    <lang code="afa">Gamo (Ethiopia)</lang>
    <lang code="afa">Gemu</lang>
    <lang code="afa">Glavda</lang>
    <lang code="afa">Goemai</lang>
    <lang code="afa">Ankwe</lang>
    <lang code="afa">Gamai (Nigeria)</lang>
    <lang code="afa">Kemai</lang>
    <lang code="afa">Gude</lang>
    <lang code="afa">Guruntum-Mbaaru</lang>
    <lang code="afa">Gurdung</lang>
    <lang code="afa">Guruntum</lang>
    <lang code="afa">Hedi</lang>
    <lang code="afa">Hdi</lang>
    <lang code="afa">Huba</lang>
    <lang code="afa">Chobba</lang>
    <lang code="afa">Kilba</lang>
    <lang code="afa">Jongor</lang>
    <lang code="afa">Dionkor</lang>
    <lang code="afa">Djongor</lang>
    <lang code="afa">Kamwe</lang>
    <lang code="afa">Higi</lang>
    <lang code="afa">Higgi</lang>
    <lang code="afa">Hiji</lang>
    <lang code="afa">Vacamwe</lang>
    <lang code="afa">Kanakuru</lang>
    <lang code="afa">Dera</lang>
    <lang code="afa">Kapsiki</lang>
    <lang code="afa">Kamsiki</lang>
    <lang code="afa">Psikye</lang>
    <lang code="afa">Ptsake</lang>
    <lang code="afa">Kera</lang>
    <lang code="afa">Mada (Cameroon)</lang>
    <lang code="afa">Mafa</lang>
    <lang code="afa">Matakam</lang>
    <lang code="afa">Natakan</lang>
    <lang code="afa">Male (Ethiopia)</lang>
    <lang code="afa">Maale</lang>
    <lang code="afa">Masa (Chadic)</lang>
    <lang code="afa">Banaa</lang>
    <lang code="afa">Banana (Masa)</lang>
    <lang code="afa">Masana</lang>
    <lang code="afa">Massa</lang>
    <lang code="afa">Walai</lang>
    <lang code="afa">Miship</lang>
    <lang code="afa">Chip</lang>
    <lang code="afa">Cip</lang>
    <lang code="afa">Ship</lang>
    <lang code="afa">Miya</lang>
    <lang code="afa">Musgu</lang>
    <lang code="afa">Masa</lang>
    <lang code="afa">Muyang</lang>
    <lang code="afa">Mouyenge</lang>
    <lang code="afa">Mouyengue</lang>
    <lang code="afa">Muyenge</lang>
    <lang code="afa">Myau</lang>
    <lang code="afa">Myenge</lang>
    <lang code="afa">Nancere</lang>
    <lang code="afa">Ngizim</lang>
    <lang code="afa">Gwazum</lang>
    <lang code="afa">Kirdiwat</lang>
    <lang code="afa">Nugzum</lang>
    <lang code="afa">Walu</lang>
    <lang code="afa">Paduko</lang>
    <lang code="afa">Podoko</lang>
    <lang code="afa">Ron</lang>
    <lang code="afa">Chala</lang>
    <lang code="afa">Run</lang>
    <lang code="afa">Saya</lang>
    <lang code="afa">Sayanci</lang>
    <lang code="afa">Sayara</lang>
    <lang code="afa">Sayawa</lang>
    <lang code="afa">Seiyara</lang>
    <lang code="afa">Seya</lang>
    <lang code="afa">Seyawa</lang>
    <lang code="afa">Sheko</lang>
    <lang code="afa">Shak</lang>
    <lang code="afa">Shako (Sheko)</lang>
    <lang code="afa">Shekka (Sheko)</lang>
    <lang code="afa">Shekko</lang>
    <lang code="afa">Tschako</lang>
    <lang code="afa">Southern Mofu</lang>
    <lang code="afa">Mofu, Southern</lang>
    <lang code="afa">Mofu-Gudur</lang>
    <lang code="afa">Tera</lang>
    <lang code="afa">Tumak</lang>
    <lang code="afa">Maga</lang>
    <lang code="afa">Sara Toumak</lang>
    <lang code="afa">Toumak</lang>
    <lang code="afa">Tupuri</lang>
    <lang code="afa">Ndore</lang>
    <lang code="afa">Tuburi</lang>
    <lang code="afa">Uldeme</lang>
    <lang code="afa">Mizlime</lang>
    <lang code="afa">Ouldémé</lang>
    <lang code="afa">Udlam</lang>
    <lang code="afa">Uzlam</lang>
    <lang code="afa">Uzan</lang>
    <lang code="afa">Wuzlam</lang>
    <lang code="afa">Wandala</lang>
    <lang code="afa">Mandara</lang>
    <lang code="afa">Yemsa</lang>
    <lang code="afa">Janjero</lang>
    <lang code="afa">Zaar</lang>
    <lang code="afa">Vigzar</lang>
    <lang code="afa">Vikzar</lang>
    <lang code="afa">Zulgo</lang>
    <lang code="afa">Zelgwa</lang>
    <lang code="ain">Ainu</lang>
    <lang code="aka">Akan</lang>
    <lang code="aka">Twi-Fante</lang>
    <lang code="akk">Akkadian</lang>
    <lang code="akk">Assyro-Babylonian</lang>
    <lang code="akk">Babylonian</lang>
    <lang code="alb">Albanian</lang>
    <lang code="alb">Calabrian Albanian</lang>
    <lang code="alb">Albanian, Calabrian</lang>
    <lang code="ale">Aleut</lang>
    <lang code="ale">Eleuth</lang>
    <lang code="alg">Algonquian (Other)</lang>
    <lang code="alg">Abenaki</lang>
    <lang code="alg">Abnaki</lang>
    <lang code="alg">Algonquin</lang>
    <lang code="alg">Algonkin</lang>
    <lang code="alg">Atakapa</lang>
    <lang code="alg">Atikamekw</lang>
    <lang code="alg">Attikamekw</lang>
    <lang code="alg">Tête-de-Boule</lang>
    <lang code="alg">Fox</lang>
    <lang code="alg">Gros Ventre (Algonquian)</lang>
    <lang code="alg">Ahahnelin</lang>
    <lang code="alg">Ahe (Algonquian)</lang>
    <lang code="alg">Ahenin</lang>
    <lang code="alg">Ananin</lang>
    <lang code="alg">Atsina</lang>
    <lang code="alg">Fall Indian</lang>
    <lang code="alg">Gros Ventres (Algonquian)</lang>
    <lang code="alg">Grosventre (Algonquian)</lang>
    <lang code="alg">Grosventres (Algonquian)</lang>
    <lang code="alg">White Clay People's language</lang>
    <lang code="alg">Illinois</lang>
    <lang code="alg">Kickapoo</lang>
    <lang code="alg">Mahican</lang>
    <lang code="alg">Massachuset</lang>
    <lang code="alg">Natick</lang>
    <lang code="alg">Niantic</lang>
    <lang code="alg">Nonantum</lang>
    <lang code="alg">Menominee</lang>
    <lang code="alg">Miami (Ind. and Okla.)</lang>
    <lang code="alg">Mohegan</lang>
    <lang code="alg">Pequot</lang>
    <lang code="alg">Montagnais</lang>
    <lang code="alg">Innu (Montagnais)</lang>
    <lang code="alg">Montagnais Innu</lang>
    <lang code="alg">Montagnar</lang>
    <lang code="alg">Montagnard</lang>
    <lang code="alg">Montagnie</lang>
    <lang code="alg">Mountainee</lang>
    <lang code="alg">Naskapi</lang>
    <lang code="alg">Nascapee</lang>
    <lang code="alg">Naskapee</lang>
    <lang code="alg">Passamaquoddy</lang>
    <lang code="alg">Etchemin</lang>
    <lang code="alg">Malecite</lang>
    <lang code="alg">Penobscot</lang>
    <lang code="alg">Potawatomi</lang>
    <lang code="alg">Powhatan</lang>
    <lang code="alg">Quileute</lang>
    <lang code="alg">Roanoak</lang>
    <lang code="alg">Shawnee</lang>
    <lang code="alg">Wampanoag</lang>
    <lang code="alg">Yurok</lang>
    <lang code="ajm" status="obsolete">Aljamía</lang>
    <lang code="alt">Altai</lang>
    <lang code="alt">Oirat (Turkic)</lang>
    <lang code="alt">Southern Altai</lang>
    <lang code="alt">Tubalar</lang>
    <lang code="tut">Altaic (Other)</lang>
    <lang code="tut">Turko-Tataric (Other)</lang>
    <lang code="tut">Bulgaro-Turkic</lang>
    <lang code="tut">Turko-Bulgarian</lang>
    <lang code="tut">(Altaic (Other))</lang>
    <lang code="tut">Dagur</lang>
    <lang code="tut">Daghur</lang>
    <lang code="tut">Daur</lang>
    <lang code="tut">Dolgan</lang>
    <lang code="tut">Even</lang>
    <lang code="tut">Lamut</lang>
    <lang code="tut">Evenki</lang>
    <lang code="tut">O-wen-k`o</lang>
    <lang code="tut">Tungus</lang>
    <lang code="tut">Gagauz</lang>
    <lang code="tut">Greek Tatar</lang>
    <lang code="tut">Urum</lang>
    <lang code="tut">Karaim</lang>
    <lang code="tut">Karakhanid</lang>
    <lang code="tut">Khakani</lang>
    <lang code="tut">Qarakhanid</lang>
    <lang code="tut">Khakass</lang>
    <lang code="tut">Xakas</lang>
    <lang code="tut">Xaqas</lang>
    <lang code="tut">Khalaj</lang>
    <lang code="tut">Khitan</lang>
    <lang code="tut">Kitan</lang>
    <lang code="tut">Liao</lang>
    <lang code="tut">Khorezmian Turkic</lang>
    <lang code="tut">Khwarezmian Turkic</lang>
    <lang code="tut">Kipchak</lang>
    <lang code="tut">Coman</lang>
    <lang code="tut">Cuman</lang>
    <lang code="tut">Falven</lang>
    <lang code="tut">Kuman</lang>
    <lang code="tut">Polovtsi</lang>
    <lang code="tut">Walwen</lang>
    <lang code="tut">Moghol</lang>
    <lang code="tut">Mogol</lang>
    <lang code="tut">Mongolian, Middle (13th-16th centuries)</lang>
    <lang code="tut">Middle Mongolian (13th-16th centuries)</lang>
    <lang code="tut">Mongour</lang>
    <lang code="tut">Tu</lang>
    <lang code="tut">Nanai</lang>
    <lang code="tut">Goldi</lang>
    <lang code="tut">Northern Altai</lang>
    <lang code="tut">Altai, Northern</lang>
    <lang code="tut">Olcha</lang>
    <lang code="tut">Ulcha</lang>
    <lang code="tut">Old Turkic</lang>
    <lang code="tut">Turkic, Old</lang>
    <lang code="tut">Oroch</lang>
    <lang code="tut">Oroqen</lang>
    <lang code="tut">Orochon</lang>
    <lang code="tut">Salar</lang>
    <lang code="tut">Shor</lang>
    <lang code="tut">Shorian</lang>
    <lang code="tut">Shortsian</lang>
    <lang code="tut">Shortzy</lang>
    <lang code="tut">Šor</lang>
    <lang code="tut">Sibo</lang>
    <lang code="tut">Xive</lang>
    <lang code="tut">Teleut</lang>
    <lang code="tut">Turkish, Old (to 1500)</lang>
    <lang code="tut">Anatolian Turkish, Old</lang>
    <lang code="tut">Old Anatolian Turkish</lang>
    <lang code="tut">Old Ottoman Turkish</lang>
    <lang code="tut">Old Turkish</lang>
    <lang code="tut">Ottoman Turkish, Old</lang>
    <lang code="tut">Udekhe</lang>
    <lang code="tut">Western Yugur</lang>
    <lang code="tut">Yugur, Western</lang>
    <lang code="amh">Amharic</lang>
    <lang code="amh">Amarigna</lang>
    <lang code="amh">Amarinya</lang>
    <lang code="anp">Angika</lang>
    <lang code="anp">Anga</lang>
    <lang code="apa">Apache languages</lang>
    <lang code="apa">Chiricahua</lang>
    <lang code="apa">Mescalero</lang>
    <lang code="apa">White Mountain Apache</lang>
    <lang code="ara">Arabic</lang>
    <lang code="ara">Hassaniyya</lang>
    <lang code="arg">Aragonese</lang>
    <lang code="arg">Altoaragonés</lang>
    <lang code="arg">Aragoieraz</lang>
    <lang code="arg">Aragonés</lang>
    <lang code="arg">Fabla Aragonesa</lang>
    <lang code="arg">High Aragonese</lang>
    <lang code="arg">Patués</lang>
    <lang code="arg">Spanish, Aragonese</lang>
    <lang code="arc">Aramaic</lang>
    <lang code="arc">Aramean</lang>
    <lang code="arc">Biblical Aramaic</lang>
    <lang code="arc">Chaldaic</lang>
    <lang code="arc">Chaldean (Aramaic)</lang>
    <lang code="arc">Chaldee</lang>
    <lang code="arp">Arapaho</lang>
    <lang code="arw">Arawak</lang>
    <lang code="arw">Loko (Arawakan)</lang>
    <lang code="arw">Lokono</lang>
    <lang code="arm">Armenian</lang>
    <lang code="arm">Khayasa</lang>
    <lang code="arm">Hayasa</lang>
    <lang code="arm">Khaiass</lang>
    <lang code="rup">Aromanian</lang>
    <lang code="rup">Macedo-Romanian</lang>
    <lang code="art">Artificial (Other)</lang>
    <lang code="art">Ande (Artificial language)</lang>
    <lang code="art">Babm</lang>
    <lang code="art">Balaibalan</lang>
    <lang code="art">Bâl-i bîlen</lang>
    <lang code="art">Bala-i-balan</lang>
    <lang code="art">Balabalan</lang>
    <lang code="art">Bâleybelen</lang>
    <lang code="art">Bali belen</lang>
    <lang code="art">Bâlibîlen</lang>
    <lang code="art">Enochian</lang>
    <lang code="art">Europanto</lang>
    <lang code="art">Glosa (Artificial language)</lang>
    <lang code="art">International auxiliari linguo (Artificial language)</lang>
    <lang code="art">INTAL (Artificial language)</lang>
    <lang code="art">Loglan (Artificial language)</lang>
    <lang code="art">Neo (Artificial language)</lang>
    <lang code="art">Novial (Artificial language)</lang>
    <lang code="art">Tsolyáni (Artificial language)</lang>
    <lang code="art">Vela (Artificial language)</lang>
    <lang code="asm">Assamese</lang>
    <lang code="asm">Kāmrūpī</lang>
    <lang code="asm">Kāmarūpī upabhāshā</lang>
    <lang code="asm">Rābhāmija</lang>
    <lang code="asm">Rābhāmiz</lang>
    <lang code="ath">Athapascan (Other)</lang>
    <lang code="ath">Ahtena</lang>
    <lang code="ath">Carrier</lang>
    <lang code="ath">Takulli</lang>
    <lang code="ath">Chilcotin</lang>
    <lang code="ath">Tsilkotin</lang>
    <lang code="ath">Dena'ina</lang>
    <lang code="ath">Tanaina</lang>
    <lang code="ath">Kaska</lang>
    <lang code="ath">Kiowa Apache</lang>
    <lang code="ath">Koyukon</lang>
    <lang code="ath">Sarsi</lang>
    <lang code="ath">Sekani-Beaver</lang>
    <lang code="ath">Southern Tutchone</lang>
    <lang code="ath">Tutchone, Southern</lang>
    <lang code="ath">Tagish</lang>
    <lang code="ath">Tahltan</lang>
    <lang code="ath">Tanacross</lang>
    <lang code="ath">Tsattine</lang>
    <lang code="ath">Upper Tanana</lang>
    <lang code="ath">Tanana, Upper</lang>
    <lang code="ath">Upper Umpqua</lang>
    <lang code="aus">Australian languages</lang>
    <lang code="aus">Adnyamathanha</lang>
    <lang code="aus">Atynyamatana</lang>
    <lang code="aus">Wailpi</lang>
    <lang code="aus">Alawa</lang>
    <lang code="aus">Galawa</lang>
    <lang code="aus">Alyawarra</lang>
    <lang code="aus">Iliaura</lang>
    <lang code="aus">Anindilyakwa</lang>
    <lang code="aus">Andilyaugwa</lang>
    <lang code="aus">Awabakal</lang>
    <lang code="aus">Bandjalang</lang>
    <lang code="aus">Minyung</lang>
    <lang code="aus">Bidjara</lang>
    <lang code="aus">Pitjara</lang>
    <lang code="aus">Biri (Australia)</lang>
    <lang code="aus">Birri (Australia)</lang>
    <lang code="aus">Burarra</lang>
    <lang code="aus">Bara (Australia)</lang>
    <lang code="aus">Jikai</lang>
    <lang code="aus">Tchikai</lang>
    <lang code="aus">Butchulla</lang>
    <lang code="aus">Darling River dialects</lang>
    <lang code="aus">Bagandji dialects</lang>
    <lang code="aus">Dhungutti</lang>
    <lang code="aus">Daingatti</lang>
    <lang code="aus">Dyangadi</lang>
    <lang code="aus">Thangatti</lang>
    <lang code="aus">Djaru</lang>
    <lang code="aus">Jaroo</lang>
    <lang code="aus">Tjaru</lang>
    <lang code="aus">Djinang</lang>
    <lang code="aus">Jandjinung</lang>
    <lang code="aus">Yandjinung</lang>
    <lang code="aus">Djingili</lang>
    <lang code="aus">Jingulu</lang>
    <lang code="aus">Tjingili</lang>
    <lang code="aus">Eastern Arrernte</lang>
    <lang code="aus">Aranda, Eastern</lang>
    <lang code="aus">Arrernte, Eastern</lang>
    <lang code="aus">Garawa</lang>
    <lang code="aus">Karawa (Australia)</lang>
    <lang code="aus">Korrawa</lang>
    <lang code="aus">Kurrawar</lang>
    <lang code="aus">Leearrawa</lang>
    <lang code="aus">Gidabal</lang>
    <lang code="aus">Kitabul</lang>
    <lang code="aus">Gubbi-Gubbi</lang>
    <lang code="aus">Kabi Kabi</lang>
    <lang code="aus">Gugada</lang>
    <lang code="aus">Kukota</lang>
    <lang code="aus">Gumatj</lang>
    <lang code="aus">Gomadj</lang>
    <lang code="aus">Kainyao</lang>
    <lang code="aus">Komaits</lang>
    <lang code="aus">Kumait</lang>
    <lang code="aus">Gungabula</lang>
    <lang code="aus">Kongabula</lang>
    <lang code="aus">Gunian</lang>
    <lang code="aus">Gooniyandi</lang>
    <lang code="aus">Gunwinggu</lang>
    <lang code="aus">Gupapuyngu</lang>
    <lang code="aus">Guugu Yimithirr</lang>
    <lang code="aus">Iwaidja</lang>
    <lang code="aus">Jiwadja</lang>
    <lang code="aus">Yiwadja</lang>
    <lang code="aus">Jaminjung</lang>
    <lang code="aus">Djamindjung</lang>
    <lang code="aus">Djaminjung</lang>
    <lang code="aus">Djaminydyung</lang>
    <lang code="aus">Dyaminydyung</lang>
    <lang code="aus">Tjamindjung</lang>
    <lang code="aus">Yilngali</lang>
    <lang code="aus">Kala Lagaw Ya</lang>
    <lang code="aus">Mabuiaq</lang>
    <lang code="aus">Kalkatungu</lang>
    <lang code="aus">Galgadung</lang>
    <lang code="aus">Kattang</lang>
    <lang code="aus">Kutthung</lang>
    <lang code="aus">Kitja</lang>
    <lang code="aus">Gidja</lang>
    <lang code="aus">Kija</lang>
    <lang code="aus">Kuku-Yalanji</lang>
    <lang code="aus">Gugu Yalanji</lang>
    <lang code="aus">Koko Jelandji</lang>
    <lang code="aus">Kuuku Ya'u</lang>
    <lang code="aus">Koko Ya'o</lang>
    <lang code="aus">Kwini</lang>
    <lang code="aus">Belaa</lang>
    <lang code="aus">Cuini</lang>
    <lang code="aus">Goonan</lang>
    <lang code="aus">Gunin</lang>
    <lang code="aus">Gwiini</lang>
    <lang code="aus">Gwini</lang>
    <lang code="aus">Kunan (Kwini)</lang>
    <lang code="aus">Kwini</lang>
    <lang code="aus">Kwini/Belaa</lang>
    <lang code="aus">Wunambal (Kwini)</lang>
    <lang code="aus">Malgana</lang>
    <lang code="aus">Maldjana</lang>
    <lang code="aus">Maljanna</lang>
    <lang code="aus">Malkana</lang>
    <lang code="aus">Mandjildjara</lang>
    <lang code="aus">Mantjiltjara</lang>
    <lang code="aus">Mangarayi</lang>
    <lang code="aus">Manggarai (Australia)</lang>
    <lang code="aus">Mungerry</lang>
    <lang code="aus">Maranunggu</lang>
    <lang code="aus">Marringarr</lang>
    <lang code="aus">Gidjingali</lang>
    <lang code="aus">Marengar</lang>
    <lang code="aus">Marenggar</lang>
    <lang code="aus">Maringa</lang>
    <lang code="aus">Maringar</lang>
    <lang code="aus">Maringarr</lang>
    <lang code="aus">Marri Ngarr</lang>
    <lang code="aus">Marringar</lang>
    <lang code="aus">Merringar</lang>
    <lang code="aus">Moil (Marringarr)</lang>
    <lang code="aus">Moyle</lang>
    <lang code="aus">Muringa</lang>
    <lang code="aus">Muringar</lang>
    <lang code="aus">Murrinnga</lang>
    <lang code="aus">Tangural</lang>
    <lang code="aus">Yaghani</lang>
    <lang code="aus">Martu Wangka</lang>
    <lang code="aus">Murrinhpatha</lang>
    <lang code="aus">Nakara</lang>
    <lang code="aus">Narangga</lang>
    <lang code="aus">Narungga</lang>
    <lang code="aus">Narrinyeri</lang>
    <lang code="aus">Ngaanyatjarra</lang>
    <lang code="aus">Ngandi</lang>
    <lang code="aus">Ngangikurunggurr</lang>
    <lang code="aus">Moil (Ngangikurunggurr)</lang>
    <lang code="aus">Nangikurrunggurr</lang>
    <lang code="aus">Nangikurunggur</lang>
    <lang code="aus">Ngangikarangurr</lang>
    <lang code="aus">Ngangikurongor</lang>
    <lang code="aus">Ngangikurrunggurr</lang>
    <lang code="aus">Ngangikurrungur</lang>
    <lang code="aus">Ngankikurrunkurr</lang>
    <lang code="aus">Ngankikurunggurr</lang>
    <lang code="aus">Ngankikurungkurr</lang>
    <lang code="aus">Ngenkikurrunggur</lang>
    <lang code="aus">Ngarinyin</lang>
    <lang code="aus">Ungarinjin</lang>
    <lang code="aus">Wungarinjin</lang>
    <lang code="aus">Ngarla</lang>
    <lang code="aus">Ngarluma</lang>
    <lang code="aus">Nukunu</lang>
    <lang code="aus">Nugunu</lang>
    <lang code="aus">Nunggubuyu</lang>
    <lang code="aus">Wubuy</lang>
    <lang code="aus">Peek whuurung</lang>
    <lang code="aus">Peek wuhrrong</lang>
    <lang code="aus">Pintupi</lang>
    <lang code="aus">Bindubi</lang>
    <lang code="aus">Pitjantjatjara</lang>
    <lang code="aus">Proto Mirndi</lang>
    <lang code="aus">Ritharrngu</lang>
    <lang code="aus">Tharrkari</lang>
    <lang code="aus">Dhargari</lang>
    <lang code="aus">Tiwi (Australia)</lang>
    <lang code="aus">Umpila</lang>
    <lang code="aus">Walmajarri</lang>
    <lang code="aus">Wandarang</lang>
    <lang code="aus">Andarang</lang>
    <lang code="aus">Nawariyi</lang>
    <lang code="aus">Wanʼguri</lang>
    <lang code="aus">Wonguri</lang>
    <lang code="aus">Warlpiri</lang>
    <lang code="aus">Elpira</lang>
    <lang code="aus">Ilpara</lang>
    <lang code="aus">Ngaliya</lang>
    <lang code="aus">Ngardilpa</lang>
    <lang code="aus">Wailbri</lang>
    <lang code="aus">Walbiri</lang>
    <lang code="aus">Waljbiri</lang>
    <lang code="aus">Walmama</lang>
    <lang code="aus">Walpiri</lang>
    <lang code="aus">Warnayaka</lang>
    <lang code="aus">Warrmarla</lang>
    <lang code="aus">Warumungu</lang>
    <lang code="aus">Western Arrernte</lang>
    <lang code="aus">Aranda, Western</lang>
    <lang code="aus">Arrernte, Western</lang>
    <lang code="aus">Western Desert</lang>
    <lang code="aus">Wik-Munkan</lang>
    <lang code="aus">Munggan</lang>
    <lang code="aus">Wik-Ngathan</lang>
    <lang code="aus">Wik-Ngathana</lang>
    <lang code="aus">Worora</lang>
    <lang code="aus">Wunambal</lang>
    <lang code="aus">Jeidji</lang>
    <lang code="aus">Jeithi</lang>
    <lang code="aus">Unambal</lang>
    <lang code="aus">Wumnabal</lang>
    <lang code="aus">Wunambullu</lang>
    <lang code="aus">Yeidji</lang>
    <lang code="aus">Yeithi</lang>
    <lang code="aus">Yandruwandha</lang>
    <lang code="aus">Yanyuwa</lang>
    <lang code="aus">Yawuru</lang>
    <lang code="aus">Jaudjibara</lang>
    <lang code="aus">Jawadjag</lang>
    <lang code="aus">Jawdjibaia</lang>
    <lang code="aus">Jawdjibara</lang>
    <lang code="aus">Winjawindjagu</lang>
    <lang code="aus">Yaudijbaia</lang>
    <lang code="aus">Yaudjibara</lang>
    <lang code="aus">Yawjibara</lang>
    <lang code="aus">Yidiny</lang>
    <lang code="aus">Yindjibarndi</lang>
    <lang code="aus">Jindjibandji</lang>
    <lang code="aus">Yinhawangka</lang>
    <lang code="aus">Inawonga</lang>
    <lang code="aus">Yualyai</lang>
    <lang code="aus">Euahlayi</lang>
    <lang code="aus">Jualjai</lang>
    <lang code="aus">Ualari</lang>
    <lang code="aus">Uollaroi</lang>
    <lang code="aus">Wallaroi</lang>
    <lang code="aus">Yerraleroi</lang>
    <lang code="aus">Yowalri</lang>
    <lang code="aus">Yuwaalaraay</lang>
    <lang code="aus">Yugambeh</lang>
    <lang code="map">Austronesian (Other)</lang>
    <lang code="map">Malayo-Polynesian (Other)</lang>
    <lang code="map">Adzera</lang>
    <lang code="map">Acira</lang>
    <lang code="map">Atsera</lang>
    <lang code="map">Atzera</lang>
    <lang code="map">Ajie</lang>
    <lang code="map">Houailou</lang>
    <lang code="map">Wailu</lang>
    <lang code="map">Ambrym</lang>
    <lang code="map">Amis</lang>
    <lang code="map">Ami</lang>
    <lang code="map">Anesu</lang>
    <lang code="map">Canala</lang>
    <lang code="map">Kanala</lang>
    <lang code="map">Xaracuu</lang>
    <lang code="map">Yaracuu</lang>
    <lang code="map">Apma</lang>
    <lang code="map">Areare</lang>
    <lang code="map">Arop-Lokep</lang>
    <lang code="map">Lokep</lang>
    <lang code="map">Lokewe</lang>
    <lang code="map">Arosi</lang>
    <lang code="map">Atayal</lang>
    <lang code="map">Tayal</lang>
    <lang code="map">Bajau</lang>
    <lang code="map">Badjo</lang>
    <lang code="map">Bayo</lang>
    <lang code="map">Luaan</lang>
    <lang code="map">Orang Laut (Indonesia)</lang>
    <lang code="map">Sama (Indonesia)</lang>
    <lang code="map">Turije̕ne̕</lang>
    <lang code="map">Bakumpai</lang>
    <lang code="map">Balaesang</lang>
    <lang code="map">Balaisang</lang>
    <lang code="map">Pajo</lang>
    <lang code="map">Banjar Hulu</lang>
    <lang code="map">Hulu</lang>
    <lang code="map">Barangas</lang>
    <lang code="map">Alalak</lang>
    <lang code="map">Bareë</lang>
    <lang code="map">Begak</lang>
    <lang code="map">Berawan</lang>
    <lang code="map">Biliau</lang>
    <lang code="map">Bimanese</lang>
    <lang code="map">Bolaang Mongondow</lang>
    <lang code="map">Buang</lang>
    <lang code="map">Bugotu</lang>
    <lang code="map">Mahaga</lang>
    <lang code="map">Bukar Sadong</lang>
    <lang code="map">Sadong</lang>
    <lang code="map">Serian</lang>
    <lang code="map">Tebakang</lang>
    <lang code="map">Bunama</lang>
    <lang code="map">Bunun</lang>
    <lang code="map">Buol</lang>
    <lang code="map">Bual</lang>
    <lang code="map">Bwuolo</lang>
    <lang code="map">Dia</lang>
    <lang code="map">Bwaidoga</lang>
    <lang code="map">Bwatoo</lang>
    <lang code="map">Camuhi</lang>
    <lang code="map">Cemuhi</lang>
    <lang code="map">Tyamuhi</lang>
    <lang code="map">Wagap</lang>
    <lang code="map">Carolinian</lang>
    <lang code="map">Daa</lang>
    <lang code="map">Pekawa</lang>
    <lang code="map">Dawawa</lang>
    <lang code="map">Dehu</lang>
    <lang code="map">Drehu</lang>
    <lang code="map">Lifu</lang>
    <lang code="map">Miny</lang>
    <lang code="map">Dobel</lang>
    <lang code="map">Kobroor</lang>
    <lang code="map">Dobu</lang>
    <lang code="map">Dumbea</lang>
    <lang code="map">Drubea</lang>
    <lang code="map">Duri</lang>
    <lang code="map">Masenrempulu (Duri)</lang>
    <lang code="map">Massenrempulu (Duri)</lang>
    <lang code="map">Dusun</lang>
    <lang code="map">Kadazan</lang>
    <lang code="map">East Makian</lang>
    <lang code="map">Inner Makian</lang>
    <lang code="map">Makian, East</lang>
    <lang code="map">Makian, Inner</lang>
    <lang code="map">Taba</lang>
    <lang code="map">East Uvean</lang>
    <lang code="map">Uvean, East</lang>
    <lang code="map">Wallisian</lang>
    <lang code="map">Enggano</lang>
    <lang code="map">Etaka</lang>
    <lang code="map">Enim</lang>
    <lang code="map">Eromanga</lang>
    <lang code="map">Sie</lang>
    <lang code="map">Sye</lang>
    <lang code="map">Favorlang</lang>
    <lang code="map">Babuza</lang>
    <lang code="map">Futuna-Aniwa</lang>
    <lang code="map">Erronan</lang>
    <lang code="map">West Futuna</lang>
    <lang code="map">Gapapaiwa</lang>
    <lang code="map">Manape</lang>
    <lang code="map">Gedaged</lang>
    <lang code="map">Graged</lang>
    <lang code="map">Gumasi</lang>
    <lang code="map">Halia</lang>
    <lang code="map">Ham</lang>
    <lang code="map">Dami</lang>
    <lang code="map">Hote</lang>
    <lang code="map">Iai (Loyalty Islands)</lang>
    <lang code="map">Iamalele</lang>
    <lang code="map">Yamalele</lang>
    <lang code="map">Ida'an</lang>
    <lang code="map">Iduna</lang>
    <lang code="map">Irahutu</lang>
    <lang code="map">Kaidipang</lang>
    <lang code="map">Kaili</lang>
    <lang code="map">Ledo'</lang>
    <lang code="map">Palu</lang>
    <lang code="map">Kaiwa (Papua New Guinea)</lang>
    <lang code="map">Iwal</lang>
    <lang code="map">Kambera</lang>
    <lang code="map">Kapingamarangi</lang>
    <lang code="map">Kara (Papua New Guinea)</lang>
    <lang code="map">Kara-Lemakot</lang>
    <lang code="map">Lemakot</lang>
    <lang code="map">Lemusmus</lang>
    <lang code="map">Katingan</lang>
    <lang code="map">Kaulong</lang>
    <lang code="map">Kayan (Borneo)</lang>
    <lang code="map">Kayu Agung</lang>
    <lang code="map">Kemak</lang>
    <lang code="map">Ema</lang>
    <lang code="map">Kerinci</lang>
    <lang code="map">Kinchai</lang>
    <lang code="map">Korintje</lang>
    <lang code="map">Kiput</lang>
    <lang code="map">Kiriwinian</lang>
    <lang code="map">Kilivila</lang>
    <lang code="map">Trobriand</lang>
    <lang code="map">Koluwawa</lang>
    <lang code="map">Komodo</lang>
    <lang code="map">Kubu</lang>
    <lang code="map">Kuni</lang>
    <lang code="map">Kurada</lang>
    <lang code="map">Auhelawa</lang>
    <lang code="map">Cauhelawa</lang>
    <lang code="map">Nuakata</lang>
    <lang code="map">Kutai</lang>
    <lang code="map">Tenggarong</lang>
    <lang code="map">Kwara'ae</lang>
    <lang code="map">Fiu</lang>
    <lang code="map">Lamenu</lang>
    <lang code="map">Lamen</lang>
    <lang code="map">Lewo (Lamenu)</lang>
    <lang code="map">Varmali</lang>
    <lang code="map">Lampung</lang>
    <lang code="map">Api</lang>
    <lang code="map">Lampong</lang>
    <lang code="map">Lau</lang>
    <lang code="map">Lavongai</lang>
    <lang code="map">Dang (Papua New Guinea)</lang>
    <lang code="map">Lavangai</lang>
    <lang code="map">New Hanover</lang>
    <lang code="map">Tungag</lang>
    <lang code="map">Tungak</lang>
    <lang code="map">Lembak Bilide</lang>
    <lang code="map">Lenakel</lang>
    <lang code="map">Letri Igona</lang>
    <lang code="map">Leti</lang>
    <lang code="map">Letti</lang>
    <lang code="map">Lgona</lang>
    <lang code="map">Literi Lagona</lang>
    <lang code="map">Luang</lang>
    <lang code="map">Wetan</lang>
    <lang code="map">Wetang</lang>
    <lang code="map">Lewo</lang>
    <lang code="map">Varsu</lang>
    <lang code="map">Lindrou</lang>
    <lang code="map">Lundayeh</lang>
    <lang code="map">Lun Daya</lang>
    <lang code="map">Lun Daye</lang>
    <lang code="map">Lun Dayho</lang>
    <lang code="map">Lundaya</lang>
    <lang code="map">Southern Murut</lang>
    <lang code="map">Manam</lang>
    <lang code="map">Mandak</lang>
    <lang code="map">Lelet</lang>
    <lang code="map">Mandara (Papua New Guinea)</lang>
    <lang code="map">Madara</lang>
    <lang code="map">Tabar</lang>
    <lang code="map">Mangap</lang>
    <lang code="map">Mbula (Mangap)</lang>
    <lang code="map">Manggarai (Indonesia)</lang>
    <lang code="map">Mangseng</lang>
    <lang code="map">Marquesan</lang>
    <lang code="map">Mekeo</lang>
    <lang code="map">Mele-Fila</lang>
    <lang code="map">Fila</lang>
    <lang code="map">Mentawai</lang>
    <lang code="map">Mokilese</lang>
    <lang code="map">Mori</lang>
    <lang code="map">Aikoa</lang>
    <lang code="map">Mortlockese</lang>
    <lang code="map">Mortlock (Micronesia)</lang>
    <lang code="map">Nomoi</lang>
    <lang code="map">Motu</lang>
    <lang code="map">Mouk</lang>
    <lang code="map">Mukawa</lang>
    <lang code="map">Kapikapi</lang>
    <lang code="map">Muna</lang>
    <lang code="map">Mina (Indonesia)</lang>
    <lang code="map">Wuna</lang>
    <lang code="map">Nakanai</lang>
    <lang code="map">Lakalai</lang>
    <lang code="map">Nali</lang>
    <lang code="map">Yiru</lang>
    <lang code="map">Napu</lang>
    <lang code="map">Bara (Indonesia)</lang>
    <lang code="map">Nemi</lang>
    <lang code="map">Nengone</lang>
    <lang code="map">Ngada</lang>
    <lang code="map">Ngaju</lang>
    <lang code="map">Biadju</lang>
    <lang code="map">Ngaju Dayak</lang>
    <lang code="map">Ngatik</lang>
    <lang code="map">Nguna</lang>
    <lang code="map">Notsi</lang>
    <lang code="map">Nochi</lang>
    <lang code="map">Nuaulu</lang>
    <lang code="map">Nukuoro</lang>
    <lang code="map">Numfor</lang>
    <lang code="map">Mafor</lang>
    <lang code="map">Noemfoor</lang>
    <lang code="map">Nufor</lang>
    <lang code="map">Paiwan</lang>
    <lang code="map">Pala</lang>
    <lang code="map">Paranan</lang>
    <lang code="map">Palanan</lang>
    <lang code="map">Pasir (Lawangan)</lang>
    <lang code="map">Pazeh</lang>
    <lang code="map">Bazai</lang>
    <lang code="map">Pendau</lang>
    <lang code="map">Ndaoe</lang>
    <lang code="map">Ndau (Malayan)</lang>
    <lang code="map">Umalasa</lang>
    <lang code="map">Petats</lang>
    <lang code="map">Pileni</lang>
    <lang code="map">Puluwat</lang>
    <lang code="map">Puyuma</lang>
    <lang code="map">Kadas language (Puyuma)</lang>
    <lang code="map">Panapanayan</lang>
    <lang code="map">Pelam</lang>
    <lang code="map">Pilam</lang>
    <lang code="map">Piyuma</lang>
    <lang code="map">Pyuma</lang>
    <lang code="map">Tipun</lang>
    <lang code="map">Ramoaaina</lang>
    <lang code="map">Malu (Papua New Guinea)</lang>
    <lang code="map">Rejang (Sumatra, Indonesia)</lang>
    <lang code="map">Redjang (Sumatra, Indonesia)</lang>
    <lang code="map">Rennellese</lang>
    <lang code="map">Bellonese</lang>
    <lang code="map">Munggava</lang>
    <lang code="map">Roti</lang>
    <lang code="map">Rottinese</lang>
    <lang code="map">Rotuman</lang>
    <lang code="map">Rukai</lang>
    <lang code="map">Drukai</lang>
    <lang code="map">Rungus</lang>
    <lang code="map">Dusun Dayak</lang>
    <lang code="map">Melobong Rungus</lang>
    <lang code="map">Memagun</lang>
    <lang code="map">Memogun</lang>
    <lang code="map">Momogun</lang>
    <lang code="map">Roongas</lang>
    <lang code="map">Rungus Dusun</lang>
    <lang code="map">Saaroa</lang>
    <lang code="map">La'alua</lang>
    <lang code="map">La'arua</lang>
    <lang code="map">Pachien</lang>
    <lang code="map">Paichien</lang>
    <lang code="map">Rarua</lang>
    <lang code="map">Saarua</lang>
    <lang code="map">Saroa</lang>
    <lang code="map">Shishaban</lang>
    <lang code="map">Sisyaban</lang>
    <lang code="map">Sangen</lang>
    <lang code="map">Sangil</lang>
    <lang code="map">Sangiré</lang>
    <lang code="map">Sangir (Indonesia and Philippines)</lang>
    <lang code="map">Sangihe</lang>
    <lang code="map">Saposa</lang>
    <lang code="map">Sawu</lang>
    <lang code="map">Havunese</lang>
    <lang code="map">Hawu</lang>
    <lang code="map">Sabu</lang>
    <lang code="map">Savu</lang>
    <lang code="map">Sedik</lang>
    <lang code="map">Sazek</lang>
    <lang code="map">Seedik</lang>
    <lang code="map">Shedekka</lang>
    <lang code="map">Semendo</lang>
    <lang code="map">Serawai</lang>
    <lang code="map">Sigi</lang>
    <lang code="map">Idja</lang>
    <lang code="map">Sikka</lang>
    <lang code="map">Siladang</lang>
    <lang code="map">Sinagoro</lang>
    <lang code="map">Sio</lang>
    <lang code="map">Sissano</lang>
    <lang code="map">Sobei</lang>
    <lang code="map">Sokop</lang>
    <lang code="map">Sonsorol-Tobi</lang>
    <lang code="map">Tobi</lang>
    <lang code="map">Suau</lang>
    <lang code="map">Sumba</lang>
    <lang code="map">Sumbawa</lang>
    <lang code="map">Semana</lang>
    <lang code="map">Soembawa</lang>
    <lang code="map">Sursurunga</lang>
    <lang code="map">Suwawa</lang>
    <lang code="map">Bunda (Indonesia)</lang>
    <lang code="map">Tagal Murut</lang>
    <lang code="map">Murut Tahol</lang>
    <lang code="map">Semambu</lang>
    <lang code="map">Semembu</lang>
    <lang code="map">Sumambu</lang>
    <lang code="map">Sumambu-Tagal</lang>
    <lang code="map">Sumambuq</lang>
    <lang code="map">Tagula</lang>
    <lang code="map">Sudest</lang>
    <lang code="map">Takuu</lang>
    <lang code="map">Mortlock (Papua New Guinea)</lang>
    <lang code="map">Nahoa</lang>
    <lang code="map">Taku</lang>
    <lang code="map">Taʻu</lang>
    <lang code="map">Tauu</lang>
    <lang code="map">Talaud</lang>
    <lang code="map">Talaoed</lang>
    <lang code="map">Tamuan</lang>
    <lang code="map">Tanga (Tanga Islands)</lang>
    <lang code="map">Tavara (Papua New Guinea)</lang>
    <lang code="map">Kehelala</lang>
    <lang code="map">Tawala</lang>
    <lang code="map">Tawoyan</lang>
    <lang code="map">Teop</lang>
    <lang code="map">Tiop</lang>
    <lang code="map">Tidore</lang>
    <lang code="map">Tikopia</lang>
    <lang code="map">Timor</lang>
    <lang code="map">Atoni</lang>
    <lang code="map">Timorese</lang>
    <lang code="map">Timugon</lang>
    <lang code="map">Tinputz</lang>
    <lang code="map">Timputs</lang>
    <lang code="map">Vasuii</lang>
    <lang code="map">Wasoi</lang>
    <lang code="map">Titan</lang>
    <lang code="map">Manus</lang>
    <lang code="map">M'bunai</lang>
    <lang code="map">Moanus</lang>
    <lang code="map">Tito</lang>
    <lang code="map">Tolai</lang>
    <lang code="map">Blanche Bay</lang>
    <lang code="map">Gunantuna</lang>
    <lang code="map">Kuanua</lang>
    <lang code="map">New Britain</lang>
    <lang code="map">Raluana</lang>
    <lang code="map">Tinata Tuna</lang>
    <lang code="map">Tuna</lang>
    <lang code="map">Tolaki</lang>
    <lang code="map">Kendari</lang>
    <lang code="map">Toolaki</lang>
    <lang code="map">Tombulu</lang>
    <lang code="map">Toumbulu</lang>
    <lang code="map">Tondano</lang>
    <lang code="map">Tolou</lang>
    <lang code="map">Tolour</lang>
    <lang code="map">Tonsea</lang>
    <lang code="map">Toraja</lang>
    <lang code="map">Toradja</lang>
    <lang code="map">Toraja Sa'dan</lang>
    <lang code="map">Sadan (Indonesia)</lang>
    <lang code="map">Saqdab Toraja</lang>
    <lang code="map">South Toraja</lang>
    <lang code="map">Tae'</lang>
    <lang code="map">Tuamotuan</lang>
    <lang code="map">Paumotu</lang>
    <lang code="map">Tubetube</lang>
    <lang code="map">Ulithi</lang>
    <lang code="map">Uma</lang>
    <lang code="map">Pipikoro</lang>
    <lang code="map">Urak Lawoi̕̕</lang>
    <lang code="map">Chāo Lē</lang>
    <lang code="map">Orak Lawoi'</lang>
    <lang code="map">Orang Laut (Thailand and Malaysia)</lang>
    <lang code="map">Uripiv</lang>
    <lang code="map">Wampar</lang>
    <lang code="map">Wandamen</lang>
    <lang code="map">Windesi</lang>
    <lang code="map">Wondama</lang>
    <lang code="map">Wewewa</lang>
    <lang code="map">Sumba, West</lang>
    <lang code="map">Waidjewa</lang>
    <lang code="map">West Sumba</lang>
    <lang code="map">Woleaian</lang>
    <lang code="map">Uleai</lang>
    <lang code="map">Woleai</lang>
    <lang code="map">Wolio</lang>
    <lang code="map">Yabim</lang>
    <lang code="map">Jabêm</lang>
    <lang code="map">Yamdena</lang>
    <lang code="map">Jamdena</lang>
    <lang code="ava">Avaric</lang>
    <lang code="ave">Avestan</lang>
    <lang code="ave">Avesta</lang>
    <lang code="ave">Bactrian, Old (Avestan)</lang>
    <lang code="ave">Old Bactrian (Avestan)</lang>
    <lang code="ave">Zend</lang>
    <lang code="awa">Awadhi</lang>
    <lang code="aym">Aymara</lang>
    <lang code="aym">Aimara</lang>
    <lang code="aze">Azerbaijani</lang>
    <lang code="aze">Azari</lang>
    <lang code="aze">Azeri</lang>
    <lang code="aze">Afshar</lang>
    <lang code="ast">Bable</lang>
    <lang code="ast">Asturian</lang>
    <lang code="ban">Balinese</lang>
    <lang code="bat">Baltic (Other)</lang>
    <lang code="bat">Curonian</lang>
    <lang code="bat">Proto-Baltic</lang>
    <lang code="bat">Prussian</lang>
    <lang code="bat">Old Prussian</lang>
    <lang code="bal">Baluchi</lang>
    <lang code="bal">Balochi</lang>
    <lang code="bal">Beloutchi</lang>
    <lang code="bal">Biluchi</lang>
    <lang code="bam">Bambara</lang>
    <lang code="bam">Bamana (Mandekan)</lang>
    <lang code="bam">Bamanankan</lang>
    <lang code="bai">Bamileke languages</lang>
    <lang code="bai">Bandjoun</lang>
    <lang code="bai">Bamileke-Jo</lang>
    <lang code="bai">Fe'fe'</lang>
    <lang code="bai">Bafang</lang>
    <lang code="bai">Bamileke-Fe'fe'</lang>
    <lang code="bai">Bana (Bamileke)</lang>
    <lang code="bai">Fa (Bamileke)</lang>
    <lang code="bai">Fan (Bamileke)</lang>
    <lang code="bai">Fanwe (Bamileke)</lang>
    <lang code="bai">Fe'e fe'e</lang>
    <lang code="bai">Fotouni</lang>
    <lang code="bai">Kuu</lang>
    <lang code="bai">Nufi</lang>
    <lang code="bai">Ngyemboon</lang>
    <lang code="bai">Nguemba (Bamileke)</lang>
    <lang code="bai">Yemba</lang>
    <lang code="bad">Banda languages</lang>
    <lang code="bad">Banda (Central Africa)</lang>
    <lang code="bad">Linda</lang>
    <lang code="bnt">Bantu (Other)</lang>
    <lang code="bnt">Abo (Cameroon)</lang>
    <lang code="bnt">Abaw</lang>
    <lang code="bnt">Bo (Cameroon)</lang>
    <lang code="bnt">Bon (Cameroon)</lang>
    <lang code="bnt">Aka (Central African Republic)</lang>
    <lang code="bnt">Asu</lang>
    <lang code="bnt">Athu</lang>
    <lang code="bnt">Chasu</lang>
    <lang code="bnt">Pare</lang>
    <lang code="bnt">Bafia</lang>
    <lang code="bnt">Bakundu</lang>
    <lang code="bnt">Kundu</lang>
    <lang code="bnt">Bati</lang>
    <lang code="bnt">Bekwil</lang>
    <lang code="bnt">Bakwele</lang>
    <lang code="bnt">Bakwil</lang>
    <lang code="bnt">Bekwel</lang>
    <lang code="bnt">Bekwie</lang>
    <lang code="bnt">Bekwyel</lang>
    <lang code="bnt">Kwele</lang>
    <lang code="bnt">Okpele</lang>
    <lang code="bnt">Bembe (Congo (Brazzaville))</lang>
    <lang code="bnt">KiBembe</lang>
    <lang code="bnt">Mbembe</lang>
    <lang code="bnt">Benga</lang>
    <lang code="bnt">Bisa (Bantu)</lang>
    <lang code="bnt">Wisa</lang>
    <lang code="bnt">Bobangi</lang>
    <lang code="bnt">Rebu</lang>
    <lang code="bnt">Bolia</lang>
    <lang code="bnt">Bulia</lang>
    <lang code="bnt">Boma (Congo)</lang>
    <lang code="bnt">Buma (Congo)</lang>
    <lang code="bnt">Bomitaba</lang>
    <lang code="bnt">Mbomitaba</lang>
    <lang code="bnt">Mitaba</lang>
    <lang code="bnt">Bondei</lang>
    <lang code="bnt">Bonde</lang>
    <lang code="bnt">Boondei</lang>
    <lang code="bnt">Kibondei</lang>
    <lang code="bnt">Wabondei</lang>
    <lang code="bnt">Bube</lang>
    <lang code="bnt">Bubi (Equatorial Guinea)</lang>
    <lang code="bnt">Fernandian</lang>
    <lang code="bnt">Bubi (Gabon)</lang>
    <lang code="bnt">Pove</lang>
    <lang code="bnt">Budu</lang>
    <lang code="bnt">Bukusu</lang>
    <lang code="bnt">Lubukusu</lang>
    <lang code="bnt">Bulu</lang>
    <lang code="bnt">Boulou</lang>
    <lang code="bnt">Camtho</lang>
    <lang code="bnt">Iscamtho</lang>
    <lang code="bnt">Isicamtho</lang>
    <lang code="bnt">Shalambombo</lang>
    <lang code="bnt">Tsotsitaal (Camtho)</lang>
    <lang code="bnt">Chaga</lang>
    <lang code="bnt">Djaga</lang>
    <lang code="bnt">Dschagga</lang>
    <lang code="bnt">Jagga</lang>
    <lang code="bnt">Tschagga</lang>
    <lang code="bnt">Chokwe</lang>
    <lang code="bnt">Cibokwe</lang>
    <lang code="bnt">Cokwe</lang>
    <lang code="bnt">Jok</lang>
    <lang code="bnt">Katchokue</lang>
    <lang code="bnt">Kioko</lang>
    <lang code="bnt">Quioco</lang>
    <lang code="bnt">Tutchokue</lang>
    <lang code="bnt">Chopi</lang>
    <lang code="bnt">Lenge</lang>
    <lang code="bnt">Comorian</lang>
    <lang code="bnt">Diriku</lang>
    <lang code="bnt">Mbogedo</lang>
    <lang code="bnt">Rugciriku</lang>
    <lang code="bnt">Rumanyo</lang>
    <lang code="bnt">Shimbogedu</lang>
    <lang code="bnt">Doko (Congo)</lang>
    <lang code="bnt">Duruma</lang>
    <lang code="bnt">Embu</lang>
    <lang code="bnt">Enahara</lang>
    <lang code="bnt">Emathipane</lang>
    <lang code="bnt">Enaharra</lang>
    <lang code="bnt">Maharra</lang>
    <lang code="bnt">Nahara</lang>
    <lang code="bnt">Naharra</lang>
    <lang code="bnt">Fipa</lang>
    <lang code="bnt">Fuliru</lang>
    <lang code="bnt">Ganguela</lang>
    <lang code="bnt">Ngangela</lang>
    <lang code="bnt">Geviya</lang>
    <lang code="bnt">Avias</lang>
    <lang code="bnt">Eviya</lang>
    <lang code="bnt">Viya</lang>
    <lang code="bnt">Giryama</lang>
    <lang code="bnt">Gisu</lang>
    <lang code="bnt">Lugisu</lang>
    <lang code="bnt">Lumasaaba</lang>
    <lang code="bnt">Masaba</lang>
    <lang code="bnt">Gungu</lang>
    <lang code="bnt">Lugungu</lang>
    <lang code="bnt">Rugungu</lang>
    <lang code="bnt">Gusii</lang>
    <lang code="bnt">Ekegusii</lang>
    <lang code="bnt">Kisii</lang>
    <lang code="bnt">Gweno</lang>
    <lang code="bnt">Kigweno</lang>
    <lang code="bnt">Gwere</lang>
    <lang code="bnt">Ha</lang>
    <lang code="bnt">Haya</lang>
    <lang code="bnt">Luhaya</lang>
    <lang code="bnt">Lusiba</lang>
    <lang code="bnt">Ruhaya</lang>
    <lang code="bnt">Ziba</lang>
    <lang code="bnt">Hehe</lang>
    <lang code="bnt">Hunde</lang>
    <lang code="bnt">Ikizu</lang>
    <lang code="bnt">Ikiizo</lang>
    <lang code="bnt">Ikikizo</lang>
    <lang code="bnt">Ikikizu</lang>
    <lang code="bnt">Kiikizu</lang>
    <lang code="bnt">Ila</lang>
    <lang code="bnt">Jita</lang>
    <lang code="bnt">Echijita</lang>
    <lang code="bnt">Ecijita</lang>
    <lang code="bnt">Kijita</lang>
    <lang code="bnt">Kahe</lang>
    <lang code="bnt">Kikahe</lang>
    <lang code="bnt">Kako</lang>
    <lang code="bnt">Kaka (Northwest Bantu)</lang>
    <lang code="bnt">Yaka (Cameroon and Central African Republic)</lang>
    <lang code="bnt">Kalanga (Botswana and Zimbabwe)</lang>
    <lang code="bnt">Kanyok</lang>
    <lang code="bnt">Kaonde</lang>
    <lang code="bnt">Luba-Kaonde</lang>
    <lang code="bnt">Kare</lang>
    <lang code="bnt">Akare</lang>
    <lang code="bnt">Bakare</lang>
    <lang code="bnt">Kele (Gabon)</lang>
    <lang code="bnt">Kete</lang>
    <lang code="bnt">Kom (Cameroon)</lang>
    <lang code="bnt">Nkom</lang>
    <lang code="bnt">Kombe</lang>
    <lang code="bnt">Komo (Congo)</lang>
    <lang code="bnt">Kumu</lang>
    <lang code="bnt">Koonzime</lang>
    <lang code="bnt">Djimu</lang>
    <lang code="bnt">Dzimou</lang>
    <lang code="bnt">Konzime</lang>
    <lang code="bnt">Kooncimo</lang>
    <lang code="bnt">Koozhime</lang>
    <lang code="bnt">Koozime</lang>
    <lang code="bnt">Nzime</lang>
    <lang code="bnt">Zimu</lang>
    <lang code="bnt">Kuria</lang>
    <lang code="bnt">Ekiguria</lang>
    <lang code="bnt">Igikuria</lang>
    <lang code="bnt">Ikikuria</lang>
    <lang code="bnt">Kikoria</lang>
    <lang code="bnt">Kikouria</lang>
    <lang code="bnt">Kikuria</lang>
    <lang code="bnt">Kikuria cha juu</lang>
    <lang code="bnt">Kikuria cha Mashariki</lang>
    <lang code="bnt">Koria</lang>
    <lang code="bnt">Kurya</lang>
    <lang code="bnt">Kurye</lang>
    <lang code="bnt">Tende (Kuria)</lang>
    <lang code="bnt">Kwangali</lang>
    <lang code="bnt">Kwese</lang>
    <lang code="bnt">Kwezo</lang>
    <lang code="bnt">Kwiri</lang>
    <lang code="bnt">Mokpwe</lang>
    <lang code="bnt">Lala</lang>
    <lang code="bnt">Lega</lang>
    <lang code="bnt">Lenje</lang>
    <lang code="bnt">Bwine-Mukuni</lang>
    <lang code="bnt">Ci-Renje</lang>
    <lang code="bnt">Logooli</lang>
    <lang code="bnt">Ragoli</lang>
    <lang code="bnt">Lomwe (Malawi)</lang>
    <lang code="bnt">Londo</lang>
    <lang code="bnt">Balondo Ba Diko</lang>
    <lang code="bnt">Balondo Ba Nanga</lang>
    <lang code="bnt">Balondo</lang>
    <lang code="bnt">Barondo</lang>
    <lang code="bnt">Lundu</lang>
    <lang code="bnt">Lucazi</lang>
    <lang code="bnt">Ponda</lang>
    <lang code="bnt">Luvale</lang>
    <lang code="bnt">Luyana</lang>
    <lang code="bnt">Luyia</lang>
    <lang code="bnt">Oluluyia</lang>
    <lang code="bnt">Maka (Cameroon)</lang>
    <lang code="bnt">Makaa (Cameroon)</lang>
    <lang code="bnt">Mekaa</lang>
    <lang code="bnt">Makhuwa</lang>
    <lang code="bnt">Central Makhuwa</lang>
    <lang code="bnt">Emakhuwa</lang>
    <lang code="bnt">Emakua</lang>
    <lang code="bnt">Macua</lang>
    <lang code="bnt">Makhuwa-Makhuwana</lang>
    <lang code="bnt">Makhuwwa of Nampula</lang>
    <lang code="bnt">Makoane language</lang>
    <lang code="bnt">Makua (Mozambique)</lang>
    <lang code="bnt">Maquoua (Makhuwa)</lang>
    <lang code="bnt">Makonde</lang>
    <lang code="bnt">Chimakonde</lang>
    <lang code="bnt">Chinimakonde</lang>
    <lang code="bnt">Cimakonde</lang>
    <lang code="bnt">Konde (Makonde)</lang>
    <lang code="bnt">Maconde</lang>
    <lang code="bnt">Makonda</lang>
    <lang code="bnt">Matambe</lang>
    <lang code="bnt">Matambwe (Makonde)</lang>
    <lang code="bnt">Mekwengo</lang>
    <lang code="bnt">Shimakonde</lang>
    <lang code="bnt">Makwe</lang>
    <lang code="bnt">Kimakwe</lang>
    <lang code="bnt">Macue</lang>
    <lang code="bnt">Maraba (Makwe)</lang>
    <lang code="bnt">Palma</lang>
    <lang code="bnt">Mashami</lang>
    <lang code="bnt">Kimashami</lang>
    <lang code="bnt">Machambe</lang>
    <lang code="bnt">Machame</lang>
    <lang code="bnt">Madschame</lang>
    <lang code="bnt">Mbala (Bandundu, Congo)</lang>
    <lang code="bnt">Mbo (Cameroon)</lang>
    <lang code="bnt">Mbosi</lang>
    <lang code="bnt">Mbukushu</lang>
    <lang code="bnt">Goba</lang>
    <lang code="bnt">Mambukush</lang>
    <lang code="bnt">Mpukush</lang>
    <lang code="bnt">Thimbukushu</lang>
    <lang code="bnt">Mbunda (Angola and Zambia)</lang>
    <lang code="bnt">Meru</lang>
    <lang code="bnt">Kimeru</lang>
    <lang code="bnt">Mijikenda languages</lang>
    <lang code="bnt">Nika languages</lang>
    <lang code="bnt">Nyika languages</lang>
    <lang code="bnt">Mituku</lang>
    <lang code="bnt">Mkaaʼ</lang>
    <lang code="bnt">Bakaka</lang>
    <lang code="bnt">Mochi</lang>
    <lang code="bnt">Kimochi</lang>
    <lang code="bnt">Kimoshi</lang>
    <lang code="bnt">Moshi (Tanzania)</lang>
    <lang code="bnt">Mosi (Tanzania)</lang>
    <lang code="bnt">Old Moshi</lang>
    <lang code="bnt">Mpiemo</lang>
    <lang code="bnt">Bimu</lang>
    <lang code="bnt">Mbimou</lang>
    <lang code="bnt">Mbimu</lang>
    <lang code="bnt">Mbyemo</lang>
    <lang code="bnt">Mpo</lang>
    <lang code="bnt">Mpyemo</lang>
    <lang code="bnt">Mpongwe</lang>
    <lang code="bnt">Pongwe</lang>
    <lang code="bnt">Mpur (Congo)</lang>
    <lang code="bnt">Nambya</lang>
    <lang code="bnt">Nande</lang>
    <lang code="bnt">Nandi (Congo)</lang>
    <lang code="bnt">Ndau</lang>
    <lang code="bnt">Chindau</lang>
    <lang code="bnt">Shona, Southeastern</lang>
    <lang code="bnt">Ndumu</lang>
    <lang code="bnt">Ngonde</lang>
    <lang code="bnt">Ikinyi-Kiusa</lang>
    <lang code="bnt">Kiusa</lang>
    <lang code="bnt">Konde (Nyakyusa)</lang>
    <lang code="bnt">Mombe</lang>
    <lang code="bnt">Nkonde</lang>
    <lang code="bnt">Nyakyusa</lang>
    <lang code="bnt">Sochile</lang>
    <lang code="bnt">Ngul</lang>
    <lang code="bnt">Engwî</lang>
    <lang code="bnt">Ingul</lang>
    <lang code="bnt">Kingóli</lang>
    <lang code="bnt">Ngoli</lang>
    <lang code="bnt">Nguli</lang>
    <lang code="bnt">Ngulu (Congo (Democratic Republic))</lang>
    <lang code="bnt">Ngwi (Congo (Democratic Republic))</lang>
    <lang code="bnt">Nsenga</lang>
    <lang code="bnt">Ntomba</lang>
    <lang code="bnt">Nyaneka</lang>
    <lang code="bnt">Lunyaneka</lang>
    <lang code="bnt">Olunyaneka</lang>
    <lang code="bnt">Nyanga</lang>
    <lang code="bnt">Nyaturu</lang>
    <lang code="bnt">Keremi</lang>
    <lang code="bnt">Kinyaturu</lang>
    <lang code="bnt">Kiremi</lang>
    <lang code="bnt">Kirimi</lang>
    <lang code="bnt">Limi (Nyaturu)</lang>
    <lang code="bnt">Remi</lang>
    <lang code="bnt">Rimi</lang>
    <lang code="bnt">Turu (Nyaturu)</lang>
    <lang code="bnt">Nyole (Uganda)</lang>
    <lang code="bnt">Lunyole (Uganda)</lang>
    <lang code="bnt">Nyule</lang>
    <lang code="bnt">Nyuli</lang>
    <lang code="bnt">Nyungwe</lang>
    <lang code="bnt">Tete</lang>
    <lang code="bnt">Nzebi</lang>
    <lang code="bnt">Bandzabi</lang>
    <lang code="bnt">Indzèbi</lang>
    <lang code="bnt">Injebi</lang>
    <lang code="bnt">Ndjabi</lang>
    <lang code="bnt">Ndjebi</lang>
    <lang code="bnt">Ndjevi</lang>
    <lang code="bnt">Njabi</lang>
    <lang code="bnt">Njevi</lang>
    <lang code="bnt">Nzabi</lang>
    <lang code="bnt">Yinzabi</lang>
    <lang code="bnt">Pangwa</lang>
    <lang code="bnt">Pelende</lang>
    <lang code="bnt">Pende</lang>
    <lang code="bnt">Kipende</lang>
    <lang code="bnt">Pindi (Pende)</lang>
    <lang code="bnt">Pokomo</lang>
    <lang code="bnt">Punu</lang>
    <lang code="bnt">Bapounou</lang>
    <lang code="bnt">Pounou</lang>
    <lang code="bnt">Rangi</lang>
    <lang code="bnt">Irangi</lang>
    <lang code="bnt">Kilangi</lang>
    <lang code="bnt">Kirangi</lang>
    <lang code="bnt">Langi (Tanzania)</lang>
    <lang code="bnt">Ronga</lang>
    <lang code="bnt">Landim</lang>
    <lang code="bnt">Shironga</lang>
    <lang code="bnt">Xironga</lang>
    <lang code="bnt">Ruri</lang>
    <lang code="bnt">Ciruuri</lang>
    <lang code="bnt">Kiruri</lang>
    <lang code="bnt">Ruuri</lang>
    <lang code="bnt">Ruund</lang>
    <lang code="bnt">Chiluwunda</lang>
    <lang code="bnt">Lunda, Northern</lang>
    <lang code="bnt">Luwunda</lang>
    <lang code="bnt">Muatiamvua</lang>
    <lang code="bnt">Northern Lunda</lang>
    <lang code="bnt">Uruund</lang>
    <lang code="bnt">Saamia</lang>
    <lang code="bnt">Luhya (Saamia)</lang>
    <lang code="bnt">Luluyia (Saamia)</lang>
    <lang code="bnt">Lusaamia</lang>
    <lang code="bnt">Luyia (Saamia)</lang>
    <lang code="bnt">Ólusaamya</lang>
    <lang code="bnt">Olusamia</lang>
    <lang code="bnt">Samia</lang>
    <lang code="bnt">Samya</lang>
    <lang code="bnt">Sakata</lang>
    <lang code="bnt">Salampasu</lang>
    <lang code="bnt">Chisalampasu</lang>
    <lang code="bnt">Sanga</lang>
    <lang code="bnt">Luba, Southern</lang>
    <lang code="bnt">Southern Luba</lang>
    <lang code="bnt">Sena</lang>
    <lang code="bnt">Shambala</lang>
    <lang code="bnt">Shi</lang>
    <lang code="bnt">Mashi</lang>
    <lang code="bnt">Nyabungu</lang>
    <lang code="bnt">Shimaore</lang>
    <lang code="bnt">Mahorais</lang>
    <lang code="bnt">Simbiti</lang>
    <lang code="bnt">Kisimbiti</lang>
    <lang code="bnt">Songye</lang>
    <lang code="bnt">Songe</lang>
    <lang code="bnt">Subiya</lang>
    <lang code="bnt">ciIkuhane</lang>
    <lang code="bnt">Ikuhane</lang>
    <lang code="bnt">Soubiya</lang>
    <lang code="bnt">Suku (Congo)</lang>
    <lang code="bnt">Sumbwa</lang>
    <lang code="bnt">Kisumbwa</lang>
    <lang code="bnt">Shisumbwa</lang>
    <lang code="bnt">Sisumbwa</lang>
    <lang code="bnt">Sisuumbwa</lang>
    <lang code="bnt">Taita</lang>
    <lang code="bnt">Sagalla</lang>
    <lang code="bnt">Teita</lang>
    <lang code="bnt">Talinga-Bwisi</lang>
    <lang code="bnt">Bwisi-Talinga</lang>
    <lang code="bnt">Kitalinga</lang>
    <lang code="bnt">Teke</lang>
    <lang code="bnt">Balali</lang>
    <lang code="bnt">Ilali</lang>
    <lang code="bnt">Itio</lang>
    <lang code="bnt">Lali</lang>
    <lang code="bnt">Tembo (Sud-Kivu, Congo)</lang>
    <lang code="bnt">KiTembo</lang>
    <lang code="bnt">Temi</lang>
    <lang code="bnt">Gitemi</lang>
    <lang code="bnt">Kisonjo</lang>
    <lang code="bnt">Sonjo</lang>
    <lang code="bnt">Sonyo</lang>
    <lang code="bnt">Wasonjo</lang>
    <lang code="bnt">Watemi</lang>
    <lang code="bnt">Tetela</lang>
    <lang code="bnt">Tharaka</lang>
    <lang code="bnt">Saraka</lang>
    <lang code="bnt">Tiene</lang>
    <lang code="bnt">Ketiine</lang>
    <lang code="bnt">Kitiene</lang>
    <lang code="bnt">Kitiini</lang>
    <lang code="bnt">Tende (Congo (Democratic Republic))</lang>
    <lang code="bnt">Tiriki</lang>
    <lang code="bnt">Tonga (Inhambane)</lang>
    <lang code="bnt">Gitonga</lang>
    <lang code="bnt">Tonga (Zambezi)</lang>
    <lang code="bnt">Tooro</lang>
    <lang code="bnt">Toro</lang>
    <lang code="bnt">Tsogo</lang>
    <lang code="bnt">Apindji</lang>
    <lang code="bnt">Mitsogo</lang>
    <lang code="bnt">Tswa</lang>
    <lang code="bnt">Kitswa</lang>
    <lang code="bnt">Shitswa</lang>
    <lang code="bnt">Tshwa</lang>
    <lang code="bnt">Xitswa</lang>
    <lang code="bnt">Tunen</lang>
    <lang code="bnt">Banen</lang>
    <lang code="bnt">Yaka (Congo and Angola)</lang>
    <lang code="bnt">Iaka</lang>
    <lang code="bnt">Yanzi</lang>
    <lang code="bnt">Yombe (Congo and Angola)</lang>
    <lang code="bnt">Zanaki</lang>
    <lang code="bnt">Iki-Zanaki</lang>
    <lang code="bnt">IkiZanaki</lang>
    <lang code="bnt">Zigula</lang>
    <lang code="bnt">Kizigula</lang>
    <lang code="bnt">Seguha</lang>
    <lang code="bnt">Wayombo</lang>
    <lang code="bnt">Wazegua</lang>
    <lang code="bnt">Wazigua</lang>
    <lang code="bnt">Zeguha</lang>
    <lang code="bnt">Zegura</lang>
    <lang code="bnt">Zigoua</lang>
    <lang code="bnt">Zigua</lang>
    <lang code="bnt">Zigwa</lang>
    <lang code="bnt">Zinza</lang>
    <lang code="bnt">Dzinda</lang>
    <lang code="bnt">Dzindza</lang>
    <lang code="bnt">Echidzindza</lang>
    <lang code="bnt">Echijinja</lang>
    <lang code="bnt">Eciinja</lang>
    <lang code="bnt">Ecizinza</lang>
    <lang code="bnt">Jinja</lang>
    <lang code="bnt">Kizinza</lang>
    <lang code="bnt">Luzinza</lang>
    <lang code="bnt">Zinja</lang>
    <lang code="bas">Basa</lang>
    <lang code="bak">Bashkir</lang>
    <lang code="baq">Basque</lang>
    <lang code="baq">Euskara</lang>
    <lang code="btk">Batak</lang>
    <lang code="btk">Batta (Sumatra)</lang>
    <lang code="btk">Alas</lang>
    <lang code="btk">Angkola</lang>
    <lang code="btk">Dairi Pakpak</lang>
    <lang code="btk">Pakpak</lang>
    <lang code="btk">Karo-Batak</lang>
    <lang code="btk">Mandailing</lang>
    <lang code="btk">Batak Mandailing</lang>
    <lang code="btk">Simelungun</lang>
    <lang code="btk">Toba-Batak</lang>
    <lang code="bej">Beja</lang>
    <lang code="bej">Bedawiye</lang>
    <lang code="bej">Bedja</lang>
    <lang code="bej">Bishári</lang>
    <lang code="bel">Belarusian</lang>
    <lang code="bel">Belarusan</lang>
    <lang code="bel">Belorussian</lang>
    <lang code="bel">Byelorussian</lang>
    <lang code="bel">Russian, White</lang>
    <lang code="bel">Ruthenian, White</lang>
    <lang code="bel">White Russian</lang>
    <lang code="bel">White Ruthenian</lang>
    <lang code="bem">Bemba</lang>
    <lang code="ben">Bengali</lang>
    <lang code="ben">Banga-Bhasa</lang>
    <lang code="ben">Bangala</lang>
    <lang code="ben">Bangla</lang>
    <lang code="ben">Sylheti</lang>
    <lang code="ben">Sylhet</lang>
    <lang code="ben">Sylhetti Bangla</lang>
    <lang code="ber">Berber (Other)</lang>
    <lang code="ber">Mzab</lang>
    <lang code="ber">Mozabite</lang>
    <lang code="ber">Rif</lang>
    <lang code="ber">Northern Shilha</lang>
    <lang code="ber">Shilha, Northern</lang>
    <lang code="ber">Tarifit</lang>
    <lang code="ber">Shilha</lang>
    <lang code="ber">Chleuh</lang>
    <lang code="ber">Sölha</lang>
    <lang code="ber">Tachelhait</lang>
    <lang code="ber">Tashelhiyt</lang>
    <lang code="ber">Tamazight</lang>
    <lang code="ber">Taznatit</lang>
    <lang code="ber">Gourara</lang>
    <lang code="ber">Gurara-Berberisch</lang>
    <lang code="ber">Gurara language</lang>
    <lang code="ber">Tazenatit</lang>
    <lang code="bho">Bhojpuri</lang>
    <lang code="bho">Bajpuri</lang>
    <lang code="bho">Bhojapuri</lang>
    <lang code="bho">Bhozpuri</lang>
    <lang code="bho">Bihari (Bhojpuri)</lang>
    <lang code="bho">Deswali (Bhojpuri)</lang>
    <lang code="bho">Khotla</lang>
    <lang code="bho">Piscimas</lang>
    <lang code="bho">Sadani</lang>
    <lang code="bho">Chota Nagpuri</lang>
    <lang code="bho">Chotar Nagpuri</lang>
    <lang code="bho">Dikku Kaji</lang>
    <lang code="bho">Dikkukaji</lang>
    <lang code="bho">Nagpuri (Bhojpuri)</lang>
    <lang code="bho">Nagpuriā</lang>
    <lang code="bho">Napuria</lang>
    <lang code="bho">Sadan</lang>
    <lang code="bho">Sadari</lang>
    <lang code="bho">Sadati</lang>
    <lang code="bho">Sadhan</lang>
    <lang code="bho">Sadhana</lang>
    <lang code="bho">Sadharan</lang>
    <lang code="bho">Sadna</lang>
    <lang code="bho">Sadri</lang>
    <lang code="bho">Sadrik</lang>
    <lang code="bho">Santri</lang>
    <lang code="bho">Siddri</lang>
    <lang code="bho">Sradri</lang>
    <lang code="bho">Western Standard Bhojpuri</lang>
    <lang code="bho">Benarsi</lang>
    <lang code="bho">Bhojpuri, Western Standard</lang>
    <lang code="bho">Purbi</lang>
    <lang code="bih">Bihari (Other)</lang>
    <lang code="bih">Behari</lang>
    <lang code="bih">Bajjika</lang>
    <lang code="bih">Kudmali</lang>
    <lang code="bih">Bedia</lang>
    <lang code="bih">Dharua</lang>
    <lang code="bih">Khotta (Kurmali)</lang>
    <lang code="bih">Kurma</lang>
    <lang code="bih">Kurmali</lang>
    <lang code="bih">Kurmali Thar</lang>
    <lang code="bih">Kurmik</lang>
    <lang code="bih">Kurni</lang>
    <lang code="bih">Kurumali</lang>
    <lang code="bih">Panchpargania</lang>
    <lang code="bih">Bedia (Panchpargania)</lang>
    <lang code="bih">Chik Barik</lang>
    <lang code="bih">Pan</lang>
    <lang code="bih">Pan Sawasi</lang>
    <lang code="bih">Tair</lang>
    <lang code="bih">Tamara</lang>
    <lang code="bih">Tamaria</lang>
    <lang code="bih">Tanti</lang>
    <lang code="bih">Temoral</lang>
    <lang code="bih">Tumariya</lang>
    <lang code="bik">Bikol</lang>
    <lang code="bik">Vikol</lang>
    <lang code="byn">Bilin</lang>
    <lang code="bis">Bislama</lang>
    <lang code="bis">Beach-la-mar</lang>
    <lang code="bis">Bêche-de-mer</lang>
    <lang code="bis">Bichelamar</lang>
    <lang code="zbl">Blissymbolics</lang>
    <lang code="bos">Bosnian</lang>
    <lang code="bra">Braj</lang>
    <lang code="bra">Braj bhākhā</lang>
    <lang code="bra">Braj bhāshā</lang>
    <lang code="bra">Pingal</lang>
    <lang code="bre">Breton</lang>
    <lang code="bre">Armoric</lang>
    <lang code="bug">Bugis</lang>
    <lang code="bug">Buginese</lang>
    <lang code="bul">Bulgarian</lang>
    <lang code="bua">Buriat</lang>
    <lang code="bua">Buryat</lang>
    <lang code="bua">Mongolian, Northern</lang>
    <lang code="bua">Northern Mongolian</lang>
    <lang code="bur">Burmese</lang>
    <lang code="cad">Caddo</lang>
    <lang code="car">Carib</lang>
    <lang code="car">Galibi</lang>
    <lang code="cat">Catalan</lang>
    <lang code="cat">Majorcan Catalan</lang>
    <lang code="cat">Catalan, Majorcan</lang>
    <lang code="cat">Valencian Catalan</lang>
    <lang code="cat">Catalan, Valencian</lang>
    <lang code="cau">Caucasian (Other)</lang>
    <lang code="cau">Abazin</lang>
    <lang code="cau">Bats</lang>
    <lang code="cau">Bac</lang>
    <lang code="cau">Tsova-Tush</lang>
    <lang code="cau">Tush</lang>
    <lang code="cau">Bezhta</lang>
    <lang code="cau">Botlikh</lang>
    <lang code="cau">Budukh</lang>
    <lang code="cau">Chamalal</lang>
    <lang code="cau">Dido</lang>
    <lang code="cau">Tsez</lang>
    <lang code="cau">Ginukh</lang>
    <lang code="cau">Ginukhtsy</lang>
    <lang code="cau">Ginux</lang>
    <lang code="cau">Hinukh</lang>
    <lang code="cau">Hinux</lang>
    <lang code="cau">Hunzib</lang>
    <lang code="cau">Gunzib</lang>
    <lang code="cau">Kubachi</lang>
    <lang code="cau">Lak</lang>
    <lang code="cau">Laz</lang>
    <lang code="cau">Chan</lang>
    <lang code="cau">Chanuri</lang>
    <lang code="cau">Chanzan</lang>
    <lang code="cau">Laze</lang>
    <lang code="cau">Lazian</lang>
    <lang code="cau">Lazuri</lang>
    <lang code="cau">Zan</lang>
    <lang code="cau">Mingrelian</lang>
    <lang code="cau">Svan</lang>
    <lang code="cau">Tabasaran</lang>
    <lang code="cau">Tsakhur</lang>
    <lang code="cau">Ubykh</lang>
    <lang code="cau">Oubykh</lang>
    <lang code="cau">Udi</lang>
    <lang code="ceb">Cebuano</lang>
    <lang code="ceb">Binisaya</lang>
    <lang code="ceb">Bisayan</lang>
    <lang code="ceb">Sebuano</lang>
    <lang code="ceb">Sinugboanon</lang>
    <lang code="ceb">Sugbuanon</lang>
    <lang code="ceb">Sugbuhanon</lang>
    <lang code="ceb">Visayan</lang>
    <lang code="cel">Celtic (Other)</lang>
    <lang code="cel">Celtiberian</lang>
    <lang code="cel">Celti-Iberian</lang>
    <lang code="cel">Celto-Iberian</lang>
    <lang code="cel">Gaulish</lang>
    <lang code="cel">Gallic</lang>
    <lang code="cel">Proto-Celtic</lang>
    <lang code="cel">Common Celtic</lang>
    <lang code="cel">Welsh, Middle (ca. 1100-1400)</lang>
    <lang code="cel">Middle Welsh (ca. 1100-1400)</lang>
    <lang code="cel">Welsh, Old (to 1100)</lang>
    <lang code="cel">Old Welsh (to 1100)</lang>
    <lang code="cai">Central American Indian (Other)</lang>
    <lang code="cai">Amuzgo</lang>
    <lang code="cai">Amishgo</lang>
    <lang code="cai">Boruca</lang>
    <lang code="cai">Brunka</lang>
    <lang code="cai">Burunca</lang>
    <lang code="cai">Bribri</lang>
    <lang code="cai">Cabecar</lang>
    <lang code="cai">Cahita</lang>
    <lang code="cai">Cahuilla</lang>
    <lang code="cai">Coahuila</lang>
    <lang code="cai">Kawia (Shoshone)</lang>
    <lang code="cai">Chatino</lang>
    <lang code="cai">Chiapanec</lang>
    <lang code="cai">Chinantecan languages</lang>
    <lang code="cai">Chocho</lang>
    <lang code="cai">Chontal</lang>
    <lang code="cai">Tequistlateca</lang>
    <lang code="cai">Cochimi</lang>
    <lang code="cai">Comanche</lang>
    <lang code="cai">Cora</lang>
    <lang code="cai">Chora</lang>
    <lang code="cai">Nayarita</lang>
    <lang code="cai">Cuicatec</lang>
    <lang code="cai">Cuitlateco</lang>
    <lang code="cai">Teco (Cuitlateco)</lang>
    <lang code="cai">Cupeño</lang>
    <lang code="cai">Eudeve</lang>
    <lang code="cai">Batuco</lang>
    <lang code="cai">Dohema</lang>
    <lang code="cai">Hegue</lang>
    <lang code="cai">Garifuna</lang>
    <lang code="cai">Black Carib</lang>
    <lang code="cai">Carib, Black</lang>
    <lang code="cai">Guarijío</lang>
    <lang code="cai">Huarijío</lang>
    <lang code="cai">Warijío</lang>
    <lang code="cai">Guatuso</lang>
    <lang code="cai">Maléku Jaíka</lang>
    <lang code="cai">Guaymi</lang>
    <lang code="cai">Hopi</lang>
    <lang code="cai">Moki</lang>
    <lang code="cai">Huave</lang>
    <lang code="cai">Huichol</lang>
    <lang code="cai">Guichola</lang>
    <lang code="cai">Ixcateco</lang>
    <lang code="cai">Jicaque</lang>
    <lang code="cai">Tol</lang>
    <lang code="cai">Torrupan</lang>
    <lang code="cai">Xicaque</lang>
    <lang code="cai">Kawaiisu</lang>
    <lang code="cai">Kiowa</lang>
    <lang code="cai">Kayowe</lang>
    <lang code="cai">Lenca</lang>
    <lang code="cai">Mangue</lang>
    <lang code="cai">Choluteca</lang>
    <lang code="cai">Matagalpa</lang>
    <lang code="cai">Cacaopera</lang>
    <lang code="cai">Mayo (Piman)</lang>
    <lang code="cai">Mazateco</lang>
    <lang code="cai">Miskito</lang>
    <lang code="cai">Mosquito</lang>
    <lang code="cai">Mixe</lang>
    <lang code="cai">Ayook</lang>
    <lang code="cai">Mixtec</lang>
    <lang code="cai">Opata</lang>
    <lang code="cai">Panamint</lang>
    <lang code="cai">Coso</lang>
    <lang code="cai">Koso</lang>
    <lang code="cai">Tümpisa</lang>
    <lang code="cai">Pima</lang>
    <lang code="cai">Popoloca</lang>
    <lang code="cai">Rama</lang>
    <lang code="cai">Seri</lang>
    <lang code="cai">Serrano</lang>
    <lang code="cai">Maarrenga'twich</lang>
    <lang code="cai">Sierra Popoluca</lang>
    <lang code="cai">Highland Popoluca</lang>
    <lang code="cai">Popoluca, Highland</lang>
    <lang code="cai">Popoluca of Vera Cruz</lang>
    <lang code="cai">Southern Paiute</lang>
    <lang code="cai">Paiute, Southern</lang>
    <lang code="cai">Sumo</lang>
    <lang code="cai">Tarahumara</lang>
    <lang code="cai">Rarámuri</lang>
    <lang code="cai">Tarascan</lang>
    <lang code="cai">Michoacana</lang>
    <lang code="cai">Phurhembe</lang>
    <lang code="cai">Purepecha</lang>
    <lang code="cai">Tepehuan</lang>
    <lang code="cai">O'dam</lang>
    <lang code="cai">Terraba</lang>
    <lang code="cai">Teribe</lang>
    <lang code="cai">Tirribi</lang>
    <lang code="cai">Tewa</lang>
    <lang code="cai">Tlapanec</lang>
    <lang code="cai">Chocho (Tlapanec)</lang>
    <lang code="cai">Tiapaneco</lang>
    <lang code="cai">Tohono O'odham</lang>
    <lang code="cai">Papago</lang>
    <lang code="cai">Totonac</lang>
    <lang code="cai">Trique</lang>
    <lang code="cai">Ulva</lang>
    <lang code="cai">Woolwa</lang>
    <lang code="cai">Wulwa</lang>
    <lang code="cai">Ute</lang>
    <lang code="cai">Xinca</lang>
    <lang code="cai">Ikomagi</lang>
    <lang code="cai">Jinca</lang>
    <lang code="cai">Shinca</lang>
    <lang code="cai">Sinca</lang>
    <lang code="cai">Szinca</lang>
    <lang code="cai">Xincan</lang>
    <lang code="cai">Xinka</lang>
    <lang code="cai">Yaqui</lang>
    <lang code="cai">Zoque</lang>
    <lang code="cai">Soke</lang>
    <lang code="chg">Chagatai</lang>
    <lang code="chg">Dschagatai</lang>
    <lang code="chg">Jagataic</lang>
    <lang code="chg">Old Uzbek</lang>
    <lang code="chg">Tschagatai</lang>
    <lang code="chg">Uzbek, Old</lang>
    <lang code="cmc">Chamic languages</lang>
    <lang code="cmc">Cham</lang>
    <lang code="cmc">Čam</lang>
    <lang code="cmc">Haroi</lang>
    <lang code="cmc">Jarai</lang>
    <lang code="cmc">Rade</lang>
    <lang code="cmc">Ede</lang>
    <lang code="cmc">Rhade</lang>
    <lang code="cmc">Roglai</lang>
    <lang code="cha">Chamorro</lang>
    <lang code="cha">Tjamoro</lang>
    <lang code="che">Chechen</lang>
    <lang code="che">Tchetchen</lang>
    <lang code="chr">Cherokee</lang>
    <lang code="chy">Cheyenne</lang>
    <lang code="chb">Chibcha</lang>
    <lang code="chi">Chinese</lang>
    <lang code="chi">Cantonese</lang>
    <lang code="chi">Mandarin</lang>
    <lang code="chn">Chinook jargon</lang>
    <lang code="chn">Chinook pidgin</lang>
    <lang code="chp">Chipewyan</lang>
    <lang code="chp">Dene (Chipewyan)</lang>
    <lang code="chp">Montagnais (Athapascan)</lang>
    <lang code="cho">Choctaw</lang>
    <lang code="cho">Chahta</lang>
    <lang code="chu">Church Slavic</lang>
    <lang code="chu">Bulgarian, Old (to 1100)</lang>
    <lang code="chu">Old Bulgarian (to 1100)</lang>
    <lang code="chu">Old Church Slavic</lang>
    <lang code="chu">Old Slovenian</lang>
    <lang code="chu">Slavonic, Old Church</lang>
    <lang code="chu">Slovenian, Old</lang>
    <lang code="chk">Chuukese</lang>
    <lang code="chk">Truk</lang>
    <lang code="chv">Chuvash</lang>
    <lang code="cop">Coptic</lang>
    <lang code="cor">Cornish</lang>
    <lang code="cos">Corsican</lang>
    <lang code="cos">Corse</lang>
    <lang code="cos">Corsi</lang>
    <lang code="cos">Corso</lang>
    <lang code="cos">Corsu</lang>
    <lang code="cre">Cree</lang>
    <lang code="cre">Cris</lang>
    <lang code="cre">Knistenaux</lang>
    <lang code="cre">Maskegon</lang>
    <lang code="mus">Creek</lang>
    <lang code="mus">Maskoki</lang>
    <lang code="mus">Muscogee</lang>
    <lang code="crp">Creoles and Pidgins (Other)</lang>
    <lang code="crp">Pidgins</lang>
    <lang code="crp">Ambonese Malay</lang>
    <lang code="crp">Malay, Ambonese</lang>
    <lang code="crp">Betawi</lang>
    <lang code="crp">Batawi</lang>
    <lang code="crp">Jakarta Malay</lang>
    <lang code="crp">Malay, Jakarta</lang>
    <lang code="crp">Chabacano</lang>
    <lang code="crp">Chavacano</lang>
    <lang code="crp">Zamboangueño</lang>
    <lang code="crp">Fanakalo</lang>
    <lang code="crp">Fanagalo</lang>
    <lang code="crp">Pidgin Kaffir</lang>
    <lang code="crp">Kituba (Congo (Democratic Republic))</lang>
    <lang code="crp">Kibulamatadi</lang>
    <lang code="crp">Kikongo Commercial</lang>
    <lang code="crp">Kikongo-Kutuba</lang>
    <lang code="crp">Kikongo Simplifié</lang>
    <lang code="crp">Kikongo ya Leta</lang>
    <lang code="crp">Kikwango</lang>
    <lang code="crp">Kileta</lang>
    <lang code="crp">Naga Pidgin</lang>
    <lang code="crp">Nagamese</lang>
    <lang code="crp">Petjo</lang>
    <lang code="crp">Pecok</lang>
    <lang code="crp">Petjoh</lang>
    <lang code="crp">Petjok</lang>
    <lang code="crp">San Basilio del Palenque Spanish Creole</lang>
    <lang code="crp">Palenquero (Colombia)</lang>
    <lang code="crp">Spanish Creole, San Basilio del Palenque</lang>
    <lang code="crp">Unami jargon</lang>
    <lang code="cpe">Creoles and Pidgins, English-based (Other)</lang>
    <lang code="cpe">Bamyili Creole</lang>
    <lang code="cpe">Djuka</lang>
    <lang code="cpe">Aucaans</lang>
    <lang code="cpe">Aukan</lang>
    <lang code="cpe">Djoeka</lang>
    <lang code="cpe">Ndjuka</lang>
    <lang code="cpe">English-based Creoles and Pidgins (Other)</lang>
    <lang code="cpe">Fitzroy Valley Kriol</lang>
    <lang code="cpe">Hawaiian Pidgin English</lang>
    <lang code="cpe">Jamaican Creole</lang>
    <lang code="cpe">Krio</lang>
    <lang code="cpe">Aku (Creole)</lang>
    <lang code="cpe">Kriol</lang>
    <lang code="cpe">Pijin</lang>
    <lang code="cpe">Neo-Solomonic</lang>
    <lang code="cpe">Solomons Pidgin</lang>
    <lang code="cpe">Pidgin English</lang>
    <lang code="cpe">Saramaccan</lang>
    <lang code="cpe">Sea Islands Creole</lang>
    <lang code="cpe">Geechee</lang>
    <lang code="cpe">Gullah</lang>
    <lang code="cpf">Creoles and Pidgins, French-based (Other)</lang>
    <lang code="cpf">French-based Creoles and Pidgins (Other)</lang>
    <lang code="cpf">Dominican French Creole</lang>
    <lang code="cpf">French Creole, Dominican</lang>
    <lang code="cpf">Louisiana French Creole</lang>
    <lang code="cpf">French Creole, Louisiana</lang>
    <lang code="cpf">Mauritian French Creole</lang>
    <lang code="cpf">French Creole, Mauritian</lang>
    <lang code="cpf">Michif</lang>
    <lang code="cpf">Cree, French</lang>
    <lang code="cpf">French Cree</lang>
    <lang code="cpf">Mitchif</lang>
    <lang code="cpf">Reunionese French Creole</lang>
    <lang code="cpf">French Creole, Reunionese</lang>
    <lang code="cpf">Seychellois French Creole</lang>
    <lang code="cpf">French Creole, Seychellois</lang>
    <lang code="cpp">Creoles and Pidgins, Portuguese-based (Other)</lang>
    <lang code="cpp">Portuguese-based Creoles and Pidgins (Other)</lang>
    <lang code="cpp">Annobon</lang>
    <lang code="cpp">Ambu</lang>
    <lang code="cpp">Cape Verde Creole</lang>
    <lang code="cpp">Brava Island Creole</lang>
    <lang code="cpp">Crioulo</lang>
    <lang code="cpp">Indo-Portuguese</lang>
    <lang code="cpp">Ceylon Portuguese</lang>
    <lang code="crh">Crimean Tatar</lang>
    <lang code="crh">Crimean Turkish</lang>
    <lang code="crh">Tatar, Crimean</lang>
    <lang code="crh">Turkish, Crimean</lang>
    <lang code="hrv">Croatian</lang>
    <lang code="scr" status="obsolete">Croatian</lang>
    <lang code="cus">Cushitic (Other)</lang>
    <lang code="cus">Alaba</lang>
    <lang code="cus">Alaaba</lang>
    <lang code="cus">Allaaba</lang>
    <lang code="cus">Halaba</lang>
    <lang code="cus">Burji</lang>
    <lang code="cus">Dasenech</lang>
    <lang code="cus">Geleb</lang>
    <lang code="cus">Marille</lang>
    <lang code="cus">Gedeo</lang>
    <lang code="cus">Darasa</lang>
    <lang code="cus">Derasa</lang>
    <lang code="cus">Hadiya</lang>
    <lang code="cus">Iraqw</lang>
    <lang code="cus">Kambata</lang>
    <lang code="cus">Qebena</lang>
    <lang code="cus">K'abena</lang>
    <lang code="cus">Kebena</lang>
    <lang code="cus">Qabena</lang>
    <lang code="cus">Womba</lang>
    <lang code="cus">Wombi Afoo</lang>
    <lang code="cus">Wombisanat</lang>
    <lang code="cus">Rendille</lang>
    <lang code="cus">Tunni</lang>
    <lang code="cze">Czech</lang>
    <lang code="cze">Bohemian</lang>
    <lang code="dak">Dakota</lang>
    <lang code="dak">Sioux</lang>
    <lang code="dak">Assiniboine</lang>
    <lang code="dak">Lakota</lang>
    <lang code="dak">Teton</lang>
    <lang code="dak">Santee</lang>
    <lang code="dak">Yankton</lang>
    <lang code="dan">Danish</lang>
    <lang code="dar">Dargwa</lang>
    <lang code="dar">Darghi</lang>
    <lang code="dar">Dargin</lang>
    <lang code="day">Dayak</lang>
    <lang code="day">Bidayuh</lang>
    <lang code="day">Bideyu</lang>
    <lang code="day">Dajak</lang>
    <lang code="day">Dyak</lang>
    <lang code="day">Kendayan</lang>
    <lang code="day">Land Dayak</lang>
    <lang code="day">Biatah</lang>
    <lang code="del">Delaware</lang>
    <lang code="del">Lenape</lang>
    <lang code="del">Lenni Lenape</lang>
    <lang code="del">Munsee</lang>
    <lang code="del">Minsi</lang>
    <lang code="din">Dinka</lang>
    <lang code="din">Denca</lang>
    <lang code="div">Divehi</lang>
    <lang code="div">Dhivehi</lang>
    <lang code="div">Maldivian</lang>
    <lang code="doi">Dogri</lang>
    <lang code="doi">Dhogaryali</lang>
    <lang code="doi">Dogari</lang>
    <lang code="doi">Dogra</lang>
    <lang code="doi">Dogri Jammu</lang>
    <lang code="doi">Dogri-Kangri</lang>
    <lang code="doi">Dogri Pahari</lang>
    <lang code="doi">Dongari</lang>
    <lang code="doi">Hindi Dogri</lang>
    <lang code="doi">Tokkaru</lang>
    <lang code="doi">Kangri</lang>
    <lang code="doi">Kangari</lang>
    <lang code="doi">Kangra</lang>
    <lang code="dgr">Dogrib</lang>
    <lang code="dgr">Thlingchadinne</lang>
    <lang code="dra">Dravidian (Other)</lang>
    <lang code="dra">Abujhmaria</lang>
    <lang code="dra">Alu Kurumba</lang>
    <lang code="dra">Brahui</lang>
    <lang code="dra">Berouhi</lang>
    <lang code="dra">Birohi</lang>
    <lang code="dra">Brohki</lang>
    <lang code="dra">Gadaba (Dravidian)</lang>
    <lang code="dra">Gadba (Dravidian)</lang>
    <lang code="dra">Gudwa (Dravidian)</lang>
    <lang code="dra">Gutob (Dravidian)</lang>
    <lang code="dra">Konekor Gadaba</lang>
    <lang code="dra">Ollari</lang>
    <lang code="dra">Salur</lang>
    <lang code="dra">Kodagu</lang>
    <lang code="dra">Coorg</lang>
    <lang code="dra">Kodava</lang>
    <lang code="dra">Kurg</lang>
    <lang code="dra">Kolami</lang>
    <lang code="dra">Kota (India)</lang>
    <lang code="dra">Kui (Dravidian)</lang>
    <lang code="dra">Kanda (India)</lang>
    <lang code="dra">Kandh</lang>
    <lang code="dra">Kandha</lang>
    <lang code="dra">Khand</lang>
    <lang code="dra">Khond (Kui)</lang>
    <lang code="dra">Khondi (Kui)</lang>
    <lang code="dra">Khondo</lang>
    <lang code="dra">Kodu (India)</lang>
    <lang code="dra">Kodulu</lang>
    <lang code="dra">Kuinga</lang>
    <lang code="dra">Kuy (India)</lang>
    <lang code="dra">Kuvi</lang>
    <lang code="dra">Malto</lang>
    <lang code="dra">Manda (Dravidian)</lang>
    <lang code="dra">Pengo</lang>
    <lang code="dra">Toda (India)</lang>
    <lang code="dra">Tuda (India)</lang>
    <lang code="dra">Tulu</lang>
    <lang code="dua">Duala</lang>
    <lang code="dua">Douala</lang>
    <lang code="dut">Dutch</lang>
    <lang code="dut">Flemish</lang>
    <lang code="dut">Netherlandic</lang>
    <lang code="dum">Dutch, Middle (ca. 1050-1350)</lang>
    <lang code="dum">Diets</lang>
    <lang code="dum">Middle Dutch</lang>
    <lang code="dyu">Dyula</lang>
    <lang code="dyu">Dioula</lang>
    <lang code="dyu">Diula</lang>
    <lang code="dyu">Jula</lang>
    <lang code="dzo">Dzongkha</lang>
    <lang code="dzo">Bhotia of Bhutan</lang>
    <lang code="dzo">Bhutanese</lang>
    <lang code="dzo">Drukha</lang>
    <lang code="dzo">Drukke</lang>
    <lang code="dzo">Dukpa</lang>
    <lang code="dzo">Hloka</lang>
    <lang code="dzo">Jonkha</lang>
    <lang code="dzo">Lhoka</lang>
    <lang code="dzo">Lhoke</lang>
    <lang code="dzo">Lhoskad</lang>
    <lang code="dzo">Ngalopkha</lang>
    <lang code="dzo">Zongkhar</lang>
    <lang code="dzo">Zonkar</lang>
    <lang code="frs">East Frisian</lang>
    <lang code="frs">Frisian, East</lang>
    <lang code="bin">Edo</lang>
    <lang code="bin">Bini</lang>
    <lang code="efi">Efik</lang>
    <lang code="efi">Calabar</lang>
    <lang code="efi">Ibibio</lang>
    <lang code="egy">Egyptian</lang>
    <lang code="egy">Demotic</lang>
    <lang code="egy">Hieratic</lang>
    <lang code="egy">Hieroglyphics (Egyptian)</lang>
    <lang code="eka">Ekajuk</lang>
    <lang code="elx">Elamite</lang>
    <lang code="elx">Amardic</lang>
    <lang code="elx">Anzanic</lang>
    <lang code="elx">Susian</lang>
    <lang code="eng">English</lang>
    <lang code="enm">English, Middle (1100-1500)</lang>
    <lang code="enm">Middle English</lang>
    <lang code="ang">English, Old (ca. 450-1100)</lang>
    <lang code="ang">Anglo-Saxon</lang>
    <lang code="ang">Old English</lang>
    <lang code="ang">West Saxon</lang>
    <lang code="myv">Erzya</lang>
    <lang code="esk" status="obsolete">Eskimo languages</lang>
    <lang code="epo">Esperanto</lang>
    <lang code="esp" status="obsolete">Esperanto</lang>
    <lang code="est">Estonian</lang>
    <lang code="est">Seto</lang>
    <lang code="est">Setu</lang>
    <lang code="est">Võro</lang>
    <lang code="est">Võru</lang>
    <lang code="est">Werro</lang>
    <lang code="gez">Ethiopic</lang>
    <lang code="gez">Geez</lang>
    <lang code="eth" status="obsolete">Ethiopic</lang>
    <lang code="ewe">Ewe</lang>
    <lang code="ewo">Ewondo</lang>
    <lang code="ewo">Jaunde</lang>
    <lang code="ewo">Yaounde</lang>
    <lang code="ewo">Yaunde</lang>
    <lang code="fan">Fang</lang>
    <lang code="fan">Fan (Bantu)</lang>
    <lang code="fat">Fanti</lang>
    <lang code="fao">Faroese</lang>
    <lang code="fao">Faeroese</lang>
    <lang code="far" status="obsolete">Faroese</lang>
    <lang code="fij">Fijian</lang>
    <lang code="fij">Viti</lang>
    <lang code="fil">Filipino</lang>
    <lang code="fin">Finnish</lang>
    <lang code="fiu">Finno-Ugrian (Other)</lang>
    <lang code="fiu">Ingrian</lang>
    <lang code="fiu">Izhorskii</lang>
    <lang code="fiu">Khanty</lang>
    <lang code="fiu">Ostiak</lang>
    <lang code="fiu">Xanty</lang>
    <lang code="fiu">Livonian</lang>
    <lang code="fiu">Ludic</lang>
    <lang code="fiu">Lydi</lang>
    <lang code="fiu">Mansi</lang>
    <lang code="fiu">Vogul</lang>
    <lang code="fiu">Mordvin</lang>
    <lang code="fiu">Mordva</lang>
    <lang code="fiu">Mordvinian</lang>
    <lang code="fiu">Veps</lang>
    <lang code="fon">Fon</lang>
    <lang code="fon">Dahoman</lang>
    <lang code="fon">Djedji</lang>
    <lang code="fon">Jeji</lang>
    <lang code="fre">French</lang>
    <lang code="fre">Allevard French</lang>
    <lang code="fre">French, Allevard</lang>
    <lang code="fre">Judeo-French</lang>
    <lang code="fre">Western Loez</lang>
    <lang code="fre">Zarphatic</lang>
    <lang code="fre">Morvan French</lang>
    <lang code="fre">French, Morvan</lang>
    <lang code="fre">Poitevin French</lang>
    <lang code="fre">French, Poitevin</lang>
    <lang code="fre">Saintongeais French</lang>
    <lang code="fre">French, Saintongeais</lang>
    <lang code="frm">French, Middle (ca. 1300-1600)</lang>
    <lang code="frm">Middle French</lang>
    <lang code="fro">French, Old (ca. 842-1300)</lang>
    <lang code="fro">Old French</lang>
    <lang code="fry">Frisian</lang>
    <lang code="fry">Friesian</lang>
    <lang code="fry">West Frisian</lang>
    <lang code="fry">Stadsfries</lang>
    <lang code="fry">Stadfries</lang>
    <lang code="fry">Stedsk</lang>
    <lang code="fry">Town Frisian</lang>
    <lang code="fri" status="obsolete">Frisian</lang>
    <lang code="fur">Friulian</lang>
    <lang code="ful">Fula</lang>
    <lang code="ful">Adamawa</lang>
    <lang code="ful">Fulah</lang>
    <lang code="ful">Fulani</lang>
    <lang code="ful">Fulbe</lang>
    <lang code="ful">Fulfulde</lang>
    <lang code="ful">Peul</lang>
    <lang code="ful">Poul</lang>
    <lang code="ful">Bororo (West Africa)</lang>
    <lang code="ful">Pular</lang>
    <lang code="ful">Poular</lang>
    <lang code="ful">Toucouleur</lang>
    <lang code="ful">Tukolor</lang>
    <lang code="gaa">Gã</lang>
    <lang code="gaa">Acra</lang>
    <lang code="gaa">Incran</lang>
    <lang code="glg">Galician</lang>
    <lang code="glg">Gallegan</lang>
    <lang code="gag" status="obsolete">Galician</lang>
    <lang code="lug">Ganda</lang>
    <lang code="lug">Luganda</lang>
    <lang code="gay">Gayo</lang>
    <lang code="gba">Gbaya</lang>
    <lang code="gba">Baya</lang>
    <lang code="gba">Gbeya</lang>
    <lang code="geo">Georgian</lang>
    <lang code="geo">Ingilo</lang>
    <lang code="ger">German</lang>
    <lang code="ger">Ashkenazic German</lang>
    <lang code="ger">Hochdeutsch</lang>
    <lang code="ger">Judaeo-German (German)</lang>
    <lang code="ger">Judendeutsch</lang>
    <lang code="ger">Judeo-German (German)</lang>
    <lang code="ger">Jüdisch-Deutsch</lang>
    <lang code="ger">Jüdischdeutsch</lang>
    <lang code="ger">Alemannic</lang>
    <lang code="ger">Alamannic</lang>
    <lang code="ger">Alemannisch</lang>
    <lang code="ger">Allemannic</lang>
    <lang code="ger">Allemannisch</lang>
    <lang code="ger">Alsatian</lang>
    <lang code="ger">Schwyzerdütsch</lang>
    <lang code="ger">Cimbrian</lang>
    <lang code="ger">Tzimbro</lang>
    <lang code="ger">Zimbrisch</lang>
    <lang code="gmh">German, Middle High (ca. 1050-1500)</lang>
    <lang code="gmh">Middle High German</lang>
    <lang code="goh">German, Old High (ca. 750-1050)</lang>
    <lang code="goh">Old High German</lang>
    <lang code="gem">Germanic (Other)</lang>
    <lang code="gem">Danish, Old (to 1500)</lang>
    <lang code="gem">Old Danish</lang>
    <lang code="gem">Dutch, Old (to 1050)</lang>
    <lang code="gem">Franconian, Old Low</lang>
    <lang code="gem">Old Dutch</lang>
    <lang code="gem">Old Low Franconian</lang>
    <lang code="gem">Frisian, Old (to 1500)</lang>
    <lang code="gem">Old Frisian</lang>
    <lang code="gem">Lombard</lang>
    <lang code="gem">Old Saxon</lang>
    <lang code="gem">Low German, Old (ca. 850-1050)</lang>
    <lang code="gem">Old Low German (ca. 850-1050)</lang>
    <lang code="gem">Saxon, Old</lang>
    <lang code="gem">Pennsylvania German</lang>
    <lang code="gem">Swedish, Old (to 1550)</lang>
    <lang code="gem">Old Swedish</lang>
    <lang code="gem">Walser</lang>
    <lang code="gil">Gilbertese</lang>
    <lang code="gil">Arorai</lang>
    <lang code="gil">I-Kiribati</lang>
    <lang code="gil">Kiribatese</lang>
    <lang code="gon">Gondi</lang>
    <lang code="gor">Gorontalo</lang>
    <lang code="got">Gothic</lang>
    <lang code="grb">Grebo</lang>
    <lang code="grb">Gdebo</lang>
    <lang code="grb">Gedebo</lang>
    <lang code="grb">Krebo</lang>
    <lang code="grc">Greek, Ancient (to 1453)</lang>
    <lang code="grc">Ancient Greek</lang>
    <lang code="grc">Biblical Greek</lang>
    <lang code="grc">Byzantine Greek</lang>
    <lang code="grc">Classical Greek</lang>
    <lang code="grc">Greek, Biblical</lang>
    <lang code="grc">Greek, Byzantine</lang>
    <lang code="grc">Greek, Classical</lang>
    <lang code="grc">Greek, Hellenistic</lang>
    <lang code="grc">Greek, Medieval</lang>
    <lang code="grc">Greek, Patristic</lang>
    <lang code="grc">Greek (Koine)</lang>
    <lang code="grc">Hellenistic Greek</lang>
    <lang code="grc">Koine (Greek)</lang>
    <lang code="grc">Medieval Greek</lang>
    <lang code="grc">Patristic Greek</lang>
    <lang code="grc">Aeolic Greek</lang>
    <lang code="grc">Greek, Aeolic</lang>
    <lang code="grc">Attic Greek</lang>
    <lang code="grc">Greek, Attic</lang>
    <lang code="grc">Doric Greek</lang>
    <lang code="grc">Greek, Doric</lang>
    <lang code="grc">Ionic Greek</lang>
    <lang code="grc">Greek, Ionic</lang>
    <lang code="gre">Greek, Modern (1453- )</lang>
    <lang code="gre">East Cretan Greek</lang>
    <lang code="gre">Cretan Greek, East</lang>
    <lang code="gre">Greek, East Cretan</lang>
    <lang code="grn">Guarani</lang>
    <lang code="grn">Chiriguano</lang>
    <lang code="grn">Aba</lang>
    <lang code="grn">Camba</lang>
    <lang code="grn">Tembeta</lang>
    <lang code="grn">Chiripá</lang>
    <lang code="grn">Tsiripa</lang>
    <lang code="grn">Mbya</lang>
    <lang code="gua" status="obsolete">Guarani</lang>
    <lang code="guj">Gujarati</lang>
    <lang code="guj">Dhodia</lang>
    <lang code="guj">Dhobi</lang>
    <lang code="guj">Dhoḍiyā</lang>
    <lang code="guj">Dhore</lang>
    <lang code="guj">Dhowari</lang>
    <lang code="guj">Doria</lang>
    <lang code="guj">Gamit</lang>
    <lang code="guj">Gamati</lang>
    <lang code="guj">Gameti</lang>
    <lang code="guj">Gāmīta</lang>
    <lang code="guj">Gamith</lang>
    <lang code="guj">Gamta</lang>
    <lang code="guj">Gamti</lang>
    <lang code="guj">Gavit</lang>
    <lang code="guj">Halari</lang>
    <lang code="guj">Parsi-Gujarati</lang>
    <lang code="guj">Saurashtri</lang>
    <lang code="guj">Patanuli</lang>
    <lang code="guj">Patnuli</lang>
    <lang code="guj">Saurashtra</lang>
    <lang code="guj">Saurastra</lang>
    <lang code="guj">Sawrashtra</lang>
    <lang code="guj">Sourashtra</lang>
    <lang code="guj">Sowrashtra</lang>
    <lang code="guj">Sidi</lang>
    <lang code="gwi">Gwich'in</lang>
    <lang code="gwi">Kutchin</lang>
    <lang code="gwi">Loucheux</lang>
    <lang code="gwi">Takudh</lang>
    <lang code="gwi">Tukudh</lang>
    <lang code="hai">Haida</lang>
    <lang code="hai">Skittagetan</lang>
    <lang code="hat">Haitian French Creole</lang>
    <lang code="hat">French Creole, Haitian</lang>
    <lang code="hat">Kreyòl</lang>
    <lang code="hau">Hausa</lang>
    <lang code="haw">Hawaiian</lang>
    <lang code="heb">Hebrew</lang>
    <lang code="heb">Ancient Hebrew</lang>
    <lang code="her">Herero</lang>
    <lang code="her">Himba</lang>
    <lang code="her">Chimba</lang>
    <lang code="her">Cimba</lang>
    <lang code="her">Dhimba</lang>
    <lang code="her">Simba</lang>
    <lang code="her">Tjimba</lang>
    <lang code="hil">Hiligaynon</lang>
    <lang code="hil">Ilongo</lang>
    <lang code="hil">Panayan</lang>
    <lang code="hin">Hindi</lang>
    <lang code="hin">Badayuni</lang>
    <lang code="hin">Bagheli</lang>
    <lang code="hin">Bagelkhandi</lang>
    <lang code="hin">Bhugelkhud</lang>
    <lang code="hin">Ganggai</lang>
    <lang code="hin">Kawathi</lang>
    <lang code="hin">Kenat</lang>
    <lang code="hin">Kevat Boli</lang>
    <lang code="hin">Kevati</lang>
    <lang code="hin">Kewani</lang>
    <lang code="hin">Kewat</lang>
    <lang code="hin">Kewati</lang>
    <lang code="hin">Kewot</lang>
    <lang code="hin">Mandal</lang>
    <lang code="hin">Mannadi</lang>
    <lang code="hin">Riwai</lang>
    <lang code="hin">Bangaru</lang>
    <lang code="hin">Hariani</lang>
    <lang code="hin">Jatu</lang>
    <lang code="hin">Bundeli</lang>
    <lang code="hin">Bundelkhandi</lang>
    <lang code="hin">Chattisgarhi</lang>
    <lang code="hin">Chhattisgarhi</lang>
    <lang code="hin">Khalṭāhī</lang>
    <lang code="hin">Khatahi</lang>
    <lang code="hin">Laria</lang>
    <lang code="hin">Deswali</lang>
    <lang code="hin">Kanauji</lang>
    <lang code="hin">Bhakha</lang>
    <lang code="hin">Braj Kanauji</lang>
    <lang code="hin">Kannaujī</lang>
    <lang code="hin">Khari Boli</lang>
    <lang code="hin">Kauravī</lang>
    <lang code="hin">Khaṛībolī</lang>
    <lang code="hin">Kourvi</lang>
    <lang code="hin">Marari</lang>
    <lang code="hin">Pawari</lang>
    <lang code="hin">Powari</lang>
    <lang code="hin">Povārī</lang>
    <lang code="hmo">Hiri Motu</lang>
    <lang code="hmo">Police Motu</lang>
    <lang code="hit">Hittite</lang>
    <lang code="hmn">Hmong</lang>
    <lang code="hmn">Humung</lang>
    <lang code="hmn">Meo</lang>
    <lang code="hmn">Miao</lang>
    <lang code="hmn">Mong</lang>
    <lang code="hmn">Hmong Njua</lang>
    <lang code="hmn">Black Flowery Miao</lang>
    <lang code="hmn">Blue Miao</lang>
    <lang code="hmn">Green Hmong</lang>
    <lang code="hmn">Green Miao</lang>
    <lang code="hmn">Green Mong</lang>
    <lang code="hmn">Hmong Leng</lang>
    <lang code="hmn">Moob Ntsuab</lang>
    <lang code="hmn">Tak Meo</lang>
    <lang code="hmn">She</lang>
    <lang code="hmn">Ho Ne</lang>
    <lang code="hmn">Ho Nte</lang>
    <lang code="hmn">Huo Nte</lang>
    <lang code="hmn">She Yao</lang>
    <lang code="hmn">White Hmong</lang>
    <lang code="hmn">Hmong, White</lang>
    <lang code="hmn">Hmong Daw</lang>
    <lang code="hmn">Hmoob Dawb</lang>
    <lang code="hmn">Miao, White</lang>
    <lang code="hmn">White Miao</lang>
    <lang code="hun">Hungarian</lang>
    <lang code="hun">Magyar</lang>
    <lang code="hup">Hupa</lang>
    <lang code="iba">Iban</lang>
    <lang code="iba">Sea Dyak</lang>
    <lang code="ice">Icelandic</lang>
    <lang code="ido">Ido</lang>
    <lang code="ibo">Igbo</lang>
    <lang code="ibo">Ibo</lang>
    <lang code="ijo">Ijo</lang>
    <lang code="ijo">Djo</lang>
    <lang code="ijo">Dzo</lang>
    <lang code="ijo">Ejo</lang>
    <lang code="ijo">Ido (African)</lang>
    <lang code="ijo">Iyo (Nigeria)</lang>
    <lang code="ijo">Izo</lang>
    <lang code="ijo">Izon</lang>
    <lang code="ijo">Ojo</lang>
    <lang code="ijo">Oru</lang>
    <lang code="ijo">Udzo</lang>
    <lang code="ijo">Uzo</lang>
    <lang code="ijo">Ibani</lang>
    <lang code="ijo">Bonny</lang>
    <lang code="ijo">Ubani</lang>
    <lang code="ijo">Nembe</lang>
    <lang code="ijo">Nimbi</lang>
    <lang code="ilo">Iloko</lang>
    <lang code="ilo">Ilocano</lang>
    <lang code="smn">Inari Sami</lang>
    <lang code="smn">Finnish Lapp</lang>
    <lang code="smn">Lapp, Finnish</lang>
    <lang code="smn">Sami, Inari</lang>
    <lang code="inc">Indic (Other)</lang>
    <lang code="inc">Adiwasi Garasia</lang>
    <lang code="inc">Adivasi Garasia</lang>
    <lang code="inc">Ādivāsī Garāsiyā</lang>
    <lang code="inc">Adiwasi Girasia</lang>
    <lang code="inc">Adiwasi Gujarati</lang>
    <lang code="inc">Garasia Adivasi</lang>
    <lang code="inc">Ahirani</lang>
    <lang code="inc">Ahiri</lang>
    <lang code="inc">Apabhraṃśa</lang>
    <lang code="inc">Apabhramsha</lang>
    <lang code="inc">Avahattha</lang>
    <lang code="inc">Bashgali</lang>
    <lang code="inc">Bashgal</lang>
    <lang code="inc">Bashgari</lang>
    <lang code="inc">Kamtoz</lang>
    <lang code="inc">Katai</lang>
    <lang code="inc">Kati</lang>
    <lang code="inc">Bhantu</lang>
    <lang code="inc">Bhili</lang>
    <lang code="inc">Bote-Majhi</lang>
    <lang code="inc">Bote-Mahi</lang>
    <lang code="inc">Kushar</lang>
    <lang code="inc">Pakhe-Bote</lang>
    <lang code="inc">Chakma</lang>
    <lang code="inc">Chamthi</lang>
    <lang code="inc">Cāmaṭhī</lang>
    <lang code="inc">Chamtha</lang>
    <lang code="inc">Changari</lang>
    <lang code="inc">Chinali</lang>
    <lang code="inc">Chana (India)</lang>
    <lang code="inc">Channali</lang>
    <lang code="inc">Chinal</lang>
    <lang code="inc">Dagi</lang>
    <lang code="inc">Harijan</lang>
    <lang code="inc">Shipi</lang>
    <lang code="inc">Chodri</lang>
    <lang code="inc">Caudharī</lang>
    <lang code="inc">Chaudhari</lang>
    <lang code="inc">Chaudri</lang>
    <lang code="inc">Chodhari</lang>
    <lang code="inc">Choudhara</lang>
    <lang code="inc">Choudhary</lang>
    <lang code="inc">Chowdhary</lang>
    <lang code="inc">Danuwar Rai</lang>
    <lang code="inc">Denwar</lang>
    <lang code="inc">Dhanvar</lang>
    <lang code="inc">Dhanwar</lang>
    <lang code="inc">Donwar</lang>
    <lang code="inc">Darai</lang>
    <lang code="inc">Dehawali</lang>
    <lang code="inc">Dehavali</lang>
    <lang code="inc">Dehwali</lang>
    <lang code="inc">Domaaki</lang>
    <lang code="inc">Bericho</lang>
    <lang code="inc">Dom</lang>
    <lang code="inc">Doma</lang>
    <lang code="inc">Dumaki</lang>
    <lang code="inc">Dungra Bhil</lang>
    <lang code="inc">Dungari Bhili</lang>
    <lang code="inc">Dungri Bhili</lang>
    <lang code="inc">Fiji Hindi</lang>
    <lang code="inc">Hindi, Fiji</lang>
    <lang code="inc">Garasiya</lang>
    <lang code="inc">Garahaiya</lang>
    <lang code="inc">Girasia</lang>
    <lang code="inc">Garhwali</lang>
    <lang code="inc">Gadhavali</lang>
    <lang code="inc">Gadhawala</lang>
    <lang code="inc">Gadwahi</lang>
    <lang code="inc">Gashwali</lang>
    <lang code="inc">Girwali</lang>
    <lang code="inc">Godauli</lang>
    <lang code="inc">Gorwali</lang>
    <lang code="inc">Gurvali</lang>
    <lang code="inc">Pahari Garhwali</lang>
    <lang code="inc">Halbi</lang>
    <lang code="inc">Bastari</lang>
    <lang code="inc">Hindustani</lang>
    <lang code="inc">Indus Kohistani</lang>
    <lang code="inc">Khili</lang>
    <lang code="inc">Kohistani, Indus</lang>
    <lang code="inc">Kohiste</lang>
    <lang code="inc">Mair</lang>
    <lang code="inc">Maiya</lang>
    <lang code="inc">Maiyan</lang>
    <lang code="inc">Maiyon</lang>
    <lang code="inc">Shuthun</lang>
    <lang code="inc">Kalami</lang>
    <lang code="inc">Bashgharik</lang>
    <lang code="inc">Bashkarik</lang>
    <lang code="inc">Dir Kohistani</lang>
    <lang code="inc">Diri (Kalami)</lang>
    <lang code="inc">Dirwali</lang>
    <lang code="inc">Gaawro</lang>
    <lang code="inc">Garwa</lang>
    <lang code="inc">Garwi</lang>
    <lang code="inc">Gawri</lang>
    <lang code="inc">Gowri</lang>
    <lang code="inc">Kalam Kohistani</lang>
    <lang code="inc">Kalami Kohistani</lang>
    <lang code="inc">Kohistana</lang>
    <lang code="inc">Kohistani, Dir</lang>
    <lang code="inc">Kohistani, Kalam</lang>
    <lang code="inc">Kohistani, Kalami</lang>
    <lang code="inc">Khandesi</lang>
    <lang code="inc">Dhed Gujari</lang>
    <lang code="inc">Khandeshi</lang>
    <lang code="inc">Khandish</lang>
    <lang code="inc">Khowar</lang>
    <lang code="inc">Kumaoni</lang>
    <lang code="inc">Kamaoni</lang>
    <lang code="inc">Kumau</lang>
    <lang code="inc">Kumauni</lang>
    <lang code="inc">Kumawani</lang>
    <lang code="inc">Kumgoni</lang>
    <lang code="inc">Kumman</lang>
    <lang code="inc">Kunayaoni</lang>
    <lang code="inc">Kupia</lang>
    <lang code="inc">Valmiki</lang>
    <lang code="inc">Madari</lang>
    <lang code="inc">Mawchi</lang>
    <lang code="inc">Mauchi</lang>
    <lang code="inc">Māvacī</lang>
    <lang code="inc">Mavchi</lang>
    <lang code="inc">Mawachi</lang>
    <lang code="inc">Mawchi Bhil</lang>
    <lang code="inc">Mowchi</lang>
    <lang code="inc">Memoni</lang>
    <lang code="inc">Nayki</lang>
    <lang code="inc">Naiki</lang>
    <lang code="inc">Nāyakī</lang>
    <lang code="inc">Parya</lang>
    <lang code="inc">Tajuzbeki</lang>
    <lang code="inc">Rajbangsi</lang>
    <lang code="inc">Kamtapuri</lang>
    <lang code="inc">Rajbanshi</lang>
    <lang code="inc">Rajbansi</lang>
    <lang code="inc">Rajbongshi</lang>
    <lang code="inc">Rathvi</lang>
    <lang code="inc">Rāthavi</lang>
    <lang code="inc">Rathwi</lang>
    <lang code="inc">Shina</lang>
    <lang code="inc">Sheena</lang>
    <lang code="inc">Sina</lang>
    <lang code="inc">Suriname Hindustani</lang>
    <lang code="inc">Aili-Gaili</lang>
    <lang code="inc">Hindustani, Suriname</lang>
    <lang code="inc">Surinam Hindustani</lang>
    <lang code="inc">Sarnami Hindi</lang>
    <lang code="inc">Tharu</lang>
    <lang code="inc">Vaagri Boli</lang>
    <lang code="inc">Vanzari</lang>
    <lang code="inc">Vaṇajhārī</lang>
    <lang code="inc">Vanjhara</lang>
    <lang code="inc">Wanjhari</lang>
    <lang code="inc">Veddah (Sinhalese)</lang>
    <lang code="inc">Waigali</lang>
    <lang code="inc">Kalaṣa-alā</lang>
    <lang code="inc">Vaigalī</lang>
    <lang code="inc">Wai</lang>
    <lang code="inc">Wai-alā</lang>
    <lang code="inc">Waigelī</lang>
    <lang code="inc">Wotapuri-Katarqalai</lang>
    <lang code="inc">Katarqalai</lang>
    <lang code="ine">Indo-European (Other)</lang>
    <lang code="ine">Carian</lang>
    <lang code="ine">Dacian</lang>
    <lang code="ine">Daco-Mysian</lang>
    <lang code="ine">North Thracian</lang>
    <lang code="ine">Luwian</lang>
    <lang code="ine">Luian</lang>
    <lang code="ine">Lûish</lang>
    <lang code="ine">Luvian</lang>
    <lang code="ine">Lycian</lang>
    <lang code="ine">Lydian</lang>
    <lang code="ine">Macedonian (Ancient)</lang>
    <lang code="ine">Messapic</lang>
    <lang code="ine">Iapygian</lang>
    <lang code="ine">Messapian</lang>
    <lang code="ine">Palaic</lang>
    <lang code="ine">Balaic</lang>
    <lang code="ine">Palâ (Palaic)</lang>
    <lang code="ine">Palaite</lang>
    <lang code="ine">Palawi</lang>
    <lang code="ine">Phrygian</lang>
    <lang code="ine">Proto-Indo-European</lang>
    <lang code="ine">Proto-Aryan</lang>
    <lang code="ine">Protoindoeuropean</lang>
    <lang code="ine">Thracian</lang>
    <lang code="ine">Tokharian</lang>
    <lang code="ine">Kuchean</lang>
    <lang code="ine">Tocharian</lang>
    <lang code="ine">Tocharish</lang>
    <lang code="ine">Turfanish</lang>
    <lang code="ine">Venetic</lang>
    <lang code="ine">Yuezhi</lang>
    <lang code="ine">Yüeh-chih</lang>
    <lang code="ind">Indonesian</lang>
    <lang code="ind">Bahasa Indonesia</lang>
    <lang code="inh">Ingush</lang>
    <lang code="ina">Interlingua (International Auxiliary Language Association)</lang>
    <lang code="int" status="obsolete">Interlingua (International Auxiliary Language
      Association)</lang>
    <lang code="ile">Interlingue</lang>
    <lang code="ile">Occidental</lang>
    <lang code="iku">Inuktitut</lang>
    <lang code="iku">Inuit</lang>
    <lang code="iku">Inuvialuktun</lang>
    <lang code="iku">Kopagmiut</lang>
    <lang code="iku">Chiglit</lang>
    <lang code="iku">Siglit</lang>
    <lang code="ipk">Inupiaq</lang>
    <lang code="ipk">Inuit</lang>
    <lang code="ira">Iranian (Other)</lang>
    <lang code="ira">Bactrian</lang>
    <lang code="ira">Badzhuv</lang>
    <lang code="ira">Badschu</lang>
    <lang code="ira">Badžū</lang>
    <lang code="ira">Bāǰūī</lang>
    <lang code="ira">Bakhtiari</lang>
    <lang code="ira">Bakhtiyārī</lang>
    <lang code="ira">Baxtīarī</lang>
    <lang code="ira">Lori</lang>
    <lang code="ira">Lori-ye Khaveri</lang>
    <lang code="ira">Lur (Bakhtiari)</lang>
    <lang code="ira">Luri (Bakhtiari)</lang>
    <lang code="ira">Bartang</lang>
    <lang code="ira">Bartangi</lang>
    <lang code="ira">Ephthalite</lang>
    <lang code="ira">Hephthalite</lang>
    <lang code="ira">Gilaki</lang>
    <lang code="ira">Gelaki</lang>
    <lang code="ira">Gilan</lang>
    <lang code="ira">Gurani</lang>
    <lang code="ira">Awromani</lang>
    <lang code="ira">Gorani</lang>
    <lang code="ira">Hawramani</lang>
    <lang code="ira">Hawrami</lang>
    <lang code="ira">Hewrami</lang>
    <lang code="ira">Howrami</lang>
    <lang code="ira">Macho</lang>
    <lang code="ira">Hazaragi</lang>
    <lang code="ira">Azargi</lang>
    <lang code="ira">Hazara</lang>
    <lang code="ira">Hezareh</lang>
    <lang code="ira">Hezareʼi</lang>
    <lang code="ira">Khazara</lang>
    <lang code="ira">Khezare</lang>
    <lang code="ira">Ishkashmi</lang>
    <lang code="ira">Judeo-Tat</lang>
    <lang code="ira">Bik</lang>
    <lang code="ira">Dzhuhuric</lang>
    <lang code="ira">Hebrew Tat</lang>
    <lang code="ira">Hebrew Tati</lang>
    <lang code="ira">Jew-Tatish</lang>
    <lang code="ira">Jewish Tat</lang>
    <lang code="ira">Judeo-Tatic</lang>
    <lang code="ira">Khorezmi</lang>
    <lang code="ira">Choresmian</lang>
    <lang code="ira">Khwarezmian</lang>
    <lang code="ira">Khuf</lang>
    <lang code="ira">Chuf</lang>
    <lang code="ira">Laki (Iran)</lang>
    <lang code="ira">Alaki</lang>
    <lang code="ira">Leki</lang>
    <lang code="ira">Māzandarānī</lang>
    <lang code="ira">Mazanderani</lang>
    <lang code="ira">Tabri</lang>
    <lang code="ira">Median</lang>
    <lang code="ira">Medic</lang>
    <lang code="ira">Munji</lang>
    <lang code="ira">Mundzhan</lang>
    <lang code="ira">Munjani</lang>
    <lang code="ira">Natanzi</lang>
    <lang code="ira">Naṭanz</lang>
    <lang code="ira">Ormuri</lang>
    <lang code="ira">Baraks</lang>
    <lang code="ira">Bargista</lang>
    <lang code="ira">Parachi</lang>
    <lang code="ira">Parthian</lang>
    <lang code="ira">Roshan</lang>
    <lang code="ira">Rochani</lang>
    <lang code="ira">Ruschan</lang>
    <lang code="ira">Sarikoli</lang>
    <lang code="ira">Sarykoli</lang>
    <lang code="ira">Sarmatian</lang>
    <lang code="ira">Shughni</lang>
    <lang code="ira">Shugnan-Rushan</lang>
    <lang code="ira">Sivandi</lang>
    <lang code="ira">Sivendi</lang>
    <lang code="ira">Talysh</lang>
    <lang code="ira">Tat</lang>
    <lang code="ira">Wakhi</lang>
    <lang code="ira">Yaghnobi</lang>
    <lang code="ira">Neo-Sogdian</lang>
    <lang code="ira">Yaghnabi</lang>
    <lang code="ira">Yaghnubi</lang>
    <lang code="ira">Yagnabi</lang>
    <lang code="ira">Yagnob</lang>
    <lang code="ira">Yagnobi</lang>
    <lang code="ira">Yagnubi</lang>
    <lang code="ira">Yazghulami</lang>
    <lang code="ira">Zebaki</lang>
    <lang code="ira">Sanglici</lang>
    <lang code="gle">Irish</lang>
    <lang code="gle">Erse (Irish)</lang>
    <lang code="gle">Gaelic (Irish)</lang>
    <lang code="gle">Irish Gaelic</lang>
    <lang code="iri" status="obsolete">Irish</lang>
    <lang code="mga">Irish, Middle (ca. 1100-1550)</lang>
    <lang code="mga">Middle Irish</lang>
    <lang code="sga">Irish, Old (to 1100)</lang>
    <lang code="sga">Old Irish</lang>
    <lang code="iro">Iroquoian (Other)</lang>
    <lang code="iro">Cayuga</lang>
    <lang code="iro">Iroquois</lang>
    <lang code="iro">Oneida</lang>
    <lang code="iro">Onondaga</lang>
    <lang code="iro">Seneca</lang>
    <lang code="iro">Tuscarora</lang>
    <lang code="iro">Wyandot</lang>
    <lang code="iro">Huron</lang>
    <lang code="ita">Italian</lang>
    <lang code="ita">Judeo-Italian</lang>
    <lang code="ita">Milanese</lang>
    <lang code="ita">Modena Italian</lang>
    <lang code="ita">Italian, Modena</lang>
    <lang code="ita">Romagnol</lang>
    <lang code="ita">Venetian Italian</lang>
    <lang code="ita">Italian, Venetian</lang>
    <lang code="jpn">Japanese</lang>
    <lang code="jav">Javanese</lang>
    <lang code="jrb">Judeo-Arabic</lang>
    <lang code="jpr">Judeo-Persian</lang>
    <lang code="jpr">Judeo-Tajik</lang>
    <lang code="kbd">Kabardian</lang>
    <lang code="kbd">Cabardan</lang>
    <lang code="kbd">Circassian, East</lang>
    <lang code="kbd">Circassian, Upper</lang>
    <lang code="kbd">East Circassian</lang>
    <lang code="kbd">Qabardian</lang>
    <lang code="kbd">Upper Circassian</lang>
    <lang code="kab">Kabyle</lang>
    <lang code="kac">Kachin</lang>
    <lang code="kac">Chingpaw</lang>
    <lang code="kac">Jingpho</lang>
    <lang code="kal">Kalâtdlisut</lang>
    <lang code="kal">Ammassalimiut</lang>
    <lang code="kal">East Greenlandic</lang>
    <lang code="kal">Greenlandic, East</lang>
    <lang code="kal">Tunumiisut</lang>
    <lang code="kal">Greenlandic</lang>
    <lang code="kal">Inuit</lang>
    <lang code="kal">Kalaallisut</lang>
    <lang code="kam">Kamba</lang>
    <lang code="kan">Kannada</lang>
    <lang code="kan">Canarese</lang>
    <lang code="kan">Kanarese</lang>
    <lang code="kan">Havyaka</lang>
    <lang code="kau">Kanuri</lang>
    <lang code="kau">Bornu</lang>
    <lang code="krc">Karachay-Balkar</lang>
    <lang code="krc">Balkar</lang>
    <lang code="kaa">Kara-Kalpak</lang>
    <lang code="kaa">Karakalpak</lang>
    <lang code="kaa">Qaraqalpaq</lang>
    <lang code="krl">Karelian</lang>
    <lang code="krl">Carelian</lang>
    <lang code="kar">Karen languages</lang>
    <lang code="kar">Kayah</lang>
    <lang code="kar">Karen, Red</lang>
    <lang code="kar">Red Karen</lang>
    <lang code="kar">Pwo Karen</lang>
    <lang code="kar">Sgaw Karen</lang>
    <lang code="kar">Taungthu</lang>
    <lang code="kar">Pa-o</lang>
    <lang code="kas">Kashmiri</lang>
    <lang code="csb">Kashubian</lang>
    <lang code="csb">Cashubian</lang>
    <lang code="kaw">Kawi</lang>
    <lang code="kaw">Javanese, Old</lang>
    <lang code="kaw">Old Javanese</lang>
    <lang code="kaz">Kazakh</lang>
    <lang code="kaz">Kirghiz-Kaissak</lang>
    <lang code="kha">Khasi</lang>
    <lang code="khm">Khmer</lang>
    <lang code="khm">Cambodian</lang>
    <lang code="khm">Central Khmer</lang>
    <lang code="cam" status="obsolete">Khmer</lang>
    <lang code="khi">Khoisan (Other)</lang>
    <lang code="khi">Ju/'hoan</lang>
    <lang code="khi">!Xũ (!Kung)</lang>
    <lang code="khi">Zjuc'hôa</lang>
    <lang code="khi">Žu/'hõasi</lang>
    <lang code="khi">Khoikhoi</lang>
    <lang code="khi">Hottentot</lang>
    <lang code="khi">Korana</lang>
    <lang code="khi">Nama</lang>
    <lang code="khi">Nharo</lang>
    <lang code="khi">Naro</lang>
    <lang code="khi">San languages</lang>
    <lang code="khi">Bushman languages</lang>
    <lang code="khi">!Xõ</lang>
    <lang code="khi">Gxon</lang>
    <lang code="khi">Hua-owani</lang>
    <lang code="khi">!Kõ (Botswana and Namibia)</lang>
    <lang code="khi">Koon</lang>
    <lang code="khi">Magong</lang>
    <lang code="khi">!Xong (Botswana and Namibia)</lang>
    <lang code="kho">Khotanese</lang>
    <lang code="kho">Khotan-Saka</lang>
    <lang code="kho">Khotanese-Sakan</lang>
    <lang code="kho">Khotani</lang>
    <lang code="kho">Khotansaka</lang>
    <lang code="kho">Middle Khotanese</lang>
    <lang code="kho">North Aryan</lang>
    <lang code="kho">Old Khotanese</lang>
    <lang code="kho">Saka</lang>
    <lang code="kho">Sakan</lang>
    <lang code="kik">Kikuyu</lang>
    <lang code="kik">Gikuyu</lang>
    <lang code="kmb">Kimbundu</lang>
    <lang code="kmb">Angola</lang>
    <lang code="kmb">Bunda</lang>
    <lang code="kmb">Mbundu (Luanda Province, Angola)</lang>
    <lang code="kmb">Nbundu</lang>
    <lang code="kmb">Quimbundo (Luanda Province, Angola)</lang>
    <lang code="kin">Kinyarwanda</lang>
    <lang code="kin">Nyaruanda</lang>
    <lang code="kin">Ruanda</lang>
    <lang code="kin">Runyarwanda</lang>
    <lang code="kin">Rwanda</lang>
    <lang code="kin">Rufumbira</lang>
    <lang code="tlh">Klingon (Artificial language)</lang>
    <lang code="kom">Komi</lang>
    <lang code="kom">Syryenian</lang>
    <lang code="kom">Zyrian</lang>
    <lang code="kom">Komi-Permyak</lang>
    <lang code="kom">Permiak</lang>
    <lang code="kon">Kongo</lang>
    <lang code="kon">Congo</lang>
    <lang code="kon">Kikongo</lang>
    <lang code="kon">Kituba (Congo (Brazzaville))</lang>
    <lang code="kon">Kikoongo (Kituba (Congo (Brazzaville)))</lang>
    <lang code="kon">Munukutuba</lang>
    <lang code="kon">Laadi</lang>
    <lang code="kon">Kilari</lang>
    <lang code="kon">Manyanga</lang>
    <lang code="kon">Kimanyanga</lang>
    <lang code="kon">Kisi-Ngóombe</lang>
    <lang code="kon">Manianga</lang>
    <lang code="kon">Ntaandu</lang>
    <lang code="kon">Kintaandu</lang>
    <lang code="kon">Kisantu</lang>
    <lang code="kon">Santu</lang>
    <lang code="kon">Vili</lang>
    <lang code="kon">Civili</lang>
    <lang code="kon">Fiot</lang>
    <lang code="kon">Fiote</lang>
    <lang code="kon">Ki-vili</lang>
    <lang code="kon">Ki-vumbu</lang>
    <lang code="kon">Kivili</lang>
    <lang code="kon">Kivumbu</lang>
    <lang code="kon">Loango</lang>
    <lang code="kon">Lu-wumbu</lang>
    <lang code="kon">Luwumbu</lang>
    <lang code="kon">Tsivili</lang>
    <lang code="kon">Zombo</lang>
    <lang code="kok">Konkani</lang>
    <lang code="kok">Concani</lang>
    <lang code="kok">Komkani</lang>
    <lang code="kok">Koṅkṇi</lang>
    <lang code="kok">Agri</lang>
    <lang code="kok">Agari</lang>
    <lang code="kok">Chitapavani</lang>
    <lang code="kok">Chitpavani</lang>
    <lang code="kok">Citpāvanī</lang>
    <lang code="kok">Jhāḍī</lang>
    <lang code="kok">Kudali</lang>
    <lang code="kok">Malvani</lang>
    <lang code="kut">Kootenai</lang>
    <lang code="kut">Kutenai</lang>
    <lang code="kor">Korean</lang>
    <lang code="kos">Kosraean</lang>
    <lang code="kos">Kosrae</lang>
    <lang code="kos">Kusaie</lang>
    <lang code="kos">Kusaiean</lang>
    <lang code="kpe">Kpelle</lang>
    <lang code="kpe">Guerzé</lang>
    <lang code="kro">Kru (Other)</lang>
    <lang code="kro">Bakwé</lang>
    <lang code="kro">Bassa (Liberia and Sierra Leone)</lang>
    <lang code="kro">Bete</lang>
    <lang code="kro">Dadjriwalé</lang>
    <lang code="kro">Dadjrignoa</lang>
    <lang code="kro">Dagli</lang>
    <lang code="kro">Dajriwali</lang>
    <lang code="kro">Dewoin</lang>
    <lang code="kro">Dida</lang>
    <lang code="kro">Wawi</lang>
    <lang code="kro">Godié</lang>
    <lang code="kro">Go (Côte d'Ivoire)</lang>
    <lang code="kro">Godia</lang>
    <lang code="kro">Godye</lang>
    <lang code="kro">Jabo</lang>
    <lang code="kro">Kouya</lang>
    <lang code="kro">Krahn</lang>
    <lang code="kro">Kran</lang>
    <lang code="kro">Northern Krahn</lang>
    <lang code="kro">Western Krahn</lang>
    <lang code="kro">Kru</lang>
    <lang code="kro">Kuwaa</lang>
    <lang code="kro">Belle</lang>
    <lang code="kro">Belleh</lang>
    <lang code="kro">Kowaao</lang>
    <lang code="kro">Kwaa</lang>
    <lang code="kro">Neyo</lang>
    <lang code="kro">Gwibwen</lang>
    <lang code="kro">Néouolé</lang>
    <lang code="kro">Néyau</lang>
    <lang code="kro">Niyo</lang>
    <lang code="kro">Towi</lang>
    <lang code="kro">Ngere</lang>
    <lang code="kro">Gere</lang>
    <lang code="kro">Guéré</lang>
    <lang code="kro">Nyabwa</lang>
    <lang code="kro">Niaboua</lang>
    <lang code="kro">Tchien</lang>
    <lang code="kro">Gien</lang>
    <lang code="kro">Kien</lang>
    <lang code="kro">Tie</lang>
    <lang code="kro">Tepo</lang>
    <lang code="kro">Kroumen</lang>
    <lang code="kro">Tewi</lang>
    <lang code="kro">Vata</lang>
    <lang code="kro">Wobe</lang>
    <lang code="kro">Ouobe</lang>
    <lang code="kua">Kuanyama</lang>
    <lang code="kua">Cuanhama</lang>
    <lang code="kua">Kwanyama</lang>
    <lang code="kua">Ovambo (Kuanyama)</lang>
    <lang code="kum">Kumyk</lang>
    <lang code="kur">Kurdish</lang>
    <lang code="kur">Kurmanji</lang>
    <lang code="kur">Mukri</lang>
    <lang code="kru">Kurukh</lang>
    <lang code="kru">Kurux</lang>
    <lang code="kru">Oraon</lang>
    <lang code="kru">Uraon</lang>
    <lang code="kus" status="obsolete">Kusaie</lang>
    <lang code="kir">Kyrgyz</lang>
    <lang code="kir">Kara-Kirghiz</lang>
    <lang code="kir">Kirghiz</lang>
    <lang code="lad">Ladino</lang>
    <lang code="lad">Judeo-Spanish</lang>
    <lang code="lad">Judesmo</lang>
    <lang code="lad">Ḥakétia</lang>
    <lang code="lad">Ḥakétie</lang>
    <lang code="lad">Haketiya</lang>
    <lang code="lad">Ḥakitía</lang>
    <lang code="lad">Haquetía</lang>
    <lang code="lad">Haquetiya</lang>
    <lang code="lah">Lahndā</lang>
    <lang code="lah">Jaṭkī</lang>
    <lang code="lah">Lahndi</lang>
    <lang code="lah">Panjabi, Western</lang>
    <lang code="lah">Western Panjabi</lang>
    <lang code="lah">Hindkōo</lang>
    <lang code="lah">Khetrānī</lang>
    <lang code="lah">Pōṭhwārī</lang>
    <lang code="lah">Siraiki</lang>
    <lang code="lah">Bahawalpuri</lang>
    <lang code="lah">Lahnda, Southern</lang>
    <lang code="lah">Multani</lang>
    <lang code="lah">Mutani</lang>
    <lang code="lah">Panjabi, Southern</lang>
    <lang code="lah">Reasati</lang>
    <lang code="lah">Riasati</lang>
    <lang code="lah">Saraiki</lang>
    <lang code="lah">Southern Lahnda</lang>
    <lang code="lah">Southern Panjabi</lang>
    <lang code="lah">Sirāikī Hindkī</lang>
    <lang code="lah">Siraiki Lahndi</lang>
    <lang code="lah">Sirāikī Sindhī</lang>
    <lang code="lah">Sindhi, Siraiki</lang>
    <lang code="lam">Lamba (Zambia and Congo)</lang>
    <lang code="lao">Lao</lang>
    <lang code="lat">Latin</lang>
    <lang code="lat">Latin, Vulgar</lang>
    <lang code="lat">Vulgar Latin</lang>
    <lang code="lav">Latvian</lang>
    <lang code="lav">Lettish</lang>
    <lang code="lav">Latgalian</lang>
    <lang code="lav">East Latvian</lang>
    <lang code="lav">High Latvian</lang>
    <lang code="lav">Letgalian</lang>
    <lang code="lez">Lezgian</lang>
    <lang code="lim">Limburgish</lang>
    <lang code="lim">Limburger</lang>
    <lang code="lin">Lingala</lang>
    <lang code="lin">Bangala (Congo)</lang>
    <lang code="lin">Mangala (Congo)</lang>
    <lang code="lin">Ngala (Congo)</lang>
    <lang code="lit">Lithuanian</lang>
    <lang code="jbo">Lojban (Artificial language)</lang>
    <lang code="nds">Low German</lang>
    <lang code="nds">German, Low</lang>
    <lang code="nds">Low Saxon</lang>
    <lang code="nds">Plattdeutsch</lang>
    <lang code="nds">Plautdietsch</lang>
    <lang code="nds">Saxon, Low</lang>
    <lang code="dsb">Lower Sorbian</lang>
    <lang code="dsb">Sorbian, Lower</lang>
    <lang code="loz">Lozi</lang>
    <lang code="loz">Kololo</lang>
    <lang code="loz">Rozi</lang>
    <lang code="loz">Sikololo</lang>
    <lang code="lub">Luba-Katanga</lang>
    <lang code="lub">Chiluba</lang>
    <lang code="lub">Katanga</lang>
    <lang code="lua">Luba-Lulua</lang>
    <lang code="lua">Ciluba</lang>
    <lang code="lua">Kalebwe (Luba-Lulua)</lang>
    <lang code="lua">Luba, Western</lang>
    <lang code="lua">Luba-Kasai</lang>
    <lang code="lua">Western Luba</lang>
    <lang code="lui">Luiseño</lang>
    <lang code="smj">Lule Sami</lang>
    <lang code="smj">Lapp, Swedish</lang>
    <lang code="smj">Sami, Lule</lang>
    <lang code="smj">Swedish Lapp</lang>
    <lang code="lun">Lunda</lang>
    <lang code="luo">Luo (Kenya and Tanzania)</lang>
    <lang code="luo">Dho Luo</lang>
    <lang code="luo">Gaya</lang>
    <lang code="luo">Jo Luo</lang>
    <lang code="luo">Kavirondo, Nilotic</lang>
    <lang code="luo">Nife</lang>
    <lang code="luo">Nilotic Kavirondo</lang>
    <lang code="luo">Nyife</lang>
    <lang code="luo">Wagaya</lang>
    <lang code="lus">Lushai</lang>
    <lang code="lus">Dulien</lang>
    <lang code="lus">Mizo</lang>
    <lang code="lus">Sailau</lang>
    <lang code="ltz">Luxembourgish</lang>
    <lang code="ltz">Letzebuergesch</lang>
    <lang code="ltz">Letzeburgesch</lang>
    <lang code="ltz">Luxembourgeois</lang>
    <lang code="ltz">Luxemburgian</lang>
    <lang code="mac">Macedonian</lang>
    <lang code="mac">Bǎlgarski (Macedonian)</lang>
    <lang code="mac">Balgàrtzki (Macedonian)</lang>
    <lang code="mac">Bolgàrtski (Macedonian)</lang>
    <lang code="mac">Bulgàrtski (Macedonian)</lang>
    <lang code="mac">Dópia</lang>
    <lang code="mac">Entópia</lang>
    <lang code="mac">Macedonian Slavic</lang>
    <lang code="mac">Makedoniski</lang>
    <lang code="mac">Makedonski</lang>
    <lang code="mac">Slavic (Macedonian)</lang>
    <lang code="mac">Slaviká (Macedonian)</lang>
    <lang code="mac">Slavomacedonian</lang>
    <lang code="mad">Madurese</lang>
    <lang code="mag">Magahi</lang>
    <lang code="mag">Bihari (Magahi)</lang>
    <lang code="mag">Magadhi</lang>
    <lang code="mag">Magaya</lang>
    <lang code="mag">Maghadi</lang>
    <lang code="mag">Maghai</lang>
    <lang code="mag">Maghaya</lang>
    <lang code="mag">Maghori</lang>
    <lang code="mag">Magi (India)</lang>
    <lang code="mag">Magodhi</lang>
    <lang code="mag">Megahi</lang>
    <lang code="mai">Maithili</lang>
    <lang code="mai">Apabhramsa (Maithili)</lang>
    <lang code="mai">Bihari (Maithili)</lang>
    <lang code="mai">Maitili</lang>
    <lang code="mai">Maitli</lang>
    <lang code="mai">Methli</lang>
    <lang code="mai">Tirahutia</lang>
    <lang code="mai">Tirhuti</lang>
    <lang code="mai">Tirhutia</lang>
    <lang code="mai">Khotta (Maithili)</lang>
    <lang code="mai">Eastern Maithili</lang>
    <lang code="mai">Khoratha</lang>
    <lang code="mak">Makasar</lang>
    <lang code="mak">Macassarese</lang>
    <lang code="mlg">Malagasy</lang>
    <lang code="mlg">Hova</lang>
    <lang code="mlg">Madagascan</lang>
    <lang code="mlg">Malgache</lang>
    <lang code="mlg">Merina</lang>
    <lang code="mlg">Bara (Madagascar)</lang>
    <lang code="mlg">Betsileo</lang>
    <lang code="mlg">Masikoro</lang>
    <lang code="mlg">Sakalava</lang>
    <lang code="mlg">Tsimihety</lang>
    <lang code="mla" status="obsolete">Malagasy</lang>
    <lang code="may">Malay</lang>
    <lang code="may">Palembang Malay</lang>
    <lang code="mal">Malayalam</lang>
    <lang code="mal">Malabar</lang>
    <lang code="mal">Moplah</lang>
    <lang code="mlt">Maltese</lang>
    <lang code="mnc">Manchu</lang>
    <lang code="mdr">Mandar</lang>
    <lang code="mdr">Andian</lang>
    <lang code="man">Mandingo</lang>
    <lang code="man">Malinka</lang>
    <lang code="man">Mandeka</lang>
    <lang code="man">Maninka</lang>
    <lang code="man">Meninka</lang>
    <lang code="mni">Manipuri</lang>
    <lang code="mni">Meithei</lang>
    <lang code="mno">Manobo languages</lang>
    <lang code="mno">Agusan Manobo</lang>
    <lang code="mno">Ata Manobo</lang>
    <lang code="mno">Binukid Manobo</lang>
    <lang code="mno">Binokid</lang>
    <lang code="mno">Bukidnon</lang>
    <lang code="mno">Cotabato Manobo</lang>
    <lang code="mno">Dibabawon</lang>
    <lang code="mno">Debabaon</lang>
    <lang code="mno">Dibabaon</lang>
    <lang code="mno">Mandaya</lang>
    <lang code="mno">Higaonon</lang>
    <lang code="mno">Ilianen Manobo</lang>
    <lang code="mno">Kagayanen</lang>
    <lang code="mno">Cagayano Cillo</lang>
    <lang code="mno">Manuvu</lang>
    <lang code="mno">Bagobo, Upper</lang>
    <lang code="mno">Upper Bagobo</lang>
    <lang code="mno">MatigSalug</lang>
    <lang code="mno">Sarangani Manobo</lang>
    <lang code="mno">Culamanes</lang>
    <lang code="mno">Kulaman</lang>
    <lang code="mno">Western Bukidnon Manobo</lang>
    <lang code="mno">Bukidnon Manobo, Western</lang>
    <lang code="mno">Central Manobo</lang>
    <lang code="mno">Central Mindanao Manobo</lang>
    <lang code="glv">Manx</lang>
    <lang code="glv">Manx Gaelic</lang>
    <lang code="max" status="obsolete">Manx</lang>
    <lang code="mao">Maori</lang>
    <lang code="mao">South Island Maori</lang>
    <lang code="mao">Maori, South Island</lang>
    <lang code="arn">Mapuche</lang>
    <lang code="arn">Araucanian</lang>
    <lang code="arn">Mapudungun</lang>
    <lang code="mar">Marathi</lang>
    <lang code="mar">Mahratta</lang>
    <lang code="mar">Mahratti</lang>
    <lang code="mar">Murathee</lang>
    <lang code="mar">Are</lang>
    <lang code="mar">Ade Basha</lang>
    <lang code="mar">Aray</lang>
    <lang code="mar">Arrey</lang>
    <lang code="mar">Arya</lang>
    <lang code="mar">Kalika Arya Bhasha</lang>
    <lang code="mar">Koshti (Marathi)</lang>
    <lang code="mar">Kosti (Marathi)</lang>
    <lang code="mar">Kunabi</lang>
    <lang code="mar">Varhadi Nagpuri</lang>
    <lang code="mar">Berar Marathi</lang>
    <lang code="mar">Berari</lang>
    <lang code="mar">Dhanagari</lang>
    <lang code="mar">Kumbhari</lang>
    <lang code="mar">Madhya Pradesh Marathi</lang>
    <lang code="mar">Nagpuri (Varhadi Nagpuri)</lang>
    <lang code="mar">Nagpuri-Varhadi</lang>
    <lang code="mar">Varhadi-Nagpuri Marathi</lang>
    <lang code="chm">Mari</lang>
    <lang code="chm">Cheremissian</lang>
    <lang code="mah">Marshallese</lang>
    <lang code="mah">Ebon</lang>
    <lang code="mwr">Marwari</lang>
    <lang code="mwr">Bikaneri</lang>
    <lang code="mwr">Dingal</lang>
    <lang code="mwr">Mewari</lang>
    <lang code="mwr">Mevadi</lang>
    <lang code="mwr">Mewa</lang>
    <lang code="mwr">Mewadi</lang>
    <lang code="mwr">Shekhawati</lang>
    <lang code="mwr">Sekhavati</lang>
    <lang code="mas">Maasai</lang>
    <lang code="mas">Maa (Kenya and Tanzania)</lang>
    <lang code="mas">Masai</lang>
    <lang code="myn">Mayan languages</lang>
    <lang code="myn">Achi</lang>
    <lang code="myn">Cubulco Achi</lang>
    <lang code="myn">Rabinal Achi</lang>
    <lang code="myn">Akatek</lang>
    <lang code="myn">Acateco</lang>
    <lang code="myn">Kanjobal, Western</lang>
    <lang code="myn">San Miguel Acatán Kanjobal</lang>
    <lang code="myn">Western Kanjobal</lang>
    <lang code="myn">Awakateko</lang>
    <lang code="myn">Aguacatec</lang>
    <lang code="myn">Cakchikel</lang>
    <lang code="myn">Kacchiquel</lang>
    <lang code="myn">Chol</lang>
    <lang code="myn">Chontal of Tabasco</lang>
    <lang code="myn">Chorti</lang>
    <lang code="myn">Chuj</lang>
    <lang code="myn">Huastec</lang>
    <lang code="myn">Guastec</lang>
    <lang code="myn">Wastek</lang>
    <lang code="myn">Itzá</lang>
    <lang code="myn">Ixil</lang>
    <lang code="myn">Jacalteca</lang>
    <lang code="myn">Jakalteka</lang>
    <lang code="myn">Kanjobal</lang>
    <lang code="myn">Conob</lang>
    <lang code="myn">Kekchi</lang>
    <lang code="myn">Cacchi</lang>
    <lang code="myn">Ghec-chi</lang>
    <lang code="myn">Quekchi</lang>
    <lang code="myn">Lacandon</lang>
    <lang code="myn">Mam</lang>
    <lang code="myn">Zaklohpakap</lang>
    <lang code="myn">Maya</lang>
    <lang code="myn">Yucatecan</lang>
    <lang code="myn">Mochó</lang>
    <lang code="myn">Motozintlec</lang>
    <lang code="myn">Mopan</lang>
    <lang code="myn">Manche</lang>
    <lang code="myn">Pokomam</lang>
    <lang code="myn">Pocomam</lang>
    <lang code="myn">Poqomam</lang>
    <lang code="myn">Pokonchi</lang>
    <lang code="myn">Quiché</lang>
    <lang code="myn">Kiché</lang>
    <lang code="myn">Utlateca</lang>
    <lang code="myn">Tectiteco</lang>
    <lang code="myn">Teco (Mayan)</lang>
    <lang code="myn">Tojolabal</lang>
    <lang code="myn">Chañabal</lang>
    <lang code="myn">Tzeltal</lang>
    <lang code="myn">Celdal</lang>
    <lang code="myn">Tseltal</lang>
    <lang code="myn">Zendal</lang>
    <lang code="myn">Tzotzil</lang>
    <lang code="myn">Chamula</lang>
    <lang code="myn">Querene</lang>
    <lang code="myn">Zotzil</lang>
    <lang code="myn">Tzutuhil</lang>
    <lang code="myn">Zutuhil</lang>
    <lang code="myn">Uspanteca</lang>
    <lang code="men">Mende</lang>
    <lang code="mic">Micmac</lang>
    <lang code="min">Minangkabau</lang>
    <lang code="min">Menangkabau</lang>
    <lang code="mwl">Mirandese</lang>
    <lang code="mis">Miscellaneous languages</lang>
    <lang code="mis">Andamanese</lang>
    <lang code="mis">Burushaski</lang>
    <lang code="mis">Boorishki</lang>
    <lang code="mis">Khajuna</lang>
    <lang code="mis">Chukchi</lang>
    <lang code="mis">Tchuktchi</lang>
    <lang code="mis">Tuski</lang>
    <lang code="mis">Etruscan</lang>
    <lang code="mis">Gilyak</lang>
    <lang code="mis">Guiliak</lang>
    <lang code="mis">Nivkh</lang>
    <lang code="mis">Hattic</lang>
    <lang code="mis">Hattian</lang>
    <lang code="mis">Khattic</lang>
    <lang code="mis">Khattili</lang>
    <lang code="mis">Khattish</lang>
    <lang code="mis">Proto-Hittite</lang>
    <lang code="mis">Hurrian</lang>
    <lang code="mis">Mitani</lang>
    <lang code="mis">Subarian</lang>
    <lang code="mis">Iberian</lang>
    <lang code="mis">Indus script</lang>
    <lang code="mis">Jarawa (India)</lang>
    <lang code="mis">Kamchadal</lang>
    <lang code="mis">Itelmes</lang>
    <lang code="mis">Ket</lang>
    <lang code="mis">Yenisei-Ostiak</lang>
    <lang code="mis">Koryak</lang>
    <lang code="mis">Manipravalam (Malayalam)</lang>
    <lang code="mis">Mysian</lang>
    <lang code="mis">Nancowry</lang>
    <lang code="mis">Nenets</lang>
    <lang code="mis">Jurak</lang>
    <lang code="mis">Yurak</lang>
    <lang code="mis">Nganasan</lang>
    <lang code="mis">Tavgi</lang>
    <lang code="mis">Nicobarese</lang>
    <lang code="mis">Palan</lang>
    <lang code="mis">Pallan</lang>
    <lang code="mis">Shelta</lang>
    <lang code="mis">Urartian</lang>
    <lang code="mis">Chaldean (Urartian)</lang>
    <lang code="mis">Khaldian</lang>
    <lang code="mis">Urartaean</lang>
    <lang code="mis">Urartic</lang>
    <lang code="mis">Vannic</lang>
    <lang code="mis">Yugh</lang>
    <lang code="mis">Sym-Ketish</lang>
    <lang code="mis">Yukaghir</lang>
    <lang code="mis">Jukaghir</lang>
    <lang code="moh">Mohawk</lang>
    <lang code="mdf">Moksha</lang>
    <lang code="mol" status="obsolete">Moldavian</lang>
    <lang code="mkh">Mon-Khmer (Other)</lang>
    <lang code="mkh">Bahnar</lang>
    <lang code="mkh">Blang</lang>
    <lang code="mkh">Bulang</lang>
    <lang code="mkh">Plang</lang>
    <lang code="mkh">Pulang</lang>
    <lang code="mkh">Samtao</lang>
    <lang code="mkh">Chrau</lang>
    <lang code="mkh">Cua</lang>
    <lang code="mkh">Bong Miew</lang>
    <lang code="mkh">Kor</lang>
    <lang code="mkh">Traw</lang>
    <lang code="mkh">Eastern Mnong</lang>
    <lang code="mkh">Mnong, Eastern</lang>
    <lang code="mkh">Hrê</lang>
    <lang code="mkh">Davak</lang>
    <lang code="mkh">Jah Hut</lang>
    <lang code="mkh">Eastern Sakai</lang>
    <lang code="mkh">Sakai, Eastern</lang>
    <lang code="mkh">Jeh</lang>
    <lang code="mkh">Die</lang>
    <lang code="mkh">Yeh</lang>
    <lang code="mkh">Katu</lang>
    <lang code="mkh">Attouat</lang>
    <lang code="mkh">Khat</lang>
    <lang code="mkh">Ta River Van Kieu</lang>
    <lang code="mkh">Teu</lang>
    <lang code="mkh">Thap</lang>
    <lang code="mkh">Khmu'</lang>
    <lang code="mkh">Kamhmu</lang>
    <lang code="mkh">Phouteng</lang>
    <lang code="mkh">Koho</lang>
    <lang code="mkh">Kui (Mon-Khmer)</lang>
    <lang code="mkh">Khmer, Old (Kui)</lang>
    <lang code="mkh">Kuay</lang>
    <lang code="mkh">Kuy</lang>
    <lang code="mkh">Old Khmer (Kui)</lang>
    <lang code="mkh">Suai</lang>
    <lang code="mkh">Suay</lang>
    <lang code="mkh">Laven</lang>
    <lang code="mkh">Loven</lang>
    <lang code="mkh">Lawa (Thailand)</lang>
    <lang code="mkh">La-oop</lang>
    <lang code="mkh">Lava</lang>
    <lang code="mkh">Lavua</lang>
    <lang code="mkh">Luwa</lang>
    <lang code="mkh">Mah Meri</lang>
    <lang code="mkh">Besisi</lang>
    <lang code="mkh">Cellate</lang>
    <lang code="mkh">Mon</lang>
    <lang code="mkh">Peguan</lang>
    <lang code="mkh">Talaing</lang>
    <lang code="mkh">Muong</lang>
    <lang code="mkh">Northern Khmer</lang>
    <lang code="mkh">Khmer, Northern</lang>
    <lang code="mkh">Nyah Kur</lang>
    <lang code="mkh">Chao Bon</lang>
    <lang code="mkh">Niakuol</lang>
    <lang code="mkh">Pacoh</lang>
    <lang code="mkh">Bo</lang>
    <lang code="mkh">River Van Kieu</lang>
    <lang code="mkh">Rengao</lang>
    <lang code="mkh">Sedang</lang>
    <lang code="mkh">Cadong</lang>
    <lang code="mkh">Dang (Sedang)</lang>
    <lang code="mkh">Hadang</lang>
    <lang code="mkh">Hdang</lang>
    <lang code="mkh">Hotea</lang>
    <lang code="mkh">Hoteang</lang>
    <lang code="mkh">Kmrang</lang>
    <lang code="mkh">Rotea</lang>
    <lang code="mkh">Roteang</lang>
    <lang code="mkh">Tang (Sedang)</lang>
    <lang code="mkh">Xa</lang>
    <lang code="mkh">Xodang</lang>
    <lang code="mkh">Semai</lang>
    <lang code="mkh">Central Sakai</lang>
    <lang code="mkh">Sakai, Central</lang>
    <lang code="mkh">Senoi</lang>
    <lang code="mkh">Semang</lang>
    <lang code="mkh">Kensiu</lang>
    <lang code="mkh">Ngok Pa</lang>
    <lang code="mkh">Senoic languages</lang>
    <lang code="mkh">Aslian languages, Central</lang>
    <lang code="mkh">Central Aslian languages</lang>
    <lang code="mkh">Sakai languages</lang>
    <lang code="mkh">Srê</lang>
    <lang code="mkh">Stieng</lang>
    <lang code="mkh">Temiar</lang>
    <lang code="mkh">Northern Sakai</lang>
    <lang code="mkh">Sakai, Northern</lang>
    <lang code="mkh">Wa</lang>
    <lang code="lol">Mongo-Nkundu</lang>
    <lang code="lol">Lolo (Congo)</lang>
    <lang code="lol">Lomongo</lang>
    <lang code="lol">Lonkundu</lang>
    <lang code="lol">Mongo</lang>
    <lang code="lol">Nkundu</lang>
    <lang code="mon">Mongolian</lang>
    <lang code="mon">Mongol</lang>
    <lang code="mon">Chahar</lang>
    <lang code="mon">Čakhar</lang>
    <lang code="mon">Dariganga</lang>
    <lang code="mon">Dar'ganga</lang>
    <lang code="mon">Dariġangġ-a</lang>
    <lang code="mon">Darigangga</lang>
    <lang code="mon">Khalkha</lang>
    <lang code="mon">Ordos</lang>
    <lang code="cnr">Montenegrin</lang>
    <lang code="mos">Mooré</lang>
    <lang code="mos">Mole</lang>
    <lang code="mos">Moré</lang>
    <lang code="mos">Moshi</lang>
    <lang code="mos">Mossi</lang>
    <lang code="mos">Yana (Burkina Faso and Togo)</lang>
    <lang code="mul">Multiple languages</lang>
    <lang code="mun">Munda (Other)</lang>
    <lang code="mun">Asuri</lang>
    <lang code="mun">Bhumij</lang>
    <lang code="mun">Ho</lang>
    <lang code="mun">Kharia</lang>
    <lang code="mun">Korwa</lang>
    <lang code="mun">Korava (Munda)</lang>
    <lang code="mun">Kurku</lang>
    <lang code="mun">Bondeya</lang>
    <lang code="mun">Bopchi</lang>
    <lang code="mun">Kirku</lang>
    <lang code="mun">Korakū</lang>
    <lang code="mun">Korki</lang>
    <lang code="mun">Korku</lang>
    <lang code="mun">Kuri (India)</lang>
    <lang code="mun">Mundari</lang>
    <lang code="mun">Kohl</lang>
    <lang code="mun">Nihali</lang>
    <lang code="mun">Nahali</lang>
    <lang code="mun">Sora</lang>
    <lang code="mun">Sabara</lang>
    <lang code="mun">Saora</lang>
    <lang code="mun">Savara</lang>
    <lang code="mun">Sawara</lang>
    <lang code="nah">Nahuatl</lang>
    <lang code="nah">Aztec</lang>
    <lang code="nah">Mexican</lang>
    <lang code="nah">Pipil</lang>
    <lang code="nah">Nahuat</lang>
    <lang code="nau">Nauru</lang>
    <lang code="nav">Navajo</lang>
    <lang code="nbl">Ndebele (South Africa)</lang>
    <lang code="nbl">Ndzundza</lang>
    <lang code="nbl">Nrebele (South Africa)</lang>
    <lang code="nbl">Transvaal Ndebele</lang>
    <lang code="nde">Ndebele (Zimbabwe)</lang>
    <lang code="nde">Nrebele (Zimbabwe)</lang>
    <lang code="nde">Sindebele</lang>
    <lang code="nde">Tebele</lang>
    <lang code="ndo">Ndonga</lang>
    <lang code="ndo">Ambo (Angola and Namibia)</lang>
    <lang code="ndo">Oshindonga</lang>
    <lang code="ndo">Oshiwambo</lang>
    <lang code="ndo">Ovambo (Ndonga)</lang>
    <lang code="nap">Neapolitan Italian</lang>
    <lang code="nep">Nepali</lang>
    <lang code="nep">Gorkhali</lang>
    <lang code="nep">Gurkhali</lang>
    <lang code="nep">Khas</lang>
    <lang code="nep">Khaskura</lang>
    <lang code="nep">Lhotshammikha</lang>
    <lang code="nep">Naipali</lang>
    <lang code="nep">Nepalese</lang>
    <lang code="nep">Parbate</lang>
    <lang code="nep">Parbatiya</lang>
    <lang code="nep">Purbutti</lang>
    <lang code="nep">Baitadi</lang>
    <lang code="nep">Kumali</lang>
    <lang code="nep">Parvati</lang>
    <lang code="nep">Parbati</lang>
    <lang code="new">Newari</lang>
    <lang code="nwc">Newari, Old</lang>
    <lang code="nwc">Old Newari</lang>
    <lang code="nia">Nias</lang>
    <lang code="nic">Niger-Kordofanian (Other)</lang>
    <lang code="nic">Niger-Congo (Other)</lang>
    <lang code="nic">Abidji</lang>
    <lang code="nic">Adidji</lang>
    <lang code="nic">Ari (Côte d'Ivoire)</lang>
    <lang code="nic">Abua</lang>
    <lang code="nic">Ahanta</lang>
    <lang code="nic">Aja (Benin and Togo)</lang>
    <lang code="nic">Adja</lang>
    <lang code="nic">Alladian</lang>
    <lang code="nic">Aladian</lang>
    <lang code="nic">Aladyã</lang>
    <lang code="nic">Aladyan</lang>
    <lang code="nic">Alagia</lang>
    <lang code="nic">Alagian</lang>
    <lang code="nic">Alagya</lang>
    <lang code="nic">Alajan</lang>
    <lang code="nic">Alladyan</lang>
    <lang code="nic">Allagia</lang>
    <lang code="nic">Allagian language</lang>
    <lang code="nic">Anufo</lang>
    <lang code="nic">Chakosi</lang>
    <lang code="nic">Anyi</lang>
    <lang code="nic">Agni</lang>
    <lang code="nic">Attie</lang>
    <lang code="nic">Akye</lang>
    <lang code="nic">Kurobu</lang>
    <lang code="nic">Avikam</lang>
    <lang code="nic">Awutu</lang>
    <lang code="nic">Babungo</lang>
    <lang code="nic">Ngo</lang>
    <lang code="nic">Bafut</lang>
    <lang code="nic">Baka (Cameroon and Gabon)</lang>
    <lang code="nic">Balanta-Ganja</lang>
    <lang code="nic">Alante (Senegal)</lang>
    <lang code="nic">Balanda (Senegal)</lang>
    <lang code="nic">Balant (Senegal)</lang>
    <lang code="nic">Balante (Senegal)</lang>
    <lang code="nic">Balãt</lang>
    <lang code="nic">Ballante (Senegal) </lang>
    <lang code="nic">Belante (Senegal)</lang>
    <lang code="nic">Brassa (Senegal)</lang>
    <lang code="nic">Bulanda (Senegal)</lang>
    <lang code="nic">Fca</lang>
    <lang code="nic">Fjaa</lang>
    <lang code="nic">Fraase</lang>
    <lang code="nic">Balanta-Kentohe</lang>
    <lang code="nic">Alante (Balanta-Kentohe)</lang>
    <lang code="nic">Balanda (Balanta-Kentohe)</lang>
    <lang code="nic">Balant (Balanta-Kentohe)</lang>
    <lang code="nic">Balanta</lang>
    <lang code="nic">Balante (Balanta-Kentohe)</lang>
    <lang code="nic">Ballante (Balanta-Kentohe) </lang>
    <lang code="nic">Belante (Balanta-Kentohe)</lang>
    <lang code="nic">Brassa (Balanta-Kentohe)</lang>
    <lang code="nic">Bulanda (Balanta-Kentohe)</lang>
    <lang code="nic">Frase</lang>
    <lang code="nic">Bamun</lang>
    <lang code="nic">Bandial</lang>
    <lang code="nic">Banjaal</lang>
    <lang code="nic">Eegima</lang>
    <lang code="nic">Eegimaa</lang>
    <lang code="nic">Bariba</lang>
    <lang code="nic">Bargu</lang>
    <lang code="nic">Berba (Benin and Nigeria)</lang>
    <lang code="nic">Bassari</lang>
    <lang code="nic">Ayan</lang>
    <lang code="nic">Biyan</lang>
    <lang code="nic">Wo</lang>
    <lang code="nic">Baule</lang>
    <lang code="nic">Baoulé</lang>
    <lang code="nic">Bedik</lang>
    <lang code="nic">Budik</lang>
    <lang code="nic">Tenda</lang>
    <lang code="nic">Bekwarra</lang>
    <lang code="nic">Bena (Nigeria)</lang>
    <lang code="nic">Binna</lang>
    <lang code="nic">Buna (Bena)</lang>
    <lang code="nic">Ebina (Bena)</lang>
    <lang code="nic">Ebuna (Bena)</lang>
    <lang code="nic">Gbinna</lang>
    <lang code="nic">Yangeru</lang>
    <lang code="nic">Yongor</lang>
    <lang code="nic">Yungur (Bena)</lang>
    <lang code="nic">Benue-Congo languages</lang>
    <lang code="nic">Biali</lang>
    <lang code="nic">Berba (Benin and Burkina Faso)</lang>
    <lang code="nic">Bieri</lang>
    <lang code="nic">Bijago</lang>
    <lang code="nic">Bidyogo</lang>
    <lang code="nic">Birifor</lang>
    <lang code="nic">Birom</lang>
    <lang code="nic">Berom</lang>
    <lang code="nic">Bouroum</lang>
    <lang code="nic">Burum (Nigeria)</lang>
    <lang code="nic">Kibo</lang>
    <lang code="nic">Kibyen</lang>
    <lang code="nic">Shosho</lang>
    <lang code="nic">Bissa</lang>
    <lang code="nic">Bisa (Eastern Mande)</lang>
    <lang code="nic">Blowo</lang>
    <lang code="nic">Blo</lang>
    <lang code="nic">Dan-blo</lang>
    <lang code="nic">Western Dan</lang>
    <lang code="nic">Bobo Fing</lang>
    <lang code="nic">Black Bobo</lang>
    <lang code="nic">Bulse</lang>
    <lang code="nic">Finng</lang>
    <lang code="nic">Bokyi</lang>
    <lang code="nic">Boki</lang>
    <lang code="nic">Byoki</lang>
    <lang code="nic">Nfua</lang>
    <lang code="nic">Nki (Benue-Congo)</lang>
    <lang code="nic">Okii</lang>
    <lang code="nic">Osikom</lang>
    <lang code="nic">Osukam</lang>
    <lang code="nic">Uki (Benue-Congo)</lang>
    <lang code="nic">Vaaneroki</lang>
    <lang code="nic">Boomu</lang>
    <lang code="nic">Bomu</lang>
    <lang code="nic">Bozo</lang>
    <lang code="nic">Sorko</lang>
    <lang code="nic">Sorogo</lang>
    <lang code="nic">Brissa</lang>
    <lang code="nic">Anufo (Côte d'Ivoire)</lang>
    <lang code="nic">Bua languages</lang>
    <lang code="nic">Boua languages</lang>
    <lang code="nic">Buli</lang>
    <lang code="nic">Builsa</lang>
    <lang code="nic">Bulea</lang>
    <lang code="nic">Bulugu</lang>
    <lang code="nic">Guresha</lang>
    <lang code="nic">Kanjaga</lang>
    <lang code="nic">Busa</lang>
    <lang code="nic">Boko</lang>
    <lang code="nic">Bwamu</lang>
    <lang code="nic">Bobo Wule</lang>
    <lang code="nic">Bouamou</lang>
    <lang code="nic">Ci Gbe</lang>
    <lang code="nic">Ayizo-Ci</lang>
    <lang code="nic">Ci</lang>
    <lang code="nic">Cigbe</lang>
    <lang code="nic">Tchi</lang>
    <lang code="nic">Tschi</lang>
    <lang code="nic">Cross River Mbembe</lang>
    <lang code="nic">Ekokoma</lang>
    <lang code="nic">Ifunubwa</lang>
    <lang code="nic">Oderiga</lang>
    <lang code="nic">Ofunobwam</lang>
    <lang code="nic">Okam</lang>
    <lang code="nic">Wakande</lang>
    <lang code="nic">Dagaare</lang>
    <lang code="nic">Dagbani</lang>
    <lang code="nic">Dagomba</lang>
    <lang code="nic">Dan (Côte d'Ivoire)</lang>
    <lang code="nic">Gio</lang>
    <lang code="nic">Yacouba</lang>
    <lang code="nic">Degema</lang>
    <lang code="nic">Atala</lang>
    <lang code="nic">Udekama</lang>
    <lang code="nic">Denya</lang>
    <lang code="nic">Agnang</lang>
    <lang code="nic">Anyah</lang>
    <lang code="nic">Anyan</lang>
    <lang code="nic">Anyang</lang>
    <lang code="nic">Eyan</lang>
    <lang code="nic">Nyang (Denya)</lang>
    <lang code="nic">Obonya</lang>
    <lang code="nic">Takamanda</lang>
    <lang code="nic">Diola</lang>
    <lang code="nic">Dyola</lang>
    <lang code="nic">Yola</lang>
    <lang code="nic">Djimini</lang>
    <lang code="nic">Dyimini</lang>
    <lang code="nic">Gimini</lang>
    <lang code="nic">Jimini</lang>
    <lang code="nic">Jinmini</lang>
    <lang code="nic">Dogon</lang>
    <lang code="nic">Habe</lang>
    <lang code="nic">Tombo</lang>
    <lang code="nic">Ebira</lang>
    <lang code="nic">Egbira</lang>
    <lang code="nic">Igbira</lang>
    <lang code="nic">Eggon</lang>
    <lang code="nic">Ejagham</lang>
    <lang code="nic">Central Ekoi</lang>
    <lang code="nic">Ekwe</lang>
    <lang code="nic">Ezam</lang>
    <lang code="nic">Ekpeye</lang>
    <lang code="nic">Engenni</lang>
    <lang code="nic">Egene</lang>
    <lang code="nic">Ngene</lang>
    <lang code="nic">Esuulaalu</lang>
    <lang code="nic">Etsako</lang>
    <lang code="nic">Afenmai</lang>
    <lang code="nic">Iyekhee</lang>
    <lang code="nic">Kukuruku</lang>
    <lang code="nic">Yekhee</lang>
    <lang code="nic">Fali (Cameroon)</lang>
    <lang code="nic">Falli</lang>
    <lang code="nic">Falor</lang>
    <lang code="nic">Palor</lang>
    <lang code="nic">Farefare</lang>
    <lang code="nic">Frafra</lang>
    <lang code="nic">Gurenne</lang>
    <lang code="nic">Gurne</lang>
    <lang code="nic">Gurune</lang>
    <lang code="nic">Nankani</lang>
    <lang code="nic">Nankanse</lang>
    <lang code="nic">Ninkare</lang>
    <lang code="nic">Gbagyi</lang>
    <lang code="nic">Gbandi</lang>
    <lang code="nic">Bandi</lang>
    <lang code="nic">Gen-Gbe</lang>
    <lang code="nic">Gẽ</lang>
    <lang code="nic">Mina (Benin and Togo)</lang>
    <lang code="nic">Gikyode</lang>
    <lang code="nic">Chode</lang>
    <lang code="nic">Kyode</lang>
    <lang code="nic">Gonja</lang>
    <lang code="nic">Guang</lang>
    <lang code="nic">Gua</lang>
    <lang code="nic">Gwa (Ghana)</lang>
    <lang code="nic">Gun-Gbe</lang>
    <lang code="nic">Alada</lang>
    <lang code="nic">Egun</lang>
    <lang code="nic">Gurma</lang>
    <lang code="nic">Gourmantché</lang>
    <lang code="nic">Gulmance</lang>
    <lang code="nic">Guyuk</lang>
    <lang code="nic">Gweetaawu</lang>
    <lang code="nic">Dan-gouéta</lang>
    <lang code="nic">Eastern Dan</lang>
    <lang code="nic">Gouéta</lang>
    <lang code="nic">Gwétaawo</lang>
    <lang code="nic">Hanga (Ghana)</lang>
    <lang code="nic">Anga (Ghana)</lang>
    <lang code="nic">Hõne</lang>
    <lang code="nic">Jukun of Gwana</lang>
    <lang code="nic">Idoma</lang>
    <lang code="nic">Oturkpo</lang>
    <lang code="nic">Igede</lang>
    <lang code="nic">Igo</lang>
    <lang code="nic">Ahlon</lang>
    <lang code="nic">Anlo</lang>
    <lang code="nic">Ikwere</lang>
    <lang code="nic">Oratta-Ikwerri</lang>
    <lang code="nic">Indenie</lang>
    <lang code="nic">Ndenie</lang>
    <lang code="nic">Ndenye</lang>
    <lang code="nic">Ndinian</lang>
    <lang code="nic">Ndyenye</lang>
    <lang code="nic">Itsekiri</lang>
    <lang code="nic">Isekiri</lang>
    <lang code="nic">Izere</lang>
    <lang code="nic">Jarawa (Nigeria)</lang>
    <lang code="nic">Izi</lang>
    <lang code="nic">Jju</lang>
    <lang code="nic">Ju (Benue-Congo)</lang>
    <lang code="nic">Kaje</lang>
    <lang code="nic">Jowulu</lang>
    <lang code="nic">Jo</lang>
    <lang code="nic">Samogho (Jowulu)</lang>
    <lang code="nic">Samoighokan</lang>
    <lang code="nic">Jukun</lang>
    <lang code="nic">Kurorofa</lang>
    <lang code="nic">Kaansa</lang>
    <lang code="nic">Gã (Burkina Faso)</lang>
    <lang code="nic">Gan (Burkina Faso)</lang>
    <lang code="nic">Gane (Burkina Faso)</lang>
    <lang code="nic">Kaan (Burkina Faso)</lang>
    <lang code="nic">Kaanse</lang>
    <lang code="nic">Kãasa (Burkina Faso)</lang>
    <lang code="nic">Kan (Burkina Faso)</lang>
    <lang code="nic">Kabiye</lang>
    <lang code="nic">Kabre</lang>
    <lang code="nic">Kabye</lang>
    <lang code="nic">Kagoro (Mali)</lang>
    <lang code="nic">Kagoro (Nigeria)</lang>
    <lang code="nic">Gworok</lang>
    <lang code="nic">Kana</lang>
    <lang code="nic">Khana (Benue-Congo)</lang>
    <lang code="nic">Koana</lang>
    <lang code="nic">Ogoni (Kana)</lang>
    <lang code="nic">Karang (Cameroon)</lang>
    <lang code="nic">Kasem</lang>
    <lang code="nic">Kasena</lang>
    <lang code="nic">Kasim</lang>
    <lang code="nic">Kassem</lang>
    <lang code="nic">Kassene</lang>
    <lang code="nic">Kassonke</lang>
    <lang code="nic">Khassonke</lang>
    <lang code="nic">Kenyang</lang>
    <lang code="nic">Banjangi</lang>
    <lang code="nic">Banyang (Cameroon)</lang>
    <lang code="nic">Banyangi</lang>
    <lang code="nic">Bayangi</lang>
    <lang code="nic">Manyang</lang>
    <lang code="nic">Nyang (Kenyang)</lang>
    <lang code="nic">Kissi</lang>
    <lang code="nic">Kisi (West Africa)</lang>
    <lang code="nic">Konkomba</lang>
    <lang code="nic">Konni</lang>
    <lang code="nic">Koma (Ghana)</lang>
    <lang code="nic">Kposo</lang>
    <lang code="nic">Akposo</lang>
    <lang code="nic">Ikposo</lang>
    <lang code="nic">Krongo</lang>
    <lang code="nic">Kadumodi</lang>
    <lang code="nic">Kurungu</lang>
    <lang code="nic">Kulango</lang>
    <lang code="nic">Koulango</lang>
    <lang code="nic">Kpelego</lang>
    <lang code="nic">Nabe</lang>
    <lang code="nic">Ngwala</lang>
    <lang code="nic">Nkurange</lang>
    <lang code="nic">Zazere</lang>
    <lang code="nic">Kuo (Cameroon and Chad)</lang>
    <lang code="nic">Ko (Cameroon and Chad)</lang>
    <lang code="nic">Koh</lang>
    <lang code="nic">Kuranko</lang>
    <lang code="nic">Koranko</lang>
    <lang code="nic">Kurumba</lang>
    <lang code="nic">Deforo</lang>
    <lang code="nic">Foulse</lang>
    <lang code="nic">Fulse</lang>
    <lang code="nic">Koromfe</lang>
    <lang code="nic">Kouroumba</lang>
    <lang code="nic">Kurumfe</lang>
    <lang code="nic">Lilse</lang>
    <lang code="nic">Kusaal</lang>
    <lang code="nic">Kusasi</lang>
    <lang code="nic">Kuteb</lang>
    <lang code="nic">Ati (Kuteb)</lang>
    <lang code="nic">Jompre</lang>
    <lang code="nic">Kutep</lang>
    <lang code="nic">Kutev</lang>
    <lang code="nic">Mbarike</lang>
    <lang code="nic">Zumper</lang>
    <lang code="nic">Kwanja</lang>
    <lang code="nic">Kweni</lang>
    <lang code="nic">Gouro</lang>
    <lang code="nic">Lefana</lang>
    <lang code="nic">Bouem</lang>
    <lang code="nic">Buem</lang>
    <lang code="nic">Bwem</lang>
    <lang code="nic">Ligbi</lang>
    <lang code="nic">Limba</lang>
    <lang code="nic">Limbum</lang>
    <lang code="nic">Llimbumi</lang>
    <lang code="nic">Ndzungle</lang>
    <lang code="nic">Njungene</lang>
    <lang code="nic">Nsugni</lang>
    <lang code="nic">Wimbum</lang>
    <lang code="nic">Zungle</lang>
    <lang code="nic">Lobi</lang>
    <lang code="nic">Loko</lang>
    <lang code="nic">Landogo</lang>
    <lang code="nic">Loma</lang>
    <lang code="nic">Baru</lang>
    <lang code="nic">Buzi</lang>
    <lang code="nic">Lorma</lang>
    <lang code="nic">Longuda</lang>
    <lang code="nic">Nunguda</lang>
    <lang code="nic">Lorhon</lang>
    <lang code="nic">Loghon</lang>
    <lang code="nic">Lukpa</lang>
    <lang code="nic">Dompago</lang>
    <lang code="nic">Legba</lang>
    <lang code="nic">Ligba</lang>
    <lang code="nic">Ligbe</lang>
    <lang code="nic">Likpa</lang>
    <lang code="nic">Logba (Benin and Togo)</lang>
    <lang code="nic">Lokpa</lang>
    <lang code="nic">Lugba</lang>
    <lang code="nic">Lyele</lang>
    <lang code="nic">Lele (Burkina Faso)</lang>
    <lang code="nic">Mamara</lang>
    <lang code="nic">Bamana (Senufo)</lang>
    <lang code="nic">Mianka</lang>
    <lang code="nic">Minianka</lang>
    <lang code="nic">Minyanka</lang>
    <lang code="nic">Mambila</lang>
    <lang code="nic">Lagubi</lang>
    <lang code="nic">Nor</lang>
    <lang code="nic">Tagbo</lang>
    <lang code="nic">Torbi</lang>
    <lang code="nic">Mampruli</lang>
    <lang code="nic">Mandjak</lang>
    <lang code="nic">Mankanya</lang>
    <lang code="nic">Bola (Portuguese Guinea)</lang>
    <lang code="nic">Brame</lang>
    <lang code="nic">Bulama</lang>
    <lang code="nic">Mankon</lang>
    <lang code="nic">Mano</lang>
    <lang code="nic">Mayogo</lang>
    <lang code="nic">Mbili</lang>
    <lang code="nic">Mbum</lang>
    <lang code="nic">Mbam</lang>
    <lang code="nic">Mi Gangam</lang>
    <lang code="nic">Dye</lang>
    <lang code="nic">Gangam</lang>
    <lang code="nic">Ngangan</lang>
    <lang code="nic">Migili</lang>
    <lang code="nic">Koro Lafia</lang>
    <lang code="nic">Mo (Côte d'Ivoire and Ghana)</lang>
    <lang code="nic">Buru (Côte d'Ivoire and Ghana)</lang>
    <lang code="nic">Deg</lang>
    <lang code="nic">Mmfo</lang>
    <lang code="nic">Moba</lang>
    <lang code="nic">Mumuye</lang>
    <lang code="nic">Mundang</lang>
    <lang code="nic">Moundang</lang>
    <lang code="nic">Mungaka</lang>
    <lang code="nic">Bali (Cameroon)</lang>
    <lang code="nic">Ngaaka</lang>
    <lang code="nic">Mwan</lang>
    <lang code="nic">Mona</lang>
    <lang code="nic">Mouan</lang>
    <lang code="nic">Muan</lang>
    <lang code="nic">Muana</lang>
    <lang code="nic">Mwa</lang>
    <lang code="nic">Nafaanra</lang>
    <lang code="nic">Nawuri</lang>
    <lang code="nic">Nchumburu</lang>
    <lang code="nic">Chumburung</lang>
    <lang code="nic">Kyongborong</lang>
    <lang code="nic">Nchimburu</lang>
    <lang code="nic">Nchummuru</lang>
    <lang code="nic">Ndogo-Sere languages</lang>
    <lang code="nic">Ngbaka</lang>
    <lang code="nic">Ngbaka ma'bo</lang>
    <lang code="nic">Bwaka</lang>
    <lang code="nic">Ngbaka limba</lang>
    <lang code="nic">Nirere</lang>
    <lang code="nic">Ninzo</lang>
    <lang code="nic">Akiza</lang>
    <lang code="nic">Amar Tita</lang>
    <lang code="nic">Ancha</lang>
    <lang code="nic">Fadan Wate</lang>
    <lang code="nic">Gbhu D Amar Randfa</lang>
    <lang code="nic">Hate (Ninzo)</lang>
    <lang code="nic">Incha</lang>
    <lang code="nic">Kwasu</lang>
    <lang code="nic">Ninzam</lang>
    <lang code="nic">Nunzo</lang>
    <lang code="nic">Sambe</lang>
    <lang code="nic">Nkonya</lang>
    <lang code="nic">Nomaante</lang>
    <lang code="nic">Noon</lang>
    <lang code="nic">Noone</lang>
    <lang code="nic">Noni</lang>
    <lang code="nic">Northern Bullom</lang>
    <lang code="nic">Bullom, Northern</lang>
    <lang code="nic">Nunuma</lang>
    <lang code="nic">Nibulu</lang>
    <lang code="nic">Nouni</lang>
    <lang code="nic">Nupe</lang>
    <lang code="nic">Nope</lang>
    <lang code="nic">Ogbronuagum</lang>
    <lang code="nic">Oko</lang>
    <lang code="nic">Ogori</lang>
    <lang code="nic">Ogori-Magongo</lang>
    <lang code="nic">Ogori-Osayen</lang>
    <lang code="nic">Oko-Eni-Osayen</lang>
    <lang code="nic">Osanyen</lang>
    <lang code="nic">Osanyin</lang>
    <lang code="nic">Osayen</lang>
    <lang code="nic">Oku</lang>
    <lang code="nic">Bvukoo</lang>
    <lang code="nic">Ebkuo</lang>
    <lang code="nic">Ekpwo</lang>
    <lang code="nic">Kuo (Oku)</lang>
    <lang code="nic">Ukfwo</lang>
    <lang code="nic">Uku (Oku)</lang>
    <lang code="nic">Oron</lang>
    <lang code="nic">Pinyin</lang>
    <lang code="nic">Safaliba</lang>
    <lang code="nic">Safalaba</lang>
    <lang code="nic">Safalba</lang>
    <lang code="nic">Safali</lang>
    <lang code="nic">Samo (West Africa)</lang>
    <lang code="nic">Goe</lang>
    <lang code="nic">Matya</lang>
    <lang code="nic">Maya (Burkina Faso)</lang>
    <lang code="nic">Samogo-Sane</lang>
    <lang code="nic">San (Eastern Mande)</lang>
    <lang code="nic">Sane</lang>
    <lang code="nic">Sanwi</lang>
    <lang code="nic">Sembla</lang>
    <lang code="nic">Sambla</lang>
    <lang code="nic">Samogho-Senku</lang>
    <lang code="nic">Samogo-Senku</lang>
    <lang code="nic">Seeku</lang>
    <lang code="nic">Sembila</lang>
    <lang code="nic">Senku</lang>
    <lang code="nic">Southern Samo (Western Mande)</lang>
    <lang code="nic">Senari</lang>
    <lang code="nic">Senufo</lang>
    <lang code="nic">Senya</lang>
    <lang code="nic">Sherbro</lang>
    <lang code="nic">Bullom, Southern</lang>
    <lang code="nic">Southern Bullom</lang>
    <lang code="nic">Sissala</lang>
    <lang code="nic">Somba</lang>
    <lang code="nic">Betammadibe</lang>
    <lang code="nic">Ditammari</lang>
    <lang code="nic">Tamaba</lang>
    <lang code="nic">Tagbana</lang>
    <lang code="nic">Tampulma</lang>
    <lang code="nic">Tamprusi</lang>
    <lang code="nic">Téén</lang>
    <lang code="nic">Tem</lang>
    <lang code="nic">Cotocoli</lang>
    <lang code="nic">Kotokoli</lang>
    <lang code="nic">Tim</lang>
    <lang code="nic">Tigon Mbembe</lang>
    <lang code="nic">Akonto</lang>
    <lang code="nic">Akwanto</lang>
    <lang code="nic">Noale</lang>
    <lang code="nic">Tigim</lang>
    <lang code="nic">Tigon</lang>
    <lang code="nic">Tigong</lang>
    <lang code="nic">Tigum</lang>
    <lang code="nic">Tigun</lang>
    <lang code="nic">Tikun</lang>
    <lang code="nic">Tukun</lang>
    <lang code="nic">Tikar</lang>
    <lang code="nic">Tobote</lang>
    <lang code="nic">Basari (Togo and Ghana)</lang>
    <lang code="nic">Tofingbe</lang>
    <lang code="nic">Toma (Burkina Faso)</lang>
    <lang code="nic">Makaa (Burkina Faso)</lang>
    <lang code="nic">Nyaana</lang>
    <lang code="nic">Tura</lang>
    <lang code="nic">Toura</lang>
    <lang code="nic">Tusia</lang>
    <lang code="nic">Toussia</lang>
    <lang code="nic">Tuwunro</lang>
    <lang code="nic">Tyembara</lang>
    <lang code="nic">Ukaan</lang>
    <lang code="nic">Aika</lang>
    <lang code="nic">Anyaran</lang>
    <lang code="nic">Auga</lang>
    <lang code="nic">Ikan</lang>
    <lang code="nic">Kakumo</lang>
    <lang code="nic">Urhobo</lang>
    <lang code="nic">Vagala</lang>
    <lang code="nic">Kira</lang>
    <lang code="nic">Konosarola</lang>
    <lang code="nic">Siti</lang>
    <lang code="nic">Vige</lang>
    <lang code="nic">Winyé</lang>
    <lang code="nic">Kõ (Burkina Faso)</lang>
    <lang code="nic">Kols</lang>
    <lang code="nic">Kolsi</lang>
    <lang code="nic">Yakö</lang>
    <lang code="nic">Kö (Yakö)</lang>
    <lang code="nic">Lukö</lang>
    <lang code="nic">Yom</lang>
    <lang code="nic">Kpilakpila</lang>
    <lang code="nic">Pila</lang>
    <lang code="nic">Pilapila</lang>
    <lang code="ssa">Nilo-Saharan (Other)</lang>
    <lang code="ssa">Sub-Saharan African (Other)</lang>
    <lang code="ssa">Adhola</lang>
    <lang code="ssa">Dhopadhola</lang>
    <lang code="ssa">Ludama</lang>
    <lang code="ssa">Alur</lang>
    <lang code="ssa">Aloro</lang>
    <lang code="ssa">Alua</lang>
    <lang code="ssa">Alulu</lang>
    <lang code="ssa">Aluru</lang>
    <lang code="ssa">Dho Alur</lang>
    <lang code="ssa">Jo Alur</lang>
    <lang code="ssa">Lur (Alur)</lang>
    <lang code="ssa">Luri (Alur)</lang>
    <lang code="ssa">Anuak</lang>
    <lang code="ssa">Yambo</lang>
    <lang code="ssa">Aringa</lang>
    <lang code="ssa">Low Lugbara</lang>
    <lang code="ssa">Bagirmi</lang>
    <lang code="ssa">Barma</lang>
    <lang code="ssa">Baka</lang>
    <lang code="ssa">Tara Baaka</lang>
    <lang code="ssa">Bari</lang>
    <lang code="ssa">Dzilio</lang>
    <lang code="ssa">Birri (Central African Republic)</lang>
    <lang code="ssa">Abiri</lang>
    <lang code="ssa">Ambili</lang>
    <lang code="ssa">Biri (Central African Republic)</lang>
    <lang code="ssa">Bviri</lang>
    <lang code="ssa">Viri language</lang>
    <lang code="ssa">Bongo</lang>
    <lang code="ssa">Bongo-Bagirmi languages</lang>
    <lang code="ssa">Bor (Lwo)</lang>
    <lang code="ssa">Belanda</lang>
    <lang code="ssa">Dazaga</lang>
    <lang code="ssa">Dasa</lang>
    <lang code="ssa">Dasaga</lang>
    <lang code="ssa">Daza (Nilo-Saharan)</lang>
    <lang code="ssa">Dazagada</lang>
    <lang code="ssa">Dazza</lang>
    <lang code="ssa">Dazzaga</lang>
    <lang code="ssa">Tebu (Dazaga)</lang>
    <lang code="ssa">Tibbu (Dazaga)</lang>
    <lang code="ssa">Toubou (Dazaga)</lang>
    <lang code="ssa">Tubu (Dazaga)</lang>
    <lang code="ssa">Fur</lang>
    <lang code="ssa">Gambai</lang>
    <lang code="ssa">Kabba Laka</lang>
    <lang code="ssa">Ngambai</lang>
    <lang code="ssa">Sara Gambai</lang>
    <lang code="ssa">Ingassana</lang>
    <lang code="ssa">Gaam</lang>
    <lang code="ssa">Ingessana</lang>
    <lang code="ssa">Kamanidi</lang>
    <lang code="ssa">Mamidza</lang>
    <lang code="ssa">Memedja</lang>
    <lang code="ssa">Metabi</lang>
    <lang code="ssa">Muntabi</lang>
    <lang code="ssa">Tabi (Ingassana)</lang>
    <lang code="ssa">Jur Modo</lang>
    <lang code="ssa">Jur (Jur Modo)</lang>
    <lang code="ssa">Modo</lang>
    <lang code="ssa">Kaba (Central Sudanic)</lang>
    <lang code="ssa">Kalenjin</lang>
    <lang code="ssa">Kara (Central African Republic and Sudan)</lang>
    <lang code="ssa">Fer</lang>
    <lang code="ssa">Gula (Central African Republic and Sudan)</lang>
    <lang code="ssa">Yama</lang>
    <lang code="ssa">Yamegi</lang>
    <lang code="ssa">Karamojong</lang>
    <lang code="ssa">Akarimojong</lang>
    <lang code="ssa">Kenga</lang>
    <lang code="ssa">Kipsikis</lang>
    <lang code="ssa">Kreish</lang>
    <lang code="ssa">Kùláál</lang>
    <lang code="ssa">Gula (Lake Iro, Chad)</lang>
    <lang code="ssa">Kunama</lang>
    <lang code="ssa">Cunama</lang>
    <lang code="ssa">Lango (Uganda)</lang>
    <lang code="ssa">Lendu</lang>
    <lang code="ssa">Lese</lang>
    <lang code="ssa">Logo</lang>
    <lang code="ssa">Logo Kuli</lang>
    <lang code="ssa">Logoti</lang>
    <lang code="ssa">Lotuko</lang>
    <lang code="ssa">Latuka</lang>
    <lang code="ssa">Lugbara</lang>
    <lang code="ssa">Logbara</lang>
    <lang code="ssa">Logbware</lang>
    <lang code="ssa">Luguaret</lang>
    <lang code="ssa">Lugware</lang>
    <lang code="ssa">Lwo (Sudan)</lang>
    <lang code="ssa">Dhe Lwo</lang>
    <lang code="ssa">Dyur</lang>
    <lang code="ssa">Giur</lang>
    <lang code="ssa">Jo Lwo</lang>
    <lang code="ssa">Jur (Lwo (Sudan))</lang>
    <lang code="ssa">Luo (Sudan)</lang>
    <lang code="ssa">Maban</lang>
    <lang code="ssa">Meban</lang>
    <lang code="ssa">Maʾdi (Uganda and Sudan)</lang>
    <lang code="ssa">Madi-ti (Uganda and Sudan)</lang>
    <lang code="ssa">Majingai</lang>
    <lang code="ssa">Midjinngay</lang>
    <lang code="ssa">Moggingain</lang>
    <lang code="ssa">Sara-Majingai</lang>
    <lang code="ssa">Mamvu</lang>
    <lang code="ssa">Momvu</lang>
    <lang code="ssa">Monvu</lang>
    <lang code="ssa">Tengo</lang>
    <lang code="ssa">Mangbetu</lang>
    <lang code="ssa">Monbuttu</lang>
    <lang code="ssa">Mbai (Moissala)</lang>
    <lang code="ssa">Moissala Mbai</lang>
    <lang code="ssa">Sara Mbai (Moissala)</lang>
    <lang code="ssa">Moru</lang>
    <lang code="ssa">Murle</lang>
    <lang code="ssa">Beir</lang>
    <lang code="ssa">Nandi</lang>
    <lang code="ssa">Nara</lang>
    <lang code="ssa">Barea</lang>
    <lang code="ssa">Baria</lang>
    <lang code="ssa">Barya</lang>
    <lang code="ssa">Higir</lang>
    <lang code="ssa">Kolkotta</lang>
    <lang code="ssa">Koyta</lang>
    <lang code="ssa">Mogoreb</lang>
    <lang code="ssa">Morda</lang>
    <lang code="ssa">Nera</lang>
    <lang code="ssa">Nere</lang>
    <lang code="ssa">Santora</lang>
    <lang code="ssa">Ngama</lang>
    <lang code="ssa">Sara Ngama</lang>
    <lang code="ssa">Ngiti</lang>
    <lang code="ssa">Druna</lang>
    <lang code="ssa">Lendu, Southern</lang>
    <lang code="ssa">Ndruna</lang>
    <lang code="ssa">Southern Lendu</lang>
    <lang code="ssa">Nuer</lang>
    <lang code="ssa">Abigar</lang>
    <lang code="ssa">Nath</lang>
    <lang code="ssa">Päri (Sudan)</lang>
    <lang code="ssa">Proto-Eastern Sudanic</lang>
    <lang code="ssa">Sabaot</lang>
    <lang code="ssa">Samburu</lang>
    <lang code="ssa">Burkeneji</lang>
    <lang code="ssa">Lokop</lang>
    <lang code="ssa">Nkutuk</lang>
    <lang code="ssa">Sambur</lang>
    <lang code="ssa">Sampur</lang>
    <lang code="ssa">Sara</lang>
    <lang code="ssa">Majingai-Ngama</lang>
    <lang code="ssa">Suk</lang>
    <lang code="ssa">Pokot</lang>
    <lang code="ssa">Tedaga</lang>
    <lang code="ssa">Tebou</lang>
    <lang code="ssa">Tebu (Tedaga)</lang>
    <lang code="ssa">Teda</lang>
    <lang code="ssa">Tedagada</lang>
    <lang code="ssa">Tibbu (Tedaga)</lang>
    <lang code="ssa">Tibu</lang>
    <lang code="ssa">Toda (Africa)</lang>
    <lang code="ssa">Todaga</lang>
    <lang code="ssa">Todga</lang>
    <lang code="ssa">Toubou (Tedaga)</lang>
    <lang code="ssa">Tubu</lang>
    <lang code="ssa">Tuda (Africa)</lang>
    <lang code="ssa">Tuduga</lang>
    <lang code="ssa">Teso</lang>
    <lang code="ssa">Ateso</lang>
    <lang code="ssa">Iteso</lang>
    <lang code="ssa">Toposa</lang>
    <lang code="ssa">Abo (Sudan)</lang>
    <lang code="ssa">Akeroa</lang>
    <lang code="ssa">Dabossa</lang>
    <lang code="ssa">Huma (Sudan)</lang>
    <lang code="ssa">Kare (Sudan)</lang>
    <lang code="ssa">Khumi (Sudan)</lang>
    <lang code="ssa">Taposa</lang>
    <lang code="ssa">Turkana</lang>
    <lang code="ssa">Uduk</lang>
    <lang code="ssa">Yulu</lang>
    <lang code="ssa">Zaghawa</lang>
    <lang code="ssa">Beri-aa</lang>
    <lang code="ssa">Berri</lang>
    <lang code="ssa">Kebadi</lang>
    <lang code="ssa">Merida</lang>
    <lang code="ssa">Soghaua</lang>
    <lang code="ssa">Zeghawa</lang>
    <lang code="niu">Niuean</lang>
    <lang code="nqo">N'Ko</lang>
    <lang code="nog">Nogai</lang>
    <lang code="zxx">No linguistic content</lang>
    <lang code="nai">North American Indian (Other)</lang>
    <lang code="nai">Alabama</lang>
    <lang code="nai">Arikara</lang>
    <lang code="nai">Atsugewi</lang>
    <lang code="nai">Beothuk</lang>
    <lang code="nai">Chickasaw</lang>
    <lang code="nai">Chimariko</lang>
    <lang code="nai">Chitimacha</lang>
    <lang code="nai">Chetimacha</lang>
    <lang code="nai">Shetimasha</lang>
    <lang code="nai">Chumash</lang>
    <lang code="nai">Coahuilteco</lang>
    <lang code="nai">Tejano</lang>
    <lang code="nai">Cocopa</lang>
    <lang code="nai">Coos</lang>
    <lang code="nai">Kaus</lang>
    <lang code="nai">Kwokwoos</lang>
    <lang code="nai">Eastern Pomo</lang>
    <lang code="nai">Pomo, Eastern</lang>
    <lang code="nai">Eyak</lang>
    <lang code="nai">Ugalachmut</lang>
    <lang code="nai">Hualapai</lang>
    <lang code="nai">Jaguallapai</lang>
    <lang code="nai">Mataveke-paya</lang>
    <lang code="nai">Walapai</lang>
    <lang code="nai">Karok</lang>
    <lang code="nai">Keres</lang>
    <lang code="nai">Kiliwa</lang>
    <lang code="nai">Yukaliwa</lang>
    <lang code="nai">Konomihu</lang>
    <lang code="nai">Kuitsh</lang>
    <lang code="nai">Lower Umpqua</lang>
    <lang code="nai">Umpqua, Lower</lang>
    <lang code="nai">Kumiai</lang>
    <lang code="nai">Campo</lang>
    <lang code="nai">Cochimi (Diegueño)</lang>
    <lang code="nai">Comeya</lang>
    <lang code="nai">Cuchimí</lang>
    <lang code="nai">Diegueño</lang>
    <lang code="nai">Digueño</lang>
    <lang code="nai">Iipay</lang>
    <lang code="nai">Kamia</lang>
    <lang code="nai">Kamiai</lang>
    <lang code="nai">Kamiyahi</lang>
    <lang code="nai">Kamiyai</lang>
    <lang code="nai">Ki-Miai</lang>
    <lang code="nai">Ko'al</lang>
    <lang code="nai">Ku'ahl</lang>
    <lang code="nai">Kumeyaai</lang>
    <lang code="nai">Kumeyaay</lang>
    <lang code="nai">Kumia</lang>
    <lang code="nai">Kw'aal</lang>
    <lang code="nai">Quemayá</lang>
    <lang code="nai">Tiipay</lang>
    <lang code="nai">Tipai</lang>
    <lang code="nai">Maidu</lang>
    <lang code="nai">Pujunan</lang>
    <lang code="nai">Mikasuki</lang>
    <lang code="nai">Mekusuky</lang>
    <lang code="nai">Miwok languages</lang>
    <lang code="nai">Mewan</lang>
    <lang code="nai">Moquelumnan</lang>
    <lang code="nai">Mutsun</lang>
    <lang code="nai">Nez Percé</lang>
    <lang code="nai">Numipu</lang>
    <lang code="nai">Sahaptin</lang>
    <lang code="nai">Northern Sierra Miwok</lang>
    <lang code="nai">Miwok, Northern Sierra</lang>
    <lang code="nai">Ohlone</lang>
    <lang code="nai">Costanoan</lang>
    <lang code="nai">Paipai</lang>
    <lang code="nai">Pawnee</lang>
    <lang code="nai">Shoshoni</lang>
    <lang code="nai">Southeastern Pomo</lang>
    <lang code="nai">Pomo, Southeastern</lang>
    <lang code="nai">Timucua</lang>
    <lang code="nai">Tlakluit</lang>
    <lang code="nai">Echeloot</lang>
    <lang code="nai">Wishram</lang>
    <lang code="nai">Tonkawa</lang>
    <lang code="nai">Tunica</lang>
    <lang code="nai">Tonican</lang>
    <lang code="nai">Yoron</lang>
    <lang code="nai">Yuron</lang>
    <lang code="nai">Wappo</lang>
    <lang code="nai">Wichita</lang>
    <lang code="nai">Wikchamni</lang>
    <lang code="nai">Wükchamni</lang>
    <lang code="nai">Wintu</lang>
    <lang code="nai">Wiyot</lang>
    <lang code="nai">Yahi</lang>
    <lang code="nai">Yakama</lang>
    <lang code="nai">Yakima</lang>
    <lang code="nai">Yuchi</lang>
    <lang code="nai">Uchee</lang>
    <lang code="nai">Yuki</lang>
    <lang code="frr">North Frisian</lang>
    <lang code="frr">Frisian, North</lang>
    <lang code="sme">Northern Sami</lang>
    <lang code="sme">Sami, Northern</lang>
    <lang code="nso">Northern Sotho</lang>
    <lang code="nso">Pedi</lang>
    <lang code="nso">Sepedi</lang>
    <lang code="nso">Sotho, Northern</lang>
    <lang code="nso">Transvaal Sotho</lang>
    <lang code="nso">Pai (South Africa)</lang>
    <lang code="nso">Eastern Sotho</lang>
    <lang code="nor">Norwegian</lang>
    <lang code="nor">Bokmål</lang>
    <lang code="nor">Dano-Norwegian</lang>
    <lang code="nor">Riksmål</lang>
    <lang code="nor">Trøndersk</lang>
    <lang code="nor">Trønder</lang>
    <lang code="nor">Trøndesk</lang>
    <lang code="nor">Trøndsk</lang>
    <lang code="nob">Norwegian (Bokmål)</lang>
    <lang code="nob">Bokmål</lang>
    <lang code="nob">Dano-Norwegian</lang>
    <lang code="nob">Riksmål</lang>
    <lang code="nno">Norwegian (Nynorsk)</lang>
    <lang code="nno">Landsmaal</lang>
    <lang code="nno">Landsmål</lang>
    <lang code="nno">Nynorsk</lang>
    <lang code="nub">Nubian languages</lang>
    <lang code="nub">Dilling</lang>
    <lang code="nub">Delen</lang>
    <lang code="nub">Warkimbe</lang>
    <lang code="nub">Dongola-Kenuz</lang>
    <lang code="nub">Kenuz</lang>
    <lang code="nub">Mahas-Fiyadikka</lang>
    <lang code="nub">Fadicca</lang>
    <lang code="nub">Fiadidja</lang>
    <lang code="nub">Fiyadikka</lang>
    <lang code="nub">Nobiin</lang>
    <lang code="nub">Midob</lang>
    <lang code="nub">Old Nubian (to 1300)</lang>
    <lang code="nub">Nubian, Old</lang>
    <lang code="nym">Nyamwezi</lang>
    <lang code="nya">Nyanja</lang>
    <lang code="nya">Chinyanja</lang>
    <lang code="nya">Nyassa</lang>
    <lang code="nya">Chewa</lang>
    <lang code="nya">Cewa</lang>
    <lang code="nyn">Nyankole</lang>
    <lang code="nyn">Lunyankole</lang>
    <lang code="nyn">Nkole</lang>
    <lang code="nyn">Runyankore</lang>
    <lang code="nyo">Nyoro</lang>
    <lang code="nyo">Lunyoro</lang>
    <lang code="nyo">Urunyoro</lang>
    <lang code="nzi">Nzima</lang>
    <lang code="nzi">Nsima</lang>
    <lang code="nzi">Nzema</lang>
    <lang code="nzi">Zema</lang>
    <lang code="oci">Occitan (post-1500)</lang>
    <lang code="oci">Langue d'oc (post-1500)</lang>
    <lang code="oci">Provençal, Modern (post-1500)</lang>
    <lang code="oci">Béarnais (post-1500)</lang>
    <lang code="oci">Gascon (post-1500)</lang>
    <lang code="lan" status="obsolete">Occitan (post 1500)</lang>
    <lang code="xal">Oirat</lang>
    <lang code="xal">Oyrat</lang>
    <lang code="xal">Kalmyk</lang>
    <lang code="xal">Calmuck</lang>
    <lang code="xal">Zakhchin</lang>
    <lang code="xal">Dzakhachin</lang>
    <lang code="xal">Jakhachin</lang>
    <lang code="xal">Jaqacin</lang>
    <lang code="xal">Zaxacin</lang>
    <lang code="oji">Ojibwa</lang>
    <lang code="oji">Anishinabe</lang>
    <lang code="oji">Chippewa</lang>
    <lang code="oji">Otchipwe</lang>
    <lang code="oji">Salteaux</lang>
    <lang code="oji">Saulteaux</lang>
    <lang code="oji">Ottawa</lang>
    <lang code="non">Old Norse</lang>
    <lang code="non">Altnordish</lang>
    <lang code="non">Icelandic, Old (to 1550)</lang>
    <lang code="non">Norse, Old</lang>
    <lang code="non">Norse, Western</lang>
    <lang code="non">Norwegian, Old (to 1350)</lang>
    <lang code="non">Old Icelandic (to 1550)</lang>
    <lang code="non">Old Norwegian (to 1350)</lang>
    <lang code="non">Western Norse</lang>
    <lang code="peo">Old Persian (ca. 600-400 B.C.)</lang>
    <lang code="peo">Persian, Old (ca. 600-400 B.C.)</lang>
    <lang code="ori">Oriya</lang>
    <lang code="ori">Uriya</lang>
    <lang code="ori">Adiwasi Oriya</lang>
    <lang code="ori">Adibasi Oriyā</lang>
    <lang code="ori">Ādivāsi Oriyā</lang>
    <lang code="ori">Desai</lang>
    <lang code="ori">Kotia</lang>
    <lang code="ori">Kotia Oriya</lang>
    <lang code="ori">Kotiya</lang>
    <lang code="ori">Tribal Oriya</lang>
    <lang code="ori">Bhatri</lang>
    <lang code="ori">Basturia</lang>
    <lang code="ori">Bhatra</lang>
    <lang code="ori">Bhattra</lang>
    <lang code="ori">Bhattri</lang>
    <lang code="ori">Bhottada</lang>
    <lang code="ori">Bhottara</lang>
    <lang code="ori">Sambalpuri</lang>
    <lang code="orm">Oromo</lang>
    <lang code="orm">Afan</lang>
    <lang code="orm">Galla</lang>
    <lang code="orm">Gallinya</lang>
    <lang code="orm">Boran</lang>
    <lang code="orm">Orma</lang>
    <lang code="orm">Uardai</lang>
    <lang code="orm">Warday</lang>
    <lang code="gal" status="obsolete">Oromo</lang>
    <lang code="osa">Osage</lang>
    <lang code="oss">Ossetic</lang>
    <lang code="oss">Āsī</lang>
    <lang code="oss">Oseti</lang>
    <lang code="oss">Ossete</lang>
    <lang code="oss">Ossetian</lang>
    <lang code="oss">Osi</lang>
    <lang code="oss">Ūsatī</lang>
    <lang code="oto">Otomian languages</lang>
    <lang code="oto">Chichimeca-Jonaz</lang>
    <lang code="oto">Chichimeco</lang>
    <lang code="oto">Meco</lang>
    <lang code="oto">Pame de Chichimeca-Jonaz</lang>
    <lang code="oto">Matlatzinca</lang>
    <lang code="oto">Pirinda</lang>
    <lang code="oto">Mazahua</lang>
    <lang code="oto">Ocuiltec</lang>
    <lang code="oto">Atzinca</lang>
    <lang code="oto">Maclatzinca</lang>
    <lang code="oto">Tlahuica</lang>
    <lang code="oto">Otomi</lang>
    <lang code="oto">Hñahñu</lang>
    <lang code="oto">Othomi</lang>
    <lang code="oto">Pame</lang>
    <lang code="oto">Chichimeca Pame</lang>
    <lang code="pal">Pahlavi</lang>
    <lang code="pal">Huzvaresh</lang>
    <lang code="pal">Middle Persian (Pahlavi)</lang>
    <lang code="pal">Parsi</lang>
    <lang code="pal">Pazend</lang>
    <lang code="pal">Pehlevi</lang>
    <lang code="pal">Persian, Middle (Pahlavi)</lang>
    <lang code="pau">Palauan</lang>
    <lang code="pau">Pelew</lang>
    <lang code="pli">Pali</lang>
    <lang code="pam">Pampanga</lang>
    <lang code="pam">Kapampangan</lang>
    <lang code="pag">Pangasinan</lang>
    <lang code="pan">Panjabi</lang>
    <lang code="pan">Eastern Panjabi</lang>
    <lang code="pan">Punjabi</lang>
    <lang code="pap">Papiamento</lang>
    <lang code="paa">Papuan (Other)</lang>
    <lang code="paa">Abau</lang>
    <lang code="paa">Green River</lang>
    <lang code="paa">Abulas</lang>
    <lang code="paa">Ambulas</lang>
    <lang code="paa">Maprik</lang>
    <lang code="paa">Agarabe</lang>
    <lang code="paa">Alamblak</lang>
    <lang code="paa">Ama (Papua New Guinea)</lang>
    <lang code="paa">Sawiyanu</lang>
    <lang code="paa">Amele</lang>
    <lang code="paa">Ampale</lang>
    <lang code="paa">Ampeeli</lang>
    <lang code="paa">Safeyoka</lang>
    <lang code="paa">Aneme Wake</lang>
    <lang code="paa">Abia</lang>
    <lang code="paa">Musa, Upper</lang>
    <lang code="paa">Upper Musa</lang>
    <lang code="paa">Anggor</lang>
    <lang code="paa">Bibriari</lang>
    <lang code="paa">Senagi</lang>
    <lang code="paa">Watapor</lang>
    <lang code="paa">Ankave</lang>
    <lang code="paa">Angave</lang>
    <lang code="paa">Aomie</lang>
    <lang code="paa">Omie</lang>
    <lang code="paa">Asaro</lang>
    <lang code="paa">Dano</lang>
    <lang code="paa">Upper Asaro</lang>
    <lang code="paa">Asmat</lang>
    <lang code="paa">Au</lang>
    <lang code="paa">Auyana</lang>
    <lang code="paa">Awa (Eastern Highlands Province, Papua New Guinea)</lang>
    <lang code="paa">Bahinemo</lang>
    <lang code="paa">Gahom</lang>
    <lang code="paa">Wogu</lang>
    <lang code="paa">Baining</lang>
    <lang code="paa">Kakat</lang>
    <lang code="paa">Makakat</lang>
    <lang code="paa">Maqaqet</lang>
    <lang code="paa">Qaqet</lang>
    <lang code="paa">Barai</lang>
    <lang code="paa">Baruya</lang>
    <lang code="paa">Bauzi</lang>
    <lang code="paa">Baudi</lang>
    <lang code="paa">Bauri</lang>
    <lang code="paa">Pauwi</lang>
    <lang code="paa">Benabena</lang>
    <lang code="paa">Bena (Papua New Guinea)</lang>
    <lang code="paa">Bena-bena</lang>
    <lang code="paa">Berik</lang>
    <lang code="paa">Biangai</lang>
    <lang code="paa">Baingai</lang>
    <lang code="paa">Bimin</lang>
    <lang code="paa">Binumarien</lang>
    <lang code="paa">Bisorio</lang>
    <lang code="paa">Gadio</lang>
    <lang code="paa">Iniai</lang>
    <lang code="paa">Blagar</lang>
    <lang code="paa">Belagar</lang>
    <lang code="paa">Tarang</lang>
    <lang code="paa">Bom</lang>
    <lang code="paa">Anjam</lang>
    <lang code="paa">Bogadjim</lang>
    <lang code="paa">Lalok</lang>
    <lang code="paa">Buin</lang>
    <lang code="paa">Rugara</lang>
    <lang code="paa">Telei</lang>
    <lang code="paa">Bunak</lang>
    <lang code="paa">Buna' (Indonesia)</lang>
    <lang code="paa">Bunake</lang>
    <lang code="paa">Bunaq</lang>
    <lang code="paa">Burum (Papua New Guinea)</lang>
    <lang code="paa">Bulum</lang>
    <lang code="paa">Chuave</lang>
    <lang code="paa">Tjuave</lang>
    <lang code="paa">Daga</lang>
    <lang code="paa">Dimuga</lang>
    <lang code="paa">Nawp</lang>
    <lang code="paa">Daribi</lang>
    <lang code="paa">Elu</lang>
    <lang code="paa">Karimui</lang>
    <lang code="paa">Makarub</lang>
    <lang code="paa">Mikaru</lang>
    <lang code="paa">Dedua</lang>
    <lang code="paa">Duna</lang>
    <lang code="paa">Yuna</lang>
    <lang code="paa">Eipo</lang>
    <lang code="paa">Enga</lang>
    <lang code="paa">Tsaga</lang>
    <lang code="paa">Ese</lang>
    <lang code="paa">Managalasi</lang>
    <lang code="paa">Managulasi</lang>
    <lang code="paa">Faiwol</lang>
    <lang code="paa">Fegolmin</lang>
    <lang code="paa">Fasu</lang>
    <lang code="paa">Folopa</lang>
    <lang code="paa">Fore</lang>
    <lang code="paa">Gadsup</lang>
    <lang code="paa">Gahuku</lang>
    <lang code="paa">Galela</lang>
    <lang code="paa">Gimi</lang>
    <lang code="paa">Gogodala</lang>
    <lang code="paa">Golin</lang>
    <lang code="paa">Gope</lang>
    <lang code="paa">Era River</lang>
    <lang code="paa">Kope</lang>
    <lang code="paa">Gresi</lang>
    <lang code="paa">Glesi</lang>
    <lang code="paa">Gresik</lang>
    <lang code="paa">Klesi</lang>
    <lang code="paa">Guhu-Samane</lang>
    <lang code="paa">Mid-Waria</lang>
    <lang code="paa">Gwahatike</lang>
    <lang code="paa">Gwedena</lang>
    <lang code="paa">Umanakaina</lang>
    <lang code="paa">Halopa</lang>
    <lang code="paa">Botelkude</lang>
    <lang code="paa">Nobonob</lang>
    <lang code="paa">Nupanob</lang>
    <lang code="paa">Huli</lang>
    <lang code="paa">Iatmul</lang>
    <lang code="paa">Big Sepik</lang>
    <lang code="paa">Imbongu</lang>
    <lang code="paa">Au (Imbongu)</lang>
    <lang code="paa">Aua</lang>
    <lang code="paa">Awa (Imbongu)</lang>
    <lang code="paa">Ibo Ugu</lang>
    <lang code="paa">Imbo Ungo</lang>
    <lang code="paa">Imbo Ungu (Imbongu)</lang>
    <lang code="paa">Imbon Ggo</lang>
    <lang code="paa">Imbonggo</lang>
    <lang code="paa">Imbonggu</lang>
    <lang code="paa">Inanwatan</lang>
    <lang code="paa">Suabo</lang>
    <lang code="paa">Inoke</lang>
    <lang code="paa">Yate (Papua New Guinea)</lang>
    <lang code="paa">Irumu</lang>
    <lang code="paa">Iwam</lang>
    <lang code="paa">Iyo (Papua New Guinea)</lang>
    <lang code="paa">Bure (Papua New Guinea)</lang>
    <lang code="paa">Nabu</lang>
    <lang code="paa">Naho</lang>
    <lang code="paa">Nahu</lang>
    <lang code="paa">Ndo (Papua New Guinea)</lang>
    <lang code="paa">Kalabra</lang>
    <lang code="paa">Kalam</lang>
    <lang code="paa">Karam</lang>
    <lang code="paa">Kaluli</lang>
    <lang code="paa">Kamano</lang>
    <lang code="paa">Kafe</lang>
    <lang code="paa">Kamasau</lang>
    <lang code="paa">Kamtuk</lang>
    <lang code="paa">Kemtuik</lang>
    <lang code="paa">Kanite</lang>
    <lang code="paa">Kemiju Jate</lang>
    <lang code="paa">Kapauku</lang>
    <lang code="paa">Ekagi</lang>
    <lang code="paa">Kasua</lang>
    <lang code="paa">Kâte</lang>
    <lang code="paa">Kelon</lang>
    <lang code="paa">Kalong</lang>
    <lang code="paa">Kelong</lang>
    <lang code="paa">Klon</lang>
    <lang code="paa">Kolon</lang>
    <lang code="paa">Ketengban</lang>
    <lang code="paa">Oktengban</lang>
    <lang code="paa">Kewa</lang>
    <lang code="paa">Kobon</lang>
    <lang code="paa">Komba</lang>
    <lang code="paa">Komunku</lang>
    <lang code="paa">Kongara</lang>
    <lang code="paa">Korape</lang>
    <lang code="paa">Kwarafe</lang>
    <lang code="paa">Okeina</lang>
    <lang code="paa">Kosena</lang>
    <lang code="paa">Kovai</lang>
    <lang code="paa">Alngubin</lang>
    <lang code="paa">Kobai</lang>
    <lang code="paa">Kowai</lang>
    <lang code="paa">Umboi</lang>
    <lang code="paa">Kunimaipa</lang>
    <lang code="paa">Kwerba</lang>
    <lang code="paa">Lambau</lang>
    <lang code="paa">Lunambe</lang>
    <lang code="paa">Mai Brat</lang>
    <lang code="paa">Mey Brat</lang>
    <lang code="paa">Manambu</lang>
    <lang code="paa">Mape</lang>
    <lang code="paa">Meax</lang>
    <lang code="paa">Medlpa</lang>
    <lang code="paa">Hagen</lang>
    <lang code="paa">Moglei</lang>
    <lang code="paa">Menya</lang>
    <lang code="paa">Menyama</lang>
    <lang code="paa">Menye</lang>
    <lang code="paa">Mianmin</lang>
    <lang code="paa">Migabac</lang>
    <lang code="paa">Migaba'</lang>
    <lang code="paa">Miyemu</lang>
    <lang code="paa">Bo Ung</lang>
    <lang code="paa">Miyam</lang>
    <lang code="paa">Miyem</lang>
    <lang code="paa">Tembalu</lang>
    <lang code="paa">Tembogia</lang>
    <lang code="paa">Tetalo</lang>
    <lang code="paa">Monumbo</lang>
    <lang code="paa">Mountain Arapesh</lang>
    <lang code="paa">Arapesh, Mountain</lang>
    <lang code="paa">Bukiyup</lang>
    <lang code="paa">Mountain Koiari</lang>
    <lang code="paa">Koiali, Mountain</lang>
    <lang code="paa">Mpur (Indonesia)</lang>
    <lang code="paa">Amberbaken</lang>
    <lang code="paa">Mugil</lang>
    <lang code="paa">Bargam</lang>
    <lang code="paa">Saker</lang>
    <lang code="paa">Nabak</lang>
    <lang code="paa">Wain</lang>
    <lang code="paa">Nankina</lang>
    <lang code="paa">Narak</lang>
    <lang code="paa">Gandja</lang>
    <lang code="paa">Kandawo</lang>
    <lang code="paa">Kol (Papua New Guinea)</lang>
    <lang code="paa">Nasioi</lang>
    <lang code="paa">Nek</lang>
    <lang code="paa">Nii</lang>
    <lang code="paa">Ek Nii</lang>
    <lang code="paa">Notu</lang>
    <lang code="paa">Ewage</lang>
    <lang code="paa">Oksapmin</lang>
    <lang code="paa">Olo</lang>
    <lang code="paa">Orlei</lang>
    <lang code="paa">Ono</lang>
    <lang code="paa">Orokaiva</lang>
    <lang code="paa">Orokolo</lang>
    <lang code="paa">Orya</lang>
    <lang code="paa">Oria</lang>
    <lang code="paa">Uria</lang>
    <lang code="paa">Pay</lang>
    <lang code="paa">Pinai-Hagahai</lang>
    <lang code="paa">Purari</lang>
    <lang code="paa">Eurika</lang>
    <lang code="paa">Evora</lang>
    <lang code="paa">Iai (Papua New Guinea)</lang>
    <lang code="paa">Iare</lang>
    <lang code="paa">Kaimare</lang>
    <lang code="paa">Kaura (Papua New Guinea)</lang>
    <lang code="paa">Kipaia</lang>
    <lang code="paa">Koriki</lang>
    <lang code="paa">Maipua</lang>
    <lang code="paa">Namau</lang>
    <lang code="paa">Rawa</lang>
    <lang code="paa">Karo-Rawa</lang>
    <lang code="paa">Rotokas</lang>
    <lang code="paa">Saberi</lang>
    <lang code="paa">Isirawa</lang>
    <lang code="paa">Okwasar</lang>
    <lang code="paa">Sahu</lang>
    <lang code="paa">Samo (Western Province, Papua New Guinea)</lang>
    <lang code="paa">Supei</lang>
    <lang code="paa">Sawos</lang>
    <lang code="paa">Tshwosh</lang>
    <lang code="paa">Selepet</lang>
    <lang code="paa">Sentani</lang>
    <lang code="paa">Siane</lang>
    <lang code="paa">Siroi</lang>
    <lang code="paa">Pasa</lang>
    <lang code="paa">Suroi</lang>
    <lang code="paa">Siwai</lang>
    <lang code="paa">Motuna</lang>
    <lang code="paa">Sona (Papua New Guinea)</lang>
    <lang code="paa">Kanasi</lang>
    <lang code="paa">Suena</lang>
    <lang code="paa">Yarawe</lang>
    <lang code="paa">Yema</lang>
    <lang code="paa">Sulka</lang>
    <lang code="paa">Tabla</lang>
    <lang code="paa">Tanahmerah (Northeast Irian Jaya)</lang>
    <lang code="paa">Tairora</lang>
    <lang code="paa">Tani</lang>
    <lang code="paa">Miami (Papua New Guinea)</lang>
    <lang code="paa">Miani</lang>
    <lang code="paa">Suaru</lang>
    <lang code="paa">Tauya</lang>
    <lang code="paa">Inafosa</lang>
    <lang code="paa">Telefol</lang>
    <lang code="paa">Tepera</lang>
    <lang code="paa">Ternate</lang>
    <lang code="paa">Tewa (Papuan)</lang>
    <lang code="paa">Teiwa</lang>
    <lang code="paa">Tifal</lang>
    <lang code="paa">Timbe</lang>
    <lang code="paa">Toaripi</lang>
    <lang code="paa">Motumotu</lang>
    <lang code="paa">Tobelo</lang>
    <lang code="paa">Umbu-Ungu</lang>
    <lang code="paa">Gawigl</lang>
    <lang code="paa">Gawil</lang>
    <lang code="paa">Imbo-Ungu (Umbu-Ungu)</lang>
    <lang code="paa">Kakoli</lang>
    <lang code="paa">Kaugel (Umbu-Ungu)</lang>
    <lang code="paa">Kauil</lang>
    <lang code="paa">Ubu Ugu</lang>
    <lang code="paa">Umbongu</lang>
    <lang code="paa">Umbu</lang>
    <lang code="paa">Urii</lang>
    <lang code="paa">Usarufa</lang>
    <lang code="paa">Usurufa</lang>
    <lang code="paa">Uturupa</lang>
    <lang code="paa">Waffa</lang>
    <lang code="paa">Wantoat</lang>
    <lang code="paa">Washkuk</lang>
    <lang code="paa">Kwoma</lang>
    <lang code="paa">Wasi</lang>
    <lang code="paa">Were</lang>
    <lang code="paa">West Makian</lang>
    <lang code="paa">Desite</lang>
    <lang code="paa">Makian, West</lang>
    <lang code="paa">Titinec</lang>
    <lang code="paa">Wiru</lang>
    <lang code="paa">Woisika</lang>
    <lang code="paa">Yabiyufa</lang>
    <lang code="paa">Jafijufa</lang>
    <lang code="paa">Yagaria</lang>
    <lang code="paa">Frigano Jate</lang>
    <lang code="paa">Kami (Papua New Guinea)</lang>
    <lang code="paa">Yangoru</lang>
    <lang code="paa">Yareba</lang>
    <lang code="paa">Yau</lang>
    <lang code="paa">Yessan-Mayo</lang>
    <lang code="paa">Mayo (New Guinea)</lang>
    <lang code="paa">Yongkom</lang>
    <lang code="paa">Yopno</lang>
    <lang code="paa">Yupna</lang>
    <lang code="paa">Yui</lang>
    <lang code="paa">Salt-Yui</lang>
    <lang code="paa">Zia</lang>
    <lang code="per">Persian</lang>
    <lang code="per">Farsi</lang>
    <lang code="per">Dari</lang>
    <lang code="per">Kabuli</lang>
    <lang code="per">Kabuli-Persian</lang>
    <lang code="per">Khorasani</lang>
    <lang code="phi">Philippine (Other)</lang>
    <lang code="phi">Abaknon</lang>
    <lang code="phi">Capul</lang>
    <lang code="phi">Inabaknon</lang>
    <lang code="phi">Kapul</lang>
    <lang code="phi">Sama Abaknon</lang>
    <lang code="phi">Agta</lang>
    <lang code="phi">Cagayan Agta, Central</lang>
    <lang code="phi">Central Cagayan Agta</lang>
    <lang code="phi">Agutaynon</lang>
    <lang code="phi">Aklanon</lang>
    <lang code="phi">Alangan</lang>
    <lang code="phi">Amganad Ifugao</lang>
    <lang code="phi">Ifugao, Amganad</lang>
    <lang code="phi">Atta</lang>
    <lang code="phi">Northern Cagayan Negrito</lang>
    <lang code="phi">Ayangan Ifugao</lang>
    <lang code="phi">Ifugao, Ayangan</lang>
    <lang code="phi">Bagobo</lang>
    <lang code="phi">Balangao</lang>
    <lang code="phi">Balangingì</lang>
    <lang code="phi">Baangingi'</lang>
    <lang code="phi">Bangingi</lang>
    <lang code="phi">Northern Sinama</lang>
    <lang code="phi">Sama Bangingì</lang>
    <lang code="phi">Sea Samal</lang>
    <lang code="phi">Sinama, Northern</lang>
    <lang code="phi">Banton</lang>
    <lang code="phi">Bantuanon</lang>
    <lang code="phi">Batad Ifugao</lang>
    <lang code="phi">Ifugao, Batad</lang>
    <lang code="phi">Bilaan</lang>
    <lang code="phi">Bolinao</lang>
    <lang code="phi">Binubolinao</lang>
    <lang code="phi">Bontoc</lang>
    <lang code="phi">Finontok</lang>
    <lang code="phi">Botolan Sambal</lang>
    <lang code="phi">Aeta Negrito</lang>
    <lang code="phi">Sambal Botolan</lang>
    <lang code="phi">Sambali Botolan</lang>
    <lang code="phi">Caluyanun</lang>
    <lang code="phi">Central Bontoc</lang>
    <lang code="phi">Bontoc, Central</lang>
    <lang code="phi">Central Subanen</lang>
    <lang code="phi">Sindangan Subanun</lang>
    <lang code="phi">Subanen, Central</lang>
    <lang code="phi">Subanun, Sindangan</lang>
    <lang code="phi">Cuyunon</lang>
    <lang code="phi">Kuyonon</lang>
    <lang code="phi">Dumagat (Casiguran)</lang>
    <lang code="phi">Agta (Casiguran)</lang>
    <lang code="phi">Casiguran Agta</lang>
    <lang code="phi">Casiguran Dumagat</lang>
    <lang code="phi">Dumagat (Umirey)</lang>
    <lang code="phi">Agta (Umirey)</lang>
    <lang code="phi">Dingalan Dumagat</lang>
    <lang code="phi">Umirey Agta</lang>
    <lang code="phi">Umirey Dumagat</lang>
    <lang code="phi">Eastern Bontoc</lang>
    <lang code="phi">Bontoc, Eastern</lang>
    <lang code="phi">Eastern Ifugao</lang>
    <lang code="phi">Ifugao, Eastern</lang>
    <lang code="phi">Gaddang</lang>
    <lang code="phi">Ibaloi</lang>
    <lang code="phi">Benguet Igorot</lang>
    <lang code="phi">Nabaloi</lang>
    <lang code="phi">Ibanag</lang>
    <lang code="phi">Ifugao</lang>
    <lang code="phi">Ilongot</lang>
    <lang code="phi">Isinay</lang>
    <lang code="phi">Inmeas</lang>
    <lang code="phi">Isneg</lang>
    <lang code="phi">Apayao</lang>
    <lang code="phi">Itawis</lang>
    <lang code="phi">Itbayat</lang>
    <lang code="phi">Ivatan</lang>
    <lang code="phi">Jama Mapun</lang>
    <lang code="phi">Cagayanon</lang>
    <lang code="phi">Mapun</lang>
    <lang code="phi">Pullon Mapun</lang>
    <lang code="phi">Sama Mapun</lang>
    <lang code="phi">Ivatan</lang>
    <lang code="phi">Batan</lang>
    <lang code="phi">Ibatan</lang>
    <lang code="phi">Kalamian</lang>
    <lang code="phi">Calamian</lang>
    <lang code="phi">Kalinga languages</lang>
    <lang code="phi">Kankanay</lang>
    <lang code="phi">Cancanai</lang>
    <lang code="phi">Lepanto-Igorot</lang>
    <lang code="phi">Kinaray-a</lang>
    <lang code="phi">Antiqueno</lang>
    <lang code="phi">Binukidnon</lang>
    <lang code="phi">Hamtiknon</lang>
    <lang code="phi">Hinaraya</lang>
    <lang code="phi">Karay-a</lang>
    <lang code="phi">Lower Tanudan Kalinga</lang>
    <lang code="phi">Kalinga, Lower Tanudan</lang>
    <lang code="phi">Tanudan Kalinga, Lower</lang>
    <lang code="phi">Magindanao</lang>
    <lang code="phi">Moro</lang>
    <lang code="phi">Mamanwa</lang>
    <lang code="phi">Mangyan</lang>
    <lang code="phi">Iraya</lang>
    <lang code="phi">Mansaka</lang>
    <lang code="phi">Maranao</lang>
    <lang code="phi">Moro</lang>
    <lang code="phi">Masbateno</lang>
    <lang code="phi">Minasbate</lang>
    <lang code="phi">Mayoyao Ifugao</lang>
    <lang code="phi">Ifugao, Mayoyao</lang>
    <lang code="phi">Melebuganon</lang>
    <lang code="phi">Milebuganon</lang>
    <lang code="phi">Molbog</lang>
    <lang code="phi">Northern Kankanay</lang>
    <lang code="phi">Bontoc, Western</lang>
    <lang code="phi">Kankanay, Northern</lang>
    <lang code="phi">Sagada-Igorot</lang>
    <lang code="phi">Western Bontoc</lang>
    <lang code="phi">Palawano</lang>
    <lang code="phi">Pangutaran Sama</lang>
    <lang code="phi">Sama Pangutaran</lang>
    <lang code="phi">Sama Sibutu</lang>
    <lang code="phi">Sibutu Sama</lang>
    <lang code="phi">Southern Sama</lang>
    <lang code="phi">Sambali</lang>
    <lang code="phi">Zambal</lang>
    <lang code="phi">Southern Bontoc</lang>
    <lang code="phi">Barlig Bontoc</lang>
    <lang code="phi">Bontoc, Southern</lang>
    <lang code="phi">Kadaklan Barlig Bontoc</lang>
    <lang code="phi">Southern Subanen</lang>
    <lang code="phi">Lapuyan Subanen</lang>
    <lang code="phi">Margosatubig Subanun</lang>
    <lang code="phi">Subanen, Southern</lang>
    <lang code="phi">Subanun</lang>
    <lang code="phi">Subano</lang>
    <lang code="phi">Sulod</lang>
    <lang code="phi">Mundu (Philippines)</lang>
    <lang code="phi">Sulu</lang>
    <lang code="phi">Joloano</lang>
    <lang code="phi">Moro</lang>
    <lang code="phi">Sooloo</lang>
    <lang code="phi">Tagakaolo</lang>
    <lang code="phi">Kalagan, Tagakaolo</lang>
    <lang code="phi">Tagbanua</lang>
    <lang code="phi">Aborlan Tagbanwa</lang>
    <lang code="phi">Apurahuano</lang>
    <lang code="phi">Tausug</lang>
    <lang code="phi">Tboli</lang>
    <lang code="phi">Tagabili</lang>
    <lang code="phi">Tiboli</lang>
    <lang code="phi">Tina Sambal</lang>
    <lang code="phi">Tiruray</lang>
    <lang code="phi">Teduray</lang>
    <lang code="phi">Tuwali</lang>
    <lang code="phi">Western Subanon</lang>
    <lang code="phi">Siocan Subanon</lang>
    <lang code="phi">Subanon, Western</lang>
    <lang code="phi">Yakan</lang>
    <lang code="phn">Phoenician</lang>
    <lang code="phn">Punic</lang>
    <lang code="pon">Pohnpeian</lang>
    <lang code="pon">Ponape</lang>
    <lang code="pon">Ponapean</lang>
    <lang code="pol">Polish</lang>
    <lang code="por">Portuguese</lang>
    <lang code="pra">Prakrit languages</lang>
    <lang code="pra">Gandhari Prakrit</lang>
    <lang code="pra">Gandhari</lang>
    <lang code="pra">Magadhi Prakrit</lang>
    <lang code="pra">Maharashtri</lang>
    <lang code="pra">Śaurasēnī</lang>
    <lang code="pro">Provençal (to 1500)</lang>
    <lang code="pro">Occitan, Old (to 1500)</lang>
    <lang code="pro">Old Occitan (to 1500)</lang>
    <lang code="pro">Old Provençal (to 1500)</lang>
    <lang code="pus">Pushto</lang>
    <lang code="pus">Afghan</lang>
    <lang code="pus">Pakhto</lang>
    <lang code="pus">Pakkhto</lang>
    <lang code="pus">Pashto</lang>
    <lang code="pus">Pashtu</lang>
    <lang code="pus">Pukhtu</lang>
    <lang code="pus">Pukkhto</lang>
    <lang code="pus">Pukshto</lang>
    <lang code="pus">Pushtu</lang>
    <lang code="pus">Wanetsi</lang>
    <lang code="pus">Vanechi</lang>
    <lang code="pus">Waneci</lang>
    <lang code="pus">Wanesi</lang>
    <lang code="pus">Wenetsi</lang>
    <lang code="que">Quechua</lang>
    <lang code="que">Inca</lang>
    <lang code="que">Kechua</lang>
    <lang code="que">Quichua</lang>
    <lang code="que">Runasimi</lang>
    <lang code="que">Huanca</lang>
    <lang code="que">Wanka</lang>
    <lang code="que">Ingano</lang>
    <lang code="que">Inga</lang>
    <lang code="roh">Raeto-Romance</lang>
    <lang code="roh">Rhaeto-Romance</lang>
    <lang code="roh">Romansh</lang>
    <lang code="roh">Rumansh</lang>
    <lang code="raj">Rajasthani</lang>
    <lang code="raj">Bagri</lang>
    <lang code="raj">Bagari</lang>
    <lang code="raj">Bahgri</lang>
    <lang code="raj">Baorias</lang>
    <lang code="raj">Gujuri</lang>
    <lang code="raj">Gojari</lang>
    <lang code="raj">Gojri</lang>
    <lang code="raj">Gujar</lang>
    <lang code="raj">Gujari</lang>
    <lang code="raj">Gujer</lang>
    <lang code="raj">Gujjari</lang>
    <lang code="raj">Gujri (Gujuri)</lang>
    <lang code="raj">Harauti</lang>
    <lang code="raj">Jaipurī</lang>
    <lang code="raj">Dhundhari</lang>
    <lang code="raj">Lambadi</lang>
    <lang code="raj">Banjara</lang>
    <lang code="raj">Labhani</lang>
    <lang code="raj">Lamani</lang>
    <lang code="raj">Lambani</lang>
    <lang code="raj">Malvi</lang>
    <lang code="raj">Malavi</lang>
    <lang code="raj">Mallow</lang>
    <lang code="raj">Malwi</lang>
    <lang code="raj">Ujjaini (Malvi)</lang>
    <lang code="raj">Nimadi</lang>
    <lang code="raj">Nemadi</lang>
    <lang code="raj">Nimari</lang>
    <lang code="raj">Sondwari</lang>
    <lang code="raj">Sondhavāṛī</lang>
    <lang code="raj">Sondhwadi</lang>
    <lang code="raj">Sondhwari</lang>
    <lang code="raj">Soudhwari</lang>
    <lang code="raj">Wagdi</lang>
    <lang code="raj">Vāgaḍī</lang>
    <lang code="raj">Vāgarī</lang>
    <lang code="raj">Vagdi</lang>
    <lang code="raj">Vaged</lang>
    <lang code="raj">Vageri</lang>
    <lang code="raj">Vagi</lang>
    <lang code="raj">Vagri</lang>
    <lang code="raj">Wagadi</lang>
    <lang code="raj">Waghari</lang>
    <lang code="raj">Wagholi</lang>
    <lang code="rap">Rapanui</lang>
    <lang code="rar">Rarotongan</lang>
    <lang code="rar">Cook Islands Maori</lang>
    <lang code="rar">Maori, Cook Islands</lang>
    <lang code="rar">Manihiki Rarotongan</lang>
    <lang code="rar">Rarotongan, Manihiki</lang>
    <lang code="roa">Romance (Other)</lang>
    <lang code="roa">Anglo-Norman</lang>
    <lang code="roa">Anglo-French</lang>
    <lang code="roa">Norman-French</lang>
    <lang code="roa">Cajun French</lang>
    <lang code="roa">Acadian (Louisiana)</lang>
    <lang code="roa">French, Cajun</lang>
    <lang code="roa">Louisiana Acadian</lang>
    <lang code="roa">Louisiana French</lang>
    <lang code="roa">Franco-Provençal</lang>
    <lang code="roa">Arpitan</lang>
    <lang code="roa">Franco-Venetian</lang>
    <lang code="roa">Franco-Italian</lang>
    <lang code="roa">Italian, Old (to 1300)</lang>
    <lang code="roa">Old Italian</lang>
    <lang code="roa">Ladin</lang>
    <lang code="roa">Portuñol</lang>
    <lang code="roa">Bayano</lang>
    <lang code="roa">Brasilero</lang>
    <lang code="roa">Brazilero</lang>
    <lang code="roa">Fronteiriço</lang>
    <lang code="roa">Fronterizo</lang>
    <lang code="roa">Portanhol</lang>
    <lang code="roa">Portunhol</lang>
    <lang code="roa">Spanish, Old (to 1500)</lang>
    <lang code="roa">Old Spanish</lang>
    <lang code="rom">Romani</lang>
    <lang code="rom">Gipsy</lang>
    <lang code="rom">Gypsy</lang>
    <lang code="rom">Romany</lang>
    <lang code="rom">Rommany</lang>
    <lang code="rom">Caló (Romani)</lang>
    <lang code="rom">Kalderash</lang>
    <lang code="rom">Coppersmith</lang>
    <lang code="rom">Kaldaraš</lang>
    <lang code="rom">Kalderaš</lang>
    <lang code="rom">Kelderaš</lang>
    <lang code="rom">Kelderashícko</lang>
    <lang code="rom">Lovari</lang>
    <lang code="rom">Nuri</lang>
    <lang code="rom">Spoitori</lang>
    <lang code="rom">Spoitari</lang>
    <lang code="rum">Romanian</lang>
    <lang code="rum">Rumanian</lang>
    <lang code="rum">Boyash</lang>
    <lang code="rum">Megleno-Romanian</lang>
    <lang code="rum">Meglinite</lang>
    <lang code="rum">Meglinitic</lang>
    <lang code="rum">Moglenitic</lang>
    <lang code="rum">Viăhește</lang>
    <lang code="rum">Moldovan</lang>
    <lang code="rum">Moldavian</lang>
    <lang code="rum">Moldovean</lang>
    <lang code="rum">Moldovian</lang>
    <lang code="run">Rundi</lang>
    <lang code="run">Kirundi</lang>
    <lang code="rus">Russian</lang>
    <lang code="sal">Salishan languages</lang>
    <lang code="sal">Bella Coola</lang>
    <lang code="sal">Colville</lang>
    <lang code="sal">Comox</lang>
    <lang code="sal">Komuk</lang>
    <lang code="sal">Cowlitz</lang>
    <lang code="sal">Kalispel</lang>
    <lang code="sal">Pend d'Oreille</lang>
    <lang code="sal">Lillooet</lang>
    <lang code="sal">Ntlakyapamuk</lang>
    <lang code="sal">Netlakapamuk</lang>
    <lang code="sal">Thompson</lang>
    <lang code="sal">Okanagan</lang>
    <lang code="sal">Okinagan</lang>
    <lang code="sal">Quinault</lang>
    <lang code="sal">Salish</lang>
    <lang code="sal">Sechelt</lang>
    <lang code="sal">Seshelt</lang>
    <lang code="sal">Shuswap</lang>
    <lang code="sal">Squawmish</lang>
    <lang code="sal">Skwamish</lang>
    <lang code="sal">Stalo</lang>
    <lang code="sal">Halkomelem</lang>
    <lang code="sam">Samaritan Aramaic</lang>
    <lang code="smi">Sami</lang>
    <lang code="smi">Lapp</lang>
    <lang code="lap" status="obsolete">Sami</lang>
    <lang code="smo">Samoan</lang>
    <lang code="sao" status="obsolete">Samoan</lang>
    <lang code="sad">Sandawe</lang>
    <lang code="sad">Kissandaui</lang>
    <lang code="sad">Wassandaui</lang>
    <lang code="sag">Sango (Ubangi Creole)</lang>
    <lang code="san">Sanskrit</lang>
    <lang code="san">Sanscrit</lang>
    <lang code="san">Buddhist Hybrid Sanskrit</lang>
    <lang code="san">Hybrid Sanskrit, Buddhist</lang>
    <lang code="san">Epigraphical Hybrid Sanskrit</lang>
    <lang code="san">Hybrid Sanskrit, Epigraphical</lang>
    <lang code="san">Vedic</lang>
    <lang code="san">Indic, Old</lang>
    <lang code="san">Old Indic</lang>
    <lang code="san">Vedic Sanskrit</lang>
    <lang code="sat">Santali</lang>
    <lang code="sat">Sonthal</lang>
    <lang code="srd">Sardinian</lang>
    <lang code="sas">Sasak</lang>
    <lang code="sco">Scots</lang>
    <lang code="sco">Lallans</lang>
    <lang code="sco">Lowland Scots</lang>
    <lang code="sco">Scots (English)</lang>
    <lang code="sco">Scottish (Germanic)</lang>
    <lang code="gla">Scottish Gaelic</lang>
    <lang code="gla">Erse (Scottish Gaelic)</lang>
    <lang code="gla">Gaelic (Scots)</lang>
    <lang code="gla">Scots Gaelic</lang>
    <lang code="gae" status="obsolete">Scottish Gaelix</lang>
    <lang code="sel">Selkup</lang>
    <lang code="sel">Ostiak Samoyed</lang>
    <lang code="sem">Semitic (Other)</lang>
    <lang code="sem">Ammonite</lang>
    <lang code="sem">Canaanite</lang>
    <lang code="sem">Eblaite</lang>
    <lang code="sem">Paleocanaanite</lang>
    <lang code="sem">Gurage languages</lang>
    <lang code="sem">Harari</lang>
    <lang code="sem">Adari</lang>
    <lang code="sem">Ararge</lang>
    <lang code="sem">Inor</lang>
    <lang code="sem">Ennemor</lang>
    <lang code="sem">Jibbali</lang>
    <lang code="sem">Mahri</lang>
    <lang code="sem">Mehri</lang>
    <lang code="sem">Mandean</lang>
    <lang code="sem">Sabaean</lang>
    <lang code="sem">South Arabic</lang>
    <lang code="sem">Arabic, South</lang>
    <lang code="sem">Wolane</lang>
    <lang code="sem">Olane</lang>
    <lang code="sem">Walane</lang>
    <lang code="sem">Welene</lang>
    <lang code="sem">Weleni</lang>
    <lang code="sem">Zay</lang>
    <lang code="sem">Gelilla</lang>
    <lang code="sem">Lak'i (Ethiopia)</lang>
    <lang code="sem">Laqi</lang>
    <lang code="sem">Zai</lang>
    <lang code="sem">Zway</lang>
    <lang code="srp">Serbian</lang>
    <lang code="scc" status="obsolete">Serbian</lang>
    <lang code="srr">Serer</lang>
    <lang code="shn">Shan</lang>
    <lang code="sna">Shona</lang>
    <lang code="sna">China (Africa)</lang>
    <lang code="sna">Mashona</lang>
    <lang code="sna">Karanga</lang>
    <lang code="sna">Zezuru</lang>
    <lang code="sna">Central Shona</lang>
    <lang code="sho" status="obsolete">Shona</lang>
    <lang code="iii">Sichuan Yi</lang>
    <lang code="iii">Yi, Sichuan</lang>
    <lang code="scn">Sicilian Italian</lang>
    <lang code="scn">Italian, Sicilian</lang>
    <lang code="sid">Sidamo</lang>
    <lang code="sgn">Sign languages</lang>
    <lang code="sgn">American Sign Language</lang>
    <lang code="sgn">Ameslan</lang>
    <lang code="sgn">Australasian Signed English</lang>
    <lang code="sgn">Austrian Sign Language</lang>
    <lang code="sgn">ÖGS (Sign language)</lang>
    <lang code="sgn">Österreichische Gebärdensprache</lang>
    <lang code="sgn">British Sign Language</lang>
    <lang code="sgn">Czech Sign Language</lang>
    <lang code="sgn">Český znakový jazyk</lang>
    <lang code="sgn">Danish Sign Language</lang>
    <lang code="sgn">DSL (Danish Sign Language)</lang>
    <lang code="sgn">Estonian Sign Language</lang>
    <lang code="sgn">ESL (Estonian Sign Language)</lang>
    <lang code="sgn">Flemish Sign Language</lang>
    <lang code="sgn">VGT (Sign language)</lang>
    <lang code="sgn">Vlaamse Gebarentaal</lang>
    <lang code="sgn">French Belgian Sign Language</lang>
    <lang code="sgn">Belgian French Sign Language</lang>
    <lang code="sgn">Langue des signes Belge Francophone</lang>
    <lang code="sgn">Langue des signes française Belgique</lang>
    <lang code="sgn">LSFB (Sign language)</lang>
    <lang code="sgn">Guinea-Bissauan Language</lang>
    <lang code="sgn">Icelandic Sign Language</lang>
    <lang code="sgn">ISL (Icelandic Sign Language)</lang>
    <lang code="sgn">Jordanian Sign Language</lang>
    <lang code="sgn">JSL (Sign Language)</lang>
    <lang code="sgn">Lughat al-Ishāra al-Urdunia</lang>
    <lang code="sgn">Mauritian Sign Language</lang>
    <lang code="sgn">Quebec Sign Language</lang>
    <lang code="sgn">Langue des signes québécoise</lang>
    <lang code="bla">Siksika</lang>
    <lang code="bla">Blackfoot</lang>
    <lang code="snd">Sindhi</lang>
    <lang code="snd">Kachchhi</lang>
    <lang code="snd">Kacchī</lang>
    <lang code="snd">Kutchi</lang>
    <lang code="sin">Sinhalese</lang>
    <lang code="sin">Cingalese</lang>
    <lang code="sin">Singhala</lang>
    <lang code="sin">Singhalese</lang>
    <lang code="sin">Sinhala</lang>
    <lang code="snh" status="obsolete">Sinhalese</lang>
    <lang code="sit">Sino-Tibetan (Other)</lang>
    <lang code="sit">Abor</lang>
    <lang code="sit">Adi</lang>
    <lang code="sit">Miri</lang>
    <lang code="sit">Miśing</lang>
    <lang code="sit">Achang</lang>
    <lang code="sit">A-ch‘ang</lang>
    <lang code="sit">Atsang</lang>
    <lang code="sit">Akha</lang>
    <lang code="sit">Ahka</lang>
    <lang code="sit">Aini (Tibeto-Burman)</lang>
    <lang code="sit">Ak'a</lang>
    <lang code="sit">Ekaw</lang>
    <lang code="sit">Hka Ko</lang>
    <lang code="sit">Ikaw</lang>
    <lang code="sit">Ikor</lang>
    <lang code="sit">Kaw</lang>
    <lang code="sit">Kha Ko</lang>
    <lang code="sit">Khako</lang>
    <lang code="sit">Khao Ikor</lang>
    <lang code="sit">Khao Kha Ko</lang>
    <lang code="sit">Ko (Tibeto-Burman)</lang>
    <lang code="sit">Yani</lang>
    <lang code="sit">Angami</lang>
    <lang code="sit">Ao</lang>
    <lang code="sit">Chungli</lang>
    <lang code="sit">Hatigorria</lang>
    <lang code="sit">Mongsen</lang>
    <lang code="sit">Zungi</lang>
    <lang code="sit">Zwingi</lang>
    <lang code="sit">Apatani</lang>
    <lang code="sit">Aka</lang>
    <lang code="sit">Apa Tanang</lang>
    <lang code="sit">Hruso</lang>
    <lang code="sit">Arakanese</lang>
    <lang code="sit">Maghi</lang>
    <lang code="sit">Rakhaing</lang>
    <lang code="sit">Bai (China)</lang>
    <lang code="sit">Min-chia</lang>
    <lang code="sit">Pai (China)</lang>
    <lang code="sit">Balti</lang>
    <lang code="sit">Baltistani</lang>
    <lang code="sit">Bhotia of Baltistan</lang>
    <lang code="sit">Sbalti</lang>
    <lang code="sit">Bantawa</lang>
    <lang code="sit">Bontawa</lang>
    <lang code="sit">Kirāta Rāī</lang>
    <lang code="sit">Baram</lang>
    <lang code="sit">Belhariya</lang>
    <lang code="sit">Athpagari</lang>
    <lang code="sit">Athpahariya</lang>
    <lang code="sit">Athpare (Belhariya)</lang>
    <lang code="sit">Athpariya (Belhariya)</lang>
    <lang code="sit">Belhare</lang>
    <lang code="sit">Belhāreor</lang>
    <lang code="sit">Bodo</lang>
    <lang code="sit">Bara (India and Nepal)</lang>
    <lang code="sit">Boro (India and Nepal)</lang>
    <lang code="sit">Kachari, Plains</lang>
    <lang code="sit">Mech</lang>
    <lang code="sit">Plains Kachari</lang>
    <lang code="sit">Chamling</lang>
    <lang code="sit">Camling</lang>
    <lang code="sit">Chang</lang>
    <lang code="sit">Mojung</lang>
    <lang code="sit">Chepang</lang>
    <lang code="sit">Chinbon</lang>
    <lang code="sit">Chino</lang>
    <lang code="sit">Jino</lang>
    <lang code="sit">Chothe Naga</lang>
    <lang code="sit">Chawte</lang>
    <lang code="sit">Chothe</lang>
    <lang code="sit">Chowte</lang>
    <lang code="sit">Dafla</lang>
    <lang code="sit">Nisi</lang>
    <lang code="sit">Dänjong-kä</lang>
    <lang code="sit">Bhotic of Sikkim</lang>
    <lang code="sit">Dé-jong ké</lang>
    <lang code="sit">Sikkim Bhotia</lang>
    <lang code="sit">Sikkimese</lang>
    <lang code="sit">Deori</lang>
    <lang code="sit">Chutia</lang>
    <lang code="sit">Chutiya</lang>
    <lang code="sit">Dari (India)</lang>
    <lang code="sit">Deori Chutiya</lang>
    <lang code="sit">Deuri</lang>
    <lang code="sit">Dewri</lang>
    <lang code="sit">Drori</lang>
    <lang code="sit">Dhimal</lang>
    <lang code="sit">Digaro</lang>
    <lang code="sit">Taraon</lang>
    <lang code="sit">Taying</lang>
    <lang code="sit">Dimasa</lang>
    <lang code="sit">Cachari</lang>
    <lang code="sit">Hill Kachari</lang>
    <lang code="sit">Kachari</lang>
    <lang code="sit">Dungan</lang>
    <lang code="sit">Gallong</lang>
    <lang code="sit">Garo</lang>
    <lang code="sit">Gurung</lang>
    <lang code="sit">Haka Chin</lang>
    <lang code="sit">Baungshè</lang>
    <lang code="sit">Chin, Haka</lang>
    <lang code="sit">Lai</lang>
    <lang code="sit">Hamr</lang>
    <lang code="sit">Hamar</lang>
    <lang code="sit">Mhar</lang>
    <lang code="sit">Jero</lang>
    <lang code="sit">Kabui</lang>
    <lang code="sit">Khaling</lang>
    <lang code="sit">Khiamniungan</lang>
    <lang code="sit">Kok Borok</lang>
    <lang code="sit">Mrung</lang>
    <lang code="sit">Tipura</lang>
    <lang code="sit">Tripuri</lang>
    <lang code="sit">Konyak</lang>
    <lang code="sit">Kanyak</lang>
    <lang code="sit">Kuki</lang>
    <lang code="sit">Kusunda</lang>
    <lang code="sit">Ladakhi</lang>
    <lang code="sit">Lahu</lang>
    <lang code="sit">Muhso</lang>
    <lang code="sit">Laizo (Burma)</lang>
    <lang code="sit">Lepcha</lang>
    <lang code="sit">Rong</lang>
    <lang code="sit">Limbu</lang>
    <lang code="sit">Lisu</lang>
    <lang code="sit">Yawyin</lang>
    <lang code="sit">Lopa</lang>
    <lang code="sit">Magar</lang>
    <lang code="sit">Miju</lang>
    <lang code="sit">Mikir</lang>
    <lang code="sit">Karbi</lang>
    <lang code="sit">Mishmi</lang>
    <lang code="sit">Moklum</lang>
    <lang code="sit">Monpa</lang>
    <lang code="sit">Mün Chin</lang>
    <lang code="sit">Chinbok</lang>
    <lang code="sit">Naga languages</lang>
    <lang code="sit">Naxi</lang>
    <lang code="sit">Moso</lang>
    <lang code="sit">Nocte</lang>
    <lang code="sit">Borduaria</lang>
    <lang code="sit">Mohongia</lang>
    <lang code="sit">Paniduaria</lang>
    <lang code="sit">Padam</lang>
    <lang code="sit">Paite</lang>
    <lang code="sit">Pānkhū</lang>
    <lang code="sit">Paang (Pānkhū)</lang>
    <lang code="sit">Pāṃkhoẏā</lang>
    <lang code="sit">Pang Khua</lang>
    <lang code="sit">Pang (Pānkhū)</lang>
    <lang code="sit">Pangkhu</lang>
    <lang code="sit">Pangkhua</lang>
    <lang code="sit">Pankho</lang>
    <lang code="sit">Panko</lang>
    <lang code="sit">Pankua</lang>
    <lang code="sit">Rabha</lang>
    <lang code="sit">Rawang</lang>
    <lang code="sit">Rgyalrong</lang>
    <lang code="sit">Gyalrong</lang>
    <lang code="sit">Rongmei</lang>
    <lang code="sit">Sampang</lang>
    <lang code="sit">Sāmpāṅ Rāī</lang>
    <lang code="sit">Sampang Rai</lang>
    <lang code="sit">Sampange Rai</lang>
    <lang code="sit">Sangpang Gîn</lang>
    <lang code="sit">Sangpang Gun</lang>
    <lang code="sit">Sangpang Kha</lang>
    <lang code="sit">Sangpang</lang>
    <lang code="sit">Singpho</lang>
    <lang code="sit">Sunwar</lang>
    <lang code="sit">Tamang</lang>
    <lang code="sit">Murmi</lang>
    <lang code="sit">Tamu</lang>
    <lang code="sit">Tangkhul</lang>
    <lang code="sit">Thankhul</lang>
    <lang code="sit">Tangsa</lang>
    <lang code="sit">Tengsa</lang>
    <lang code="sit">Tangut</lang>
    <lang code="sit">Hsi-hsia</lang>
    <lang code="sit">Si-hia</lang>
    <lang code="sit">Xixia</lang>
    <lang code="sit">Tenyidie</lang>
    <lang code="sit">Thādo</lang>
    <lang code="sit">Thakali</lang>
    <lang code="sit">Thami</lang>
    <lang code="sit">Thulung</lang>
    <lang code="sit">Tiddim Chin</lang>
    <lang code="sit">Chin, Tiddim</lang>
    <lang code="sit">Kamhau</lang>
    <lang code="sit">Sokte</lang>
    <lang code="sit">Tshangla</lang>
    <lang code="sit">Canglo Monba</lang>
    <lang code="sit">Cangluo Menba</lang>
    <lang code="sit">Cangluo Monba</lang>
    <lang code="sit">Central Monpa</lang>
    <lang code="sit">Dirang</lang>
    <lang code="sit">Dungsam</lang>
    <lang code="sit">Memba</lang>
    <lang code="sit">Menba (Tshangla)</lang>
    <lang code="sit">Monba</lang>
    <lang code="sit">Monpa (Tshangla)</lang>
    <lang code="sit">Motuo</lang>
    <lang code="sit">Motuo Menba</lang>
    <lang code="sit">Sangla</lang>
    <lang code="sit">Sarchapkkha</lang>
    <lang code="sit">Schachop</lang>
    <lang code="sit">Shachobiikha</lang>
    <lang code="sit">Shachopkha</lang>
    <lang code="sit">Sharchagpakha</lang>
    <lang code="sit">Sharchhop-kha</lang>
    <lang code="sit">Sharchopkha</lang>
    <lang code="sit">Tashigang</lang>
    <lang code="sit">Tsangla</lang>
    <lang code="sit">Tsangla Monba</lang>
    <lang code="sit">Tsanglo (Tshangla)</lang>
    <lang code="sit">Tshalingpa (Tshangla)</lang>
    <lang code="sit">Vaiphei</lang>
    <lang code="sit">Bhaipei</lang>
    <lang code="sit">Veiphei</lang>
    <lang code="sit">Wambule</lang>
    <lang code="sit">Wayu</lang>
    <lang code="sit">Hayu</lang>
    <lang code="sit">Vayu</lang>
    <lang code="sit">Wayo</lang>
    <lang code="sit">Yao (Southeast Asia)</lang>
    <lang code="sit">Mien</lang>
    <lang code="sit">Yi</lang>
    <lang code="sit">Lolo (China)</lang>
    <lang code="sit">Nosu</lang>
    <lang code="sit">Zang Zung</lang>
    <lang code="sit">Zhang-Zhung</lang>
    <lang code="sit">Zangskari</lang>
    <lang code="sio">Siouan (Other)</lang>
    <lang code="sio">Biloxi</lang>
    <lang code="sio">Chiwere</lang>
    <lang code="sio">Crow</lang>
    <lang code="sio">Dhegiha</lang>
    <lang code="sio">Cegiha</lang>
    <lang code="sio">Hidatsa</lang>
    <lang code="sio">Grosventres (Hidatsa)</lang>
    <lang code="sio">Mandan</lang>
    <lang code="sio">Ofo</lang>
    <lang code="sio">Ofogoula</lang>
    <lang code="sio">Omaha</lang>
    <lang code="sio">Oto</lang>
    <lang code="sio">Watoto</lang>
    <lang code="sio">Tutelo</lang>
    <lang code="sio">Winnebago</lang>
    <lang code="sio">Hocak</lang>
    <lang code="sio">Woccon</lang>
    <lang code="sms">Skolt Sami</lang>
    <lang code="sms">Lapp, Russian</lang>
    <lang code="sms">Russian Lapp</lang>
    <lang code="sms">Sami, Skolt</lang>
    <lang code="den">Slavey</lang>
    <lang code="den">Dené (Slavey)</lang>
    <lang code="den">Dené Tha</lang>
    <lang code="den">Ethchaottine</lang>
    <lang code="den">Mackenzian</lang>
    <lang code="den">North Slavey</lang>
    <lang code="den">Slave</lang>
    <lang code="den">Slavi</lang>
    <lang code="den">South Slavey</lang>
    <lang code="den">Kawchottine</lang>
    <lang code="den">Hare</lang>
    <lang code="den">Peaux-de-Lièvre</lang>
    <lang code="sla">Slavic (Other)</lang>
    <lang code="sla">Belarusian, Old (to 1700)</lang>
    <lang code="sla">Old Belarusian</lang>
    <lang code="sla">Čakavian</lang>
    <lang code="sla">Carpatho-Rusyn</lang>
    <lang code="sla">Carpathian (Carpatho-Rusyn)</lang>
    <lang code="sla">Carpatho-Russian</lang>
    <lang code="sla">Carpatho-Ruthenian</lang>
    <lang code="sla">Rusyn</lang>
    <lang code="sla">Ruthenian (Carpatho-Rusyn)</lang>
    <lang code="sla">Czech, Old (to 1500)</lang>
    <lang code="sla">Old Czech</lang>
    <lang code="sla">Polabian</lang>
    <lang code="sla">Russian, Old (to 1300)</lang>
    <lang code="sla">East Slavic</lang>
    <lang code="sla">Old East Slavic</lang>
    <lang code="sla">Old Russian</lang>
    <lang code="sla">Surzhyk</lang>
    <lang code="sla">Suržyk</lang>
    <lang code="sla">Ukrainian, Old (ca. 1300-1700)</lang>
    <lang code="sla">Old Ukrainian</lang>
    <lang code="slo">Slovak</lang>
    <lang code="slv">Slovenian</lang>
    <lang code="slv">Windic (Slovenian)</lang>
    <lang code="sog">Sogdian</lang>
    <lang code="som">Somali</lang>
    <lang code="son">Songhai</lang>
    <lang code="son">Dendi</lang>
    <lang code="son">Dandawa</lang>
    <lang code="son">Zarma</lang>
    <lang code="son">Djerma</lang>
    <lang code="son">Dyerma</lang>
    <lang code="son">Zerma</lang>
    <lang code="snk">Soninke</lang>
    <lang code="snk">Sarakole</lang>
    <lang code="wen">Sorbian (Other)</lang>
    <lang code="wen">Wendic (Other)</lang>
    <lang code="sot">Sotho</lang>
    <lang code="sot">Sesuto</lang>
    <lang code="sot">Southern Sotho</lang>
    <lang code="sot">Suto</lang>
    <lang code="sso" status="obsolete">Sotho</lang>
    <lang code="sai">South American Indian (Other)</lang>
    <lang code="sai">Achagua</lang>
    <lang code="sai">Achuar</lang>
    <lang code="sai">Achuale</lang>
    <lang code="sai">Achuara Jivaro</lang>
    <lang code="sai">Jivaro, Achuara</lang>
    <lang code="sai">Aguaruna</lang>
    <lang code="sai">Alacaluf</lang>
    <lang code="sai">Kawesqar</lang>
    <lang code="sai">Amahuaca</lang>
    <lang code="sai">Sayaco</lang>
    <lang code="sai">Amuesha</lang>
    <lang code="sai">Lorenzo</lang>
    <lang code="sai">Andoque</lang>
    <lang code="sai">Apalai</lang>
    <lang code="sai">Apinagé</lang>
    <lang code="sai">Apinajé</lang>
    <lang code="sai">Apinayé</lang>
    <lang code="sai">Arabela</lang>
    <lang code="sai">Chiripuno</lang>
    <lang code="sai">Araona</lang>
    <lang code="sai">Arecuna</lang>
    <lang code="sai">Arekena</lang>
    <lang code="sai">Guarequena</lang>
    <lang code="sai">Uarequena</lang>
    <lang code="sai">Warekena</lang>
    <lang code="sai">Bakairi</lang>
    <lang code="sai">Bacairi</lang>
    <lang code="sai">Baniwa</lang>
    <lang code="sai">Barasana del Norte</lang>
    <lang code="sai">Bara (Colombia)</lang>
    <lang code="sai">Northern Barasano</lang>
    <lang code="sai">Barasana del Sur</lang>
    <lang code="sai">Bara (Colombia)</lang>
    <lang code="sai">Southern Barasano</lang>
    <lang code="sai">Bora</lang>
    <lang code="sai">Boro (South America)</lang>
    <lang code="sai">Bororo (Brazil)</lang>
    <lang code="sai">Cacua</lang>
    <lang code="sai">Macú de cubeo</lang>
    <lang code="sai">Macú de desano</lang>
    <lang code="sai">Macú de guanano</lang>
    <lang code="sai">Caduveo</lang>
    <lang code="sai">Kadiweu</lang>
    <lang code="sai">Caingua</lang>
    <lang code="sai">Cayua</lang>
    <lang code="sai">Kaingua</lang>
    <lang code="sai">Kaiwa (Brazil)</lang>
    <lang code="sai">Callahuaya</lang>
    <lang code="sai">Callawalla</lang>
    <lang code="sai">Callawaya</lang>
    <lang code="sai">Kallawaya</lang>
    <lang code="sai">Qollahuaya</lang>
    <lang code="sai">Campa</lang>
    <lang code="sai">Ande</lang>
    <lang code="sai">Asheninca</lang>
    <lang code="sai">Camsa</lang>
    <lang code="sai">Coche</lang>
    <lang code="sai">Kamentzá</lang>
    <lang code="sai">Kamsa</lang>
    <lang code="sai">Sebondoy</lang>
    <lang code="sai">Sibondoy</lang>
    <lang code="sai">Canamari (Tucanoan)</lang>
    <lang code="sai">Kanamari (Tucanoan)</lang>
    <lang code="sai">Cañari</lang>
    <lang code="sai">Candoshi</lang>
    <lang code="sai">Kandoshi</lang>
    <lang code="sai">Morato</lang>
    <lang code="sai">Murato</lang>
    <lang code="sai">Shapra</lang>
    <lang code="sai">Canella</lang>
    <lang code="sai">Kanela</lang>
    <lang code="sai">Capanahua</lang>
    <lang code="sai">Caquinte</lang>
    <lang code="sai">Caraja</lang>
    <lang code="sai">Karaja</lang>
    <lang code="sai">Carapana (Tucanoan)</lang>
    <lang code="sai">Karapana (Tucanoan)</lang>
    <lang code="sai">Möchda (Tucanoan)</lang>
    <lang code="sai">Cashibo</lang>
    <lang code="sai">Comabo</lang>
    <lang code="sai">Cashinawa</lang>
    <lang code="sai">Kashinawa</lang>
    <lang code="sai">Sheminawa</lang>
    <lang code="sai">Catio</lang>
    <lang code="sai">Embena, Northern</lang>
    <lang code="sai">Epera, Northern</lang>
    <lang code="sai">Katio</lang>
    <lang code="sai">Northern Epera</lang>
    <lang code="sai">Cauqui</lang>
    <lang code="sai">Jacaru</lang>
    <lang code="sai">Jaqaru</lang>
    <lang code="sai">Cavineño</lang>
    <lang code="sai">Cayapa</lang>
    <lang code="sai">Cayapo</lang>
    <lang code="sai">Kayapo</lang>
    <lang code="sai">Chacobo</lang>
    <lang code="sai">Chamacoco</lang>
    <lang code="sai">Chamí</lang>
    <lang code="sai">Embera Chamí</lang>
    <lang code="sai">Chamicuro</lang>
    <lang code="sai">Chana (Uruguay)</lang>
    <lang code="sai">Čaná</lang>
    <lang code="sai">Layuna</lang>
    <lang code="sai">Tšaná</lang>
    <lang code="sai">Tsaná-Bequá</lang>
    <lang code="sai">Tschaná</lang>
    <lang code="sai">Yaro</lang>
    <lang code="sai">Chayahuita</lang>
    <lang code="sai">Chawi</lang>
    <lang code="sai">Chimane</lang>
    <lang code="sai">Nawazi-Moñtji</lang>
    <lang code="sai">Tsimane</lang>
    <lang code="sai">Chipaya</lang>
    <lang code="sai">Puquina (Chipaya)</lang>
    <lang code="sai">Chiquito</lang>
    <lang code="sai">Cholon</lang>
    <lang code="sai">Chontaquiro</lang>
    <lang code="sai">Chuntaquiro</lang>
    <lang code="sai">Piro (Arawakan)</lang>
    <lang code="sai">Simirenchi</lang>
    <lang code="sai">Choroti</lang>
    <lang code="sai">Yofuaha</lang>
    <lang code="sai">Chulupí</lang>
    <lang code="sai">Ashluslay</lang>
    <lang code="sai">Nivacle</lang>
    <lang code="sai">Cocama</lang>
    <lang code="sai">Kokama</lang>
    <lang code="sai">Ucayale</lang>
    <lang code="sai">Cofán</lang>
    <lang code="sai">A'i</lang>
    <lang code="sai">Kofán</lang>
    <lang code="sai">Colorado</lang>
    <lang code="sai">Tsacela</lang>
    <lang code="sai">Yumba</lang>
    <lang code="sai">Coreguaje</lang>
    <lang code="sai">Caqueta</lang>
    <lang code="sai">Cuaiquer</lang>
    <lang code="sai">Coaiker</lang>
    <lang code="sai">Koaiker</lang>
    <lang code="sai">Cubeo</lang>
    <lang code="sai">Cuiba</lang>
    <lang code="sai">Cuiva</lang>
    <lang code="sai">Culina</lang>
    <lang code="sai">Cumana</lang>
    <lang code="sai">Cuna</lang>
    <lang code="sai">Kuna</lang>
    <lang code="sai">Damana</lang>
    <lang code="sai">Arosario</lang>
    <lang code="sai">Guamaca</lang>
    <lang code="sai">Malayo</lang>
    <lang code="sai">Maracasero</lang>
    <lang code="sai">Sanja</lang>
    <lang code="sai">Wiwa</lang>
    <lang code="sai">Desana</lang>
    <lang code="sai">Wira</lang>
    <lang code="sai">Emerillon</lang>
    <lang code="sai">Mereo</lang>
    <lang code="sai">Teco (Tupi)</lang>
    <lang code="sai">Epena Saija</lang>
    <lang code="sai">Saija</lang>
    <lang code="sai">Saixa</lang>
    <lang code="sai">Ese Ejja</lang>
    <lang code="sai">Chama (Tacanan)</lang>
    <lang code="sai">Guacanahua</lang>
    <lang code="sai">Guarayo (Tacanan)</lang>
    <lang code="sai">Huarayo (Tacanan)</lang>
    <lang code="sai">Tiatinagua</lang>
    <lang code="sai">Fulnio</lang>
    <lang code="sai">Carnijo</lang>
    <lang code="sai">Iate</lang>
    <lang code="sai">Yahthe</lang>
    <lang code="sai">Yate (Brazil)</lang>
    <lang code="sai">Gavião (Pará, Brazil)</lang>
    <lang code="sai">Goajiro</lang>
    <lang code="sai">Guajira</lang>
    <lang code="sai">Wayunaiki</lang>
    <lang code="sai">Wayuu</lang>
    <lang code="sai">Guahibo</lang>
    <lang code="sai">Wa-jibi</lang>
    <lang code="sai">Guanano</lang>
    <lang code="sai">Anano</lang>
    <lang code="sai">Kotiria</lang>
    <lang code="sai">Uanana</lang>
    <lang code="sai">Wanana</lang>
    <lang code="sai">Guarayo</lang>
    <lang code="sai">Guayabero</lang>
    <lang code="sai">Jiw</lang>
    <lang code="sai">Guayaki</lang>
    <lang code="sai">Ache</lang>
    <lang code="sai">Guaiaqui</lang>
    <lang code="sai">Guayaki-Ache</lang>
    <lang code="sai">Guoyagui</lang>
    <lang code="sai">Hixkaryana</lang>
    <lang code="sai">Huambisa</lang>
    <lang code="sai">Ssimaku</lang>
    <lang code="sai">Wambisa</lang>
    <lang code="sai">Huao</lang>
    <lang code="sai">Waorani</lang>
    <lang code="sai">Ica</lang>
    <lang code="sai">Arhuaco</lang>
    <lang code="sai">Aruaco</lang>
    <lang code="sai">Bintukua</lang>
    <lang code="sai">Ika (Chibchan)</lang>
    <lang code="sai">Ike</lang>
    <lang code="sai">Ipurina</lang>
    <lang code="sai">Apurina</lang>
    <lang code="sai">Hypurina</lang>
    <lang code="sai">Jupurina</lang>
    <lang code="sai">Kangütü</lang>
    <lang code="sai">Kankiti</lang>
    <lang code="sai">Iquito</lang>
    <lang code="sai">Itonama</lang>
    <lang code="sai">Machoto</lang>
    <lang code="sai">Jaminaua</lang>
    <lang code="sai">Nishinahua</lang>
    <lang code="sai">Yaminahua</lang>
    <lang code="sai">Jaruára</lang>
    <lang code="sai">Jarawara</lang>
    <lang code="sai">Jupda</lang>
    <lang code="sai">Hupde Maku</lang>
    <lang code="sai">Macú de tucano</lang>
    <lang code="sai">Kagaba</lang>
    <lang code="sai">Cagaba</lang>
    <lang code="sai">Kaingang</lang>
    <lang code="sai">Caingang</lang>
    <lang code="sai">Taven</lang>
    <lang code="sai">Kariri</lang>
    <lang code="sai">Cariri</lang>
    <lang code="sai">Kiriri</lang>
    <lang code="sai">Karitiana</lang>
    <lang code="sai">Caritiana</lang>
    <lang code="sai">Lengua</lang>
    <lang code="sai">Lule</lang>
    <lang code="sai">Maca</lang>
    <lang code="sai">Maka (Paraguay)</lang>
    <lang code="sai">Machiguenga</lang>
    <lang code="sai">Macuna</lang>
    <lang code="sai">Buhágana</lang>
    <lang code="sai">Macusi</lang>
    <lang code="sai">Makushi</lang>
    <lang code="sai">Mamaindê</lang>
    <lang code="sai">Tamainde</lang>
    <lang code="sai">Masacali</lang>
    <lang code="sai">Machacali</lang>
    <lang code="sai">Mashakali</lang>
    <lang code="sai">Maxakali</lang>
    <lang code="sai">Mascoi</lang>
    <lang code="sai">Emok</lang>
    <lang code="sai">Machicui</lang>
    <lang code="sai">Toba-Emok</lang>
    <lang code="sai">Mashco</lang>
    <lang code="sai">Amarakaeri</lang>
    <lang code="sai">Harakmbet</lang>
    <lang code="sai">Mataco</lang>
    <lang code="sai">Maue</lang>
    <lang code="sai">Andira</lang>
    <lang code="sai">Arapium</lang>
    <lang code="sai">Maragua</lang>
    <lang code="sai">Satere</lang>
    <lang code="sai">Mayoruna</lang>
    <lang code="sai">Matses</lang>
    <lang code="sai">Moguex</lang>
    <lang code="sai">Cuambia</lang>
    <lang code="sai">Guambiano</lang>
    <lang code="sai">Mojo</lang>
    <lang code="sai">Ignaciano</lang>
    <lang code="sai">Moxo</lang>
    <lang code="sai">Moro (South America)</lang>
    <lang code="sai">Ayoré</lang>
    <lang code="sai">Ayoweo</lang>
    <lang code="sai">Moseten</lang>
    <lang code="sai">Motilon</lang>
    <lang code="sai">Bari (Venezuela)</lang>
    <lang code="sai">Yupe</lang>
    <lang code="sai">Muinane</lang>
    <lang code="sai">Munduruku</lang>
    <lang code="sai">Münkü</lang>
    <lang code="sai">Murui</lang>
    <lang code="sai">Huitoto, Murui</lang>
    <lang code="sai">Nambicuara</lang>
    <lang code="sai">Nhambicuara</lang>
    <lang code="sai">Nomatsiguenga</lang>
    <lang code="sai">Pangoa</lang>
    <lang code="sai">Ocaina</lang>
    <lang code="sai">Orejón</lang>
    <lang code="sai">Coto (Tucanoan)</lang>
    <lang code="sai">Mai Huna</lang>
    <lang code="sai">Payagua</lang>
    <lang code="sai">Paez</lang>
    <lang code="sai">Palicur</lang>
    <lang code="sai">Pamoa</lang>
    <lang code="sai">Juna</lang>
    <lang code="sai">Oa</lang>
    <lang code="sai">Tatutapuyo</lang>
    <lang code="sai">Panare</lang>
    <lang code="sai">Panobo</lang>
    <lang code="sai">Paraujano</lang>
    <lang code="sai">Añún</lang>
    <lang code="sai">Paressi</lang>
    <lang code="sai">Ariti</lang>
    <lang code="sai">Patamona</lang>
    <lang code="sai">Paramuni</lang>
    <lang code="sai">Pemón</lang>
    <lang code="sai">Piapoco</lang>
    <lang code="sai">Piaroa</lang>
    <lang code="sai">Pilaga</lang>
    <lang code="sai">Piratapuyo</lang>
    <lang code="sai">Puinave</lang>
    <lang code="sai">Puquina</lang>
    <lang code="sai">Purupuru</lang>
    <lang code="sai">Paumari</lang>
    <lang code="sai">Resigero</lang>
    <lang code="sai">Rikbaktsa</lang>
    <lang code="sai">Aripaktsa</lang>
    <lang code="sai">Canoeiro</lang>
    <lang code="sai">Saliva</lang>
    <lang code="sai">Saliba (Colombia and Venezuela)</lang>
    <lang code="sai">Sanapaná</lang>
    <lang code="sai">Lanapsua</lang>
    <lang code="sai">Quiativis</lang>
    <lang code="sai">Quilyacmoc</lang>
    <lang code="sai">Saapa</lang>
    <lang code="sai">Sanam</lang>
    <lang code="sai">Secoya</lang>
    <lang code="sai">Sharanahua</lang>
    <lang code="sai">Chandinahua</lang>
    <lang code="sai">Marinahua</lang>
    <lang code="sai">Shipibo-Conibo</lang>
    <lang code="sai">Conibo</lang>
    <lang code="sai">Sipibo</lang>
    <lang code="sai">Shuar</lang>
    <lang code="sai">Jibaro, Shuar</lang>
    <lang code="sai">Jivaro, Shuar</lang>
    <lang code="sai">Xivaro, Shuar</lang>
    <lang code="sai">Sicuane</lang>
    <lang code="sai">Sikuani</lang>
    <lang code="sai">Sioni</lang>
    <lang code="sai">Siona</lang>
    <lang code="sai">Siriano</lang>
    <lang code="sai">Chiranga</lang>
    <lang code="sai">Tacana (Bolivia)</lang>
    <lang code="sai">Tanimuca-Retuama</lang>
    <lang code="sai">Letuana</lang>
    <lang code="sai">Retuara</lang>
    <lang code="sai">Ufaina</lang>
    <lang code="sai">Yahuna</lang>
    <lang code="sai">Tapirapé</lang>
    <lang code="sai">Tariana</lang>
    <lang code="sai">Tenetehara</lang>
    <lang code="sai">Asurini</lang>
    <lang code="sai">Guajajara</lang>
    <lang code="sai">Tembe</lang>
    <lang code="sai">Tenharim</lang>
    <lang code="sai">Toba (Indian)</lang>
    <lang code="sai">Trio</lang>
    <lang code="sai">Tiriyo</lang>
    <lang code="sai">Tucano</lang>
    <lang code="sai">Dagsexe</lang>
    <lang code="sai">Dase</lang>
    <lang code="sai">Tukano</lang>
    <lang code="sai">Tucuna</lang>
    <lang code="sai">Ticuna</lang>
    <lang code="sai">Tunebo</lang>
    <lang code="sai">Pedrazá</lang>
    <lang code="sai">Tame</lang>
    <lang code="sai">Tuyuca</lang>
    <lang code="sai">Dochkafuara</lang>
    <lang code="sai">Tejuka</lang>
    <lang code="sai">Urarina</lang>
    <lang code="sai">Itucale</lang>
    <lang code="sai">Shimacu</lang>
    <lang code="sai">Simacu</lang>
    <lang code="sai">Uru</lang>
    <lang code="sai">Puquina (Uru)</lang>
    <lang code="sai">Urubu</lang>
    <lang code="sai">Vilela</lang>
    <lang code="sai">Waiwai</lang>
    <lang code="sai">Uaiuai</lang>
    <lang code="sai">Warao</lang>
    <lang code="sai">Guarauno</lang>
    <lang code="sai">Warrau</lang>
    <lang code="sai">Waunana</lang>
    <lang code="sai">Chanco</lang>
    <lang code="sai">Chocama</lang>
    <lang code="sai">Noanama</lang>
    <lang code="sai">Wayampi</lang>
    <lang code="sai">Guayapi</lang>
    <lang code="sai">Oiampi</lang>
    <lang code="sai">Waiapi</lang>
    <lang code="sai">Wayapi</lang>
    <lang code="sai">Witoto</lang>
    <lang code="sai">Huitoto</lang>
    <lang code="sai">Xavante</lang>
    <lang code="sai">Acuan-Shavante</lang>
    <lang code="sai">Akwẽ-Shavante</lang>
    <lang code="sai">Chavante Acuan</lang>
    <lang code="sai">Oti</lang>
    <lang code="sai">Shavante Akwe</lang>
    <lang code="sai">Yagua</lang>
    <lang code="sai">Yegua</lang>
    <lang code="sai">Yahgan</lang>
    <lang code="sai">Jagane</lang>
    <lang code="sai">Yanomamo</lang>
    <lang code="sai">Yaruro</lang>
    <lang code="sai">Hapotein</lang>
    <lang code="sai">Llaruro</lang>
    <lang code="sai">Pumé</lang>
    <lang code="sai">Yuapin</lang>
    <lang code="sai">Yecuana</lang>
    <lang code="sai">Maquiritare</lang>
    <lang code="sai">Yucuna</lang>
    <lang code="sai">Matapi</lang>
    <lang code="sai">Yunca</lang>
    <lang code="sai">Chimu</lang>
    <lang code="sai">Mochica</lang>
    <lang code="sai">Yupa</lang>
    <lang code="sai">Yuruti</lang>
    <lang code="sai">Zoró</lang>
    <lang code="sma">Southern Sami</lang>
    <lang code="sma">Sami, Southern</lang>
    <lang code="spa">Spanish</lang>
    <lang code="spa">Castilian</lang>
    <lang code="spa">Chicano</lang>
    <lang code="spa">Cheso</lang>
    <lang code="srn">Sranan</lang>
    <lang code="srn">Taki-Taki</lang>
    <lang code="suk">Sukuma</lang>
    <lang code="suk">Gwe (Tanzania)</lang>
    <lang code="suk">Kesukuma</lang>
    <lang code="suk">Kisukuma</lang>
    <lang code="suk">Suku (Tanzania)</lang>
    <lang code="sux">Sumerian</lang>
    <lang code="sun">Sundanese</lang>
    <lang code="sus">Susu</lang>
    <lang code="sus">Soso</lang>
    <lang code="swa">Swahili</lang>
    <lang code="swa">Kae</lang>
    <lang code="swa">Kingwana</lang>
    <lang code="ssw">Swazi</lang>
    <lang code="ssw">Siswati</lang>
    <lang code="swz" status="obsolete">Swazi</lang>
    <lang code="swe">Swedish</lang>
    <lang code="gsw">Swiss German</lang>
    <lang code="gsw">German, Swiss</lang>
    <lang code="syc">Syriac</lang>
    <lang code="syc">Classifical Syriac</lang>
    <lang code="syr">Syriac, Modern</lang>
    <lang code="syr">Neo-Syriac</lang>
    <lang code="tgl">Tagalog</lang>
    <lang code="tgl">Filipino (Tagalog)</lang>
    <lang code="tgl">Pilipino</lang>
    <lang code="tag" status="obsolete">Tagalog</lang>
    <lang code="tah">Tahitian</lang>
    <lang code="tai">Tai (Other)</lang>
    <lang code="tai">Ahom</lang>
    <lang code="tai">Baha Buyang</lang>
    <lang code="tai">Buyang (Baha Buyang)</lang>
    <lang code="tai">Buyang Zhuang (Baha Buyang)</lang>
    <lang code="tai">Guangnan Buyang</lang>
    <lang code="tai">Paha Buyang</lang>
    <lang code="tai">Western Buyang</lang>
    <lang code="tai">Be</lang>
    <lang code="tai">Ongbe</lang>
    <lang code="tai">Black Tai</lang>
    <lang code="tai">Tai, Black</lang>
    <lang code="tai">Tai Dam</lang>
    <lang code="tai">Tai Noir</lang>
    <lang code="tai">Bouyei</lang>
    <lang code="tai">Buyi (China and Vietnam)</lang>
    <lang code="tai">Dioi (China and Vietnam)</lang>
    <lang code="tai">Giáy</lang>
    <lang code="tai">Nhang</lang>
    <lang code="tai">Puyi</lang>
    <lang code="tai">Yay</lang>
    <lang code="tai">Cao Lan</lang>
    <lang code="tai">Dong (China)</lang>
    <lang code="tai">Gam (China)</lang>
    <lang code="tai">Kam (China)</lang>
    <lang code="tai">Tong (China)</lang>
    <lang code="tai">T‘ung</lang>
    <lang code="tai">Khün</lang>
    <lang code="tai">Hkun</lang>
    <lang code="tai">Tai Khün</lang>
    <lang code="tai">Lü</lang>
    <lang code="tai">Lue</lang>
    <lang code="tai">Pai-i</lang>
    <lang code="tai">Tai Lü</lang>
    <lang code="tai">Lungming</lang>
    <lang code="tai">Northeastern Thai</lang>
    <lang code="tai">Isaan</lang>
    <lang code="tai">Isan</lang>
    <lang code="tai">Issan</lang>
    <lang code="tai">Thai Isaan</lang>
    <lang code="tai">Thai Isan</lang>
    <lang code="tai">Thai, Northeastern</lang>
    <lang code="tai">Northern Thai</lang>
    <lang code="tai">Kam Mū̕ang</lang>
    <lang code="tai">Kammüang</lang>
    <lang code="tai">Kammyang</lang>
    <lang code="tai">Khon</lang>
    <lang code="tai">Khon Meang</lang>
    <lang code="tai">Khon Mung</lang>
    <lang code="tai">Khon Myang</lang>
    <lang code="tai">La Nya</lang>
    <lang code="tai">Lan Na</lang>
    <lang code="tai">Lan Na Thai</lang>
    <lang code="tai">Lanatai</lang>
    <lang code="tai">Lanna (Northern Thai)</lang>
    <lang code="tai">Lanna Thai</lang>
    <lang code="tai">Lannatai</lang>
    <lang code="tai">Lao, Western</lang>
    <lang code="tai">Mū̕ang</lang>
    <lang code="tai">Muang Lanna</lang>
    <lang code="tai">Mung</lang>
    <lang code="tai">Myang</lang>
    <lang code="tai">Payap</lang>
    <lang code="tai">Phayap</lang>
    <lang code="tai">Phuthai</lang>
    <lang code="tai">Phyap</lang>
    <lang code="tai">Tai Nya</lang>
    <lang code="tai">Tai Yon</lang>
    <lang code="tai">Tai Yuan</lang>
    <lang code="tai">Thai Yuan</lang>
    <lang code="tai">Western Lao</lang>
    <lang code="tai">Western Laotian</lang>
    <lang code="tai">Youanne</lang>
    <lang code="tai">Youon</lang>
    <lang code="tai">Yuan</lang>
    <lang code="tai">Southern Thai</lang>
    <lang code="tai">Pak Thai</lang>
    <lang code="tai">Thai, Southern</lang>
    <lang code="tai">Tai Nüa</lang>
    <lang code="tai">Dai Na</lang>
    <lang code="tai">Dehong Dai</lang>
    <lang code="tai">Shan, Yunnanese</lang>
    <lang code="tai">Tay Nüa</lang>
    <lang code="tai">Te-hung Tai</lang>
    <lang code="tai">Yunnanese Shan</lang>
    <lang code="tai">Tay-Nung</lang>
    <lang code="tai">Tho</lang>
    <lang code="tai">White Tai</lang>
    <lang code="tai">Tai, White</lang>
    <lang code="tai">Ya</lang>
    <lang code="tai">Tai Chung</lang>
    <lang code="tai">Tai Ya</lang>
    <lang code="tgk">Tajik</lang>
    <lang code="tgk">Tadjik</lang>
    <lang code="tgk">Tadzhik</lang>
    <lang code="taj" status="obsolete">Tajik</lang>
    <lang code="tmh">Tamashek</lang>
    <lang code="tmh">Amazigh</lang>
    <lang code="tmh">Kidal</lang>
    <lang code="tmh">Kidal Tamasheq</lang>
    <lang code="tmh">Tăhăggart</lang>
    <lang code="tmh">Tahaggart Tamahaq</lang>
    <lang code="tmh">Tahoua</lang>
    <lang code="tmh">Tahoua Tamajeq</lang>
    <lang code="tmh">Tajag</lang>
    <lang code="tmh">Tamachek</lang>
    <lang code="tmh">Tamahaq</lang>
    <lang code="tmh">Tamajaq</lang>
    <lang code="tmh">Tamajeq</lang>
    <lang code="tmh">Tamashekin</lang>
    <lang code="tmh">Tamasheq</lang>
    <lang code="tmh">Tamashiqt</lang>
    <lang code="tmh">Tawallammat Tamajaq</lang>
    <lang code="tmh">Tawarek</lang>
    <lang code="tmh">Tayart Tamajeq</lang>
    <lang code="tmh">Temajaq</lang>
    <lang code="tmh">Tewellemet</lang>
    <lang code="tmh">Timbuktu</lang>
    <lang code="tmh">Tomacheck</lang>
    <lang code="tmh">Tomachek</lang>
    <lang code="tmh">Touareg</lang>
    <lang code="tmh">Touarègue</lang>
    <lang code="tmh">Tourage</lang>
    <lang code="tmh">Toureg</lang>
    <lang code="tmh">Tuareg</lang>
    <lang code="tam">Tamil</lang>
    <lang code="tat">Tatar</lang>
    <lang code="tar" status="obsolete">Tatar</lang>
    <lang code="tel">Telugu</lang>
    <lang code="tel">Andhra</lang>
    <lang code="tel">Gentoo</lang>
    <lang code="tel">Telegu</lang>
    <lang code="tem">Temne</lang>
    <lang code="tem">Timne</lang>
    <lang code="ter">Terena</lang>
    <lang code="tet">Tetum</lang>
    <lang code="tet">Belu</lang>
    <lang code="tha">Thai</lang>
    <lang code="tha">Siamese</lang>
    <lang code="tib">Tibetan</lang>
    <lang code="tib">Bhotanta</lang>
    <lang code="tib">Helambu Sherpa</lang>
    <lang code="tib">Hyolmo</lang>
    <lang code="tib">Yohlmo</lang>
    <lang code="tib">Kagate</lang>
    <lang code="tib">Khams Tibetan</lang>
    <lang code="tib">Kam</lang>
    <lang code="tib">Kang (Tibetan)</lang>
    <lang code="tib">Kham (China)</lang>
    <lang code="tib">Khamba (Tibetan)</lang>
    <lang code="tib">Khampa</lang>
    <lang code="tib">Khams</lang>
    <lang code="tib">Khams Bhotia</lang>
    <lang code="tib">Khams-Yal</lang>
    <lang code="tib">Sherpa</lang>
    <lang code="tib">Sharpa</lang>
    <lang code="tig">Tigré</lang>
    <lang code="tir">Tigrinya</lang>
    <lang code="tir">Tigriña</lang>
    <lang code="tir">Tña</lang>
    <lang code="tiv">Tiv</lang>
    <lang code="tli">Tlingit</lang>
    <lang code="tli">Koluschan</lang>
    <lang code="tli">Tongass</lang>
    <lang code="tpi">Tok Pisin</lang>
    <lang code="tpi">Neo-Melanesian</lang>
    <lang code="tpi">Pisin</lang>
    <lang code="tkl">Tokelauan</lang>
    <lang code="tog">Tonga (Nyasa)</lang>
    <lang code="ton">Tongan</lang>
    <lang code="ton">Tonga (Tonga Islands)</lang>
    <lang code="tru" status="obsolete">Truk</lang>
    <lang code="tsi">Tsimshian</lang>
    <lang code="tsi">Zimshīan</lang>
    <lang code="tso">Tsonga</lang>
    <lang code="tso">Changana</lang>
    <lang code="tso">Gwamba</lang>
    <lang code="tso">Shangaan</lang>
    <lang code="tso">Thonga</lang>
    <lang code="tso">Tonga (Tsonga)</lang>
    <lang code="tso">Xitsonga</lang>
    <lang code="tsn">Tswana</lang>
    <lang code="tsn">Bechuana</lang>
    <lang code="tsn">Chuana</lang>
    <lang code="tsn">Coana</lang>
    <lang code="tsn">Cuana</lang>
    <lang code="tsn">Cwana</lang>
    <lang code="tsn">Sechuana</lang>
    <lang code="tsn">Setswana</lang>
    <lang code="tsw" status="obsolete">Tswana</lang>
    <lang code="tum">Tumbuka</lang>
    <lang code="tum">Tamboka</lang>
    <lang code="tup">Tupi languages</lang>
    <lang code="tup">Parintintin</lang>
    <lang code="tup">Tupi</lang>
    <lang code="tup">Ñeengatú</lang>
    <lang code="tur">Turkish</lang>
    <lang code="ota">Turkish, Ottoman</lang>
    <lang code="ota">Osmanli</lang>
    <lang code="ota">Ottoman Turkish</lang>
    <lang code="ota">Karamanli</lang>
    <lang code="ota">Karamanlı Türkçesi</lang>
    <lang code="ota">Karamanlıca</lang>
    <lang code="ota">Karamanlidic</lang>
    <lang code="ota">Karamanlidika</lang>
    <lang code="tuk">Turkmen</lang>
    <lang code="tuk">Turkoman</lang>
    <lang code="tvl">Tuvaluan</lang>
    <lang code="tvl">Ellicean</lang>
    <lang code="tyv">Tuvinian</lang>
    <lang code="tyv">Soyot</lang>
    <lang code="tyv">Tannu-Tuva</lang>
    <lang code="tyv">Tuba</lang>
    <lang code="tyv">Uriankhai</lang>
    <lang code="twi">Twi</lang>
    <lang code="twi">Akuapem</lang>
    <lang code="twi">Ashanti</lang>
    <lang code="twi">Chwee</lang>
    <lang code="twi">Odschi</lang>
    <lang code="twi">Tshi</lang>
    <lang code="udm">Udmurt</lang>
    <lang code="udm">Votiak</lang>
    <lang code="udm">Votyak</lang>
    <lang code="uga">Ugaritic</lang>
    <lang code="uig">Uighur</lang>
    <lang code="uig">Eastern Turki</lang>
    <lang code="uig">Kashgar-Yarkend</lang>
    <lang code="uig">Turki, Eastern</lang>
    <lang code="uig">Uigur</lang>
    <lang code="uig">Uyghur</lang>
    <lang code="uig">Wighor</lang>
    <lang code="uig">Yarkend</lang>
    <lang code="ukr">Ukrainian</lang>
    <lang code="ukr">Ruthenian (Ukrainian)</lang>
    <lang code="umb">Umbundu</lang>
    <lang code="umb">Benguela</lang>
    <lang code="umb">Mbundu (Benguela Province, Angola)</lang>
    <lang code="umb">Ovimbundu</lang>
    <lang code="umb">Quimbundo (Benguela Province, Angola)</lang>
    <lang code="umb">South Mbundu</lang>
    <lang code="und">Undetermined</lang>
    <lang code="hsb">Upper Sorbian</lang>
    <lang code="hsb">High Sorbian</lang>
    <lang code="hsb">Sorbian, Upper</lang>
    <lang code="urd">Urdu</lang>
    <lang code="urd">Bihari (Urdu)</lang>
    <lang code="urd">Gujri (Urdu)</lang>
    <lang code="urd">Gurjari</lang>
    <lang code="urd">Islami</lang>
    <lang code="urd">Moorish (India)</lang>
    <lang code="urd">Undri</lang>
    <lang code="urd">Urudu</lang>
    <lang code="urd">Dakhini</lang>
    <lang code="urd">Dakani</lang>
    <lang code="urd">Dakhani</lang>
    <lang code="urd">Dakhini Hindi</lang>
    <lang code="urd">Dakhini Hindustani</lang>
    <lang code="urd">Dakhini Urdu</lang>
    <lang code="urd">Dakhni</lang>
    <lang code="urd">Dakini</lang>
    <lang code="urd">Dakkani</lang>
    <lang code="urd">Dakkhani</lang>
    <lang code="urd">Deccan</lang>
    <lang code="urd">Dehlavi</lang>
    <lang code="urd">Gujari (Dakhini)</lang>
    <lang code="urd">Hindavi</lang>
    <lang code="uzb">Uzbek</lang>
    <lang code="vai">Vai</lang>
    <lang code="vai">Vei</lang>
    <lang code="ven">Venda</lang>
    <lang code="ven">Tshivenda</lang>
    <lang code="ven">Wenda</lang>
    <lang code="vie">Vietnamese</lang>
    <lang code="vie">Annamese</lang>
    <lang code="vol">Volapük</lang>
    <lang code="vot">Votic</lang>
    <lang code="vot">Vatjan</lang>
    <lang code="vot">Vote</lang>
    <lang code="vot">Votian</lang>
    <lang code="vot">Votish</lang>
    <lang code="wak">Wakashan languages</lang>
    <lang code="wak">Bella Bella</lang>
    <lang code="wak">Haisla</lang>
    <lang code="wak">Heiltsuk</lang>
    <lang code="wak">Haeltzuk</lang>
    <lang code="wak">Kwakiutl</lang>
    <lang code="wak">Nitinat</lang>
    <lang code="wak">Nootka</lang>
    <lang code="wak">Aht</lang>
    <lang code="wak">Noutka</lang>
    <lang code="wak">Nutka</lang>
    <lang code="wak">Nuuchahnulth</lang>
    <lang code="wln">Walloon</lang>
    <lang code="war">Waray</lang>
    <lang code="war">Leytean</lang>
    <lang code="war">Samar-Leyte</lang>
    <lang code="war">Samaron</lang>
    <lang code="was">Washoe</lang>
    <lang code="was">Washo</lang>
    <lang code="was">Washoan</lang>
    <lang code="wel">Welsh</lang>
    <lang code="wel">Cymric</lang>
    <lang code="him">Western Pahari languages</lang>
    <lang code="him">Himachali</lang>
    <lang code="him">Pahadi</lang>
    <lang code="him">Pahari, Western</lang>
    <lang code="him">Bhadrawahi</lang>
    <lang code="him">Baderwali</lang>
    <lang code="him">Badrohi</lang>
    <lang code="him">Bahi</lang>
    <lang code="him">Bhadarwahi</lang>
    <lang code="him">Bhaderbhai Jamu</lang>
    <lang code="him">Bhaderwali Pahari</lang>
    <lang code="him">Bhadrava</lang>
    <lang code="him">Bhadravāhī</lang>
    <lang code="him">Bhadri</lang>
    <lang code="him">Bhalesi</lang>
    <lang code="him">Bilaspuri</lang>
    <lang code="him">Bilāsapurī</lang>
    <lang code="him">Bilaspuri Pahari</lang>
    <lang code="him">Kahalurī</lang>
    <lang code="him">Khalūrī</lang>
    <lang code="him">Kehloori</lang>
    <lang code="him">Kehloori Pahari</lang>
    <lang code="him">Kehluri</lang>
    <lang code="him">Pacchmi</lang>
    <lang code="him">Chambeali</lang>
    <lang code="him">Cameali</lang>
    <lang code="him">Chamaya</lang>
    <lang code="him">Chambiali</lang>
    <lang code="him">Chambiyali</lang>
    <lang code="him">Chamiyali</lang>
    <lang code="him">Chamiyali Pahari</lang>
    <lang code="him">Chamya</lang>
    <lang code="him">Gaddi</lang>
    <lang code="him">Bharmauri</lang>
    <lang code="him">Bharmauri Bhadi</lang>
    <lang code="him">Bharmouri</lang>
    <lang code="him">Brahmauri</lang>
    <lang code="him">Gaddhi</lang>
    <lang code="him">Gaddyalali</lang>
    <lang code="him">Gaddyali</lang>
    <lang code="him">Gadhi</lang>
    <lang code="him">Gadhiali</lang>
    <lang code="him">Gadi</lang>
    <lang code="him">Gadiali</lang>
    <lang code="him">Gadiyali</lang>
    <lang code="him">Pahari Bharmauri</lang>
    <lang code="him">Panchi</lang>
    <lang code="him">Panchi Brahmauri Rajput</lang>
    <lang code="him">Jaunsari</lang>
    <lang code="him">Gaunsari</lang>
    <lang code="him">Jansauri</lang>
    <lang code="him">Jaunsauri</lang>
    <lang code="him">Pahari (Jaunsari)</lang>
    <lang code="him">Kullu Pahari</lang>
    <lang code="him">Kauli</lang>
    <lang code="him">Kullui</lang>
    <lang code="him">Kulu</lang>
    <lang code="him">Kulu Boli</lang>
    <lang code="him">Kulu Pahari</lang>
    <lang code="him">Kuluhi</lang>
    <lang code="him">Kului</lang>
    <lang code="him">Kulvi</lang>
    <lang code="him">Kulwali</lang>
    <lang code="him">Pahari Kullu</lang>
    <lang code="him">Pahari (Kullu Pahari)</lang>
    <lang code="him">Phari Kulu</lang>
    <lang code="him">Mandeali</lang>
    <lang code="him">Himachali (Mandeali)</lang>
    <lang code="him">Mandi (Mandeali)</lang>
    <lang code="him">Mandiali</lang>
    <lang code="him">Pahari Mandiyali</lang>
    <lang code="him">Sirmauri</lang>
    <lang code="him">Himachali (Sirmauri)</lang>
    <lang code="him">Pahari (Sirmauri)</lang>
    <lang code="him">Sirmouri</lang>
    <lang code="him">Sirmuri</lang>
    <lang code="wal">Wolayta</lang>
    <lang code="wal">Ometo</lang>
    <lang code="wal">Uallamo</lang>
    <lang code="wal">Walamo</lang>
    <lang code="wol">Wolof</lang>
    <lang code="wol">Jaloof</lang>
    <lang code="wol">Jolof</lang>
    <lang code="wol">Ouolof</lang>
    <lang code="wol">Volof</lang>
    <lang code="wol">Yolof</lang>
    <lang code="wol">Lebou</lang>
    <lang code="xho">Xhosa</lang>
    <lang code="xho">isiXhosa</lang>
    <lang code="xho">Kafir</lang>
    <lang code="xho">Xosa</lang>
    <lang code="sah">Yakut</lang>
    <lang code="sah">Jakut</lang>
    <lang code="sah">Sakha</lang>
    <lang code="yao">Yao (Africa)</lang>
    <lang code="yao">Adjaua</lang>
    <lang code="yao">Ajawa</lang>
    <lang code="yao">Ayo</lang>
    <lang code="yao">Chi-yao</lang>
    <lang code="yao">Ciyao</lang>
    <lang code="yao">Djao</lang>
    <lang code="yao">Hiao</lang>
    <lang code="yao">Wayao</lang>
    <lang code="yap">Yapese</lang>
    <lang code="yid">Yiddish</lang>
    <lang code="yid">German Hebrew</lang>
    <lang code="yid">Hebreo-German</lang>
    <lang code="yid">Jewish</lang>
    <lang code="yid">Jiddisch</lang>
    <lang code="yid">Judaeo German (Yiddish)</lang>
    <lang code="yid">Judeo-German (Yiddish)</lang>
    <lang code="yor">Yoruba</lang>
    <lang code="yor">Aku</lang>
    <lang code="yor">Eyo</lang>
    <lang code="yor">Nago</lang>
    <lang code="yor">Yariba</lang>
    <lang code="ypk">Yupik languages</lang>
    <lang code="ypk">Eskimo languages, Western</lang>
    <lang code="ypk">Western Eskimo languages</lang>
    <lang code="ypk">Central Yupik</lang>
    <lang code="ypk">Eskimo, West Alaska</lang>
    <lang code="ypk">West Alaska Eskimo</lang>
    <lang code="ypk">Cup´ig</lang>
    <lang code="ypk">Pacific Gulf Yupik</lang>
    <lang code="ypk">Aleut (Eskimo)</lang>
    <lang code="ypk">Eskimo, South Alaska</lang>
    <lang code="ypk">Sugpiak Eskimo</lang>
    <lang code="ypk">Suk (Eskimo)</lang>
    <lang code="ypk">Sirinek</lang>
    <lang code="ypk">Yuit</lang>
    <lang code="ypk">Asiatic Eskimo</lang>
    <lang code="ypk">Eskimo, Asiatic</lang>
    <lang code="ypk">Saint Lawrence Island Yupik</lang>
    <lang code="ypk">Siberian Yupik</lang>
    <lang code="znd">Zande languages</lang>
    <lang code="znd">Nzakara</lang>
    <lang code="znd">Sakara</lang>
    <lang code="znd">Zande</lang>
    <lang code="znd">Azande</lang>
    <lang code="zap">Zapotec</lang>
    <lang code="zza">Zaza</lang>
    <lang code="zza">Dimili</lang>
    <lang code="zza">Dimli</lang>
    <lang code="zza">Kirdki</lang>
    <lang code="zza">Kirmanjki</lang>
    <lang code="zza">Zazaki</lang>
    <lang code="zen">Zenaga</lang>
    <lang code="zen">Senhadja</lang>
    <lang code="zha">Zhuang</lang>
    <lang code="zha">Chuang</lang>
    <lang code="zul">Zulu</lang>
    <lang code="zun">Zuni</lang>
  </xsl:variable>

  <!--<xsl:import href="marcRelatorCodesTerms.xsl"/>-->
  <!-- MARC relator codes and terms, https://www.loc.gov/standards/sourcelist/relator-role.html, retrieved 2020/09/25 -->
  <xsl:variable name="marcRelators">
    <relator term="abridger" code="abr"/>
    <relator term="actor" code="act"/>
    <relator term="adapter" code="adp"/>
    <relator term="addressee" code="rcp" usefor="recipient;"/>
    <relator term="analyst" code="anl"/>
    <relator term="animator" code="anm"/>
    <relator term="annotator" code="ann"/>
    <relator term="appellant" code="apl"/>
    <relator term="appellee" code="ape"/>
    <relator term="applicant" code="app"/>
    <relator term="architect" code="arc"/>
    <relator term="arranger" code="arr" usefor="arranger of music;"/>
    <relator term="art copyist" code="acp"/>
    <relator term="art director" code="adi"/>
    <relator term="artist" code="art" usefor="graphic technician;"/>
    <relator term="artistic director" code="ard"/>
    <relator term="assignee" code="asg"/>
    <relator term="associated name" code="asn"/>
    <relator term="attributed name" code="att" usefor="supposed name;"/>
    <relator term="auctioneer" code="auc"/>
    <relator term="author" code="aut" usefor="joint author;"/>
    <relator term="author in quotations or text abstracts" code="aqt"/>
    <relator term="author of afterword, colophon, etc." code="aft"/>
    <relator term="author of dialog" code="aud"/>
    <relator term="author of introduction, etc." code="aui"/>
    <relator term="autographer" code="ato"/>
    <relator term="bibliographic antecedent" code="ant"/>
    <relator term="binder" code="bnd"/>
    <relator term="binding designer" code="bdd" usefor="designer of binding;"/>
    <relator term="blurb writer" code="blw"/>
    <relator term="book designer" code="bkd" usefor="designer of book;designer of e-book;"/>
    <relator term="book producer" code="bkp" usefor="producer of book;"/>
    <relator term="bookjacket designer" code="bjd" usefor="designer of bookjacket;"/>
    <relator term="bookplate designer" code="bpd"/>
    <relator term="bookseller" code="bsl"/>
    <relator term="braille embosser" code="brl"/>
    <relator term="broadcaster" code="brd"/>
    <relator term="calligrapher" code="cll"/>
    <relator term="cartographer" code="ctg"/>
    <relator term="caster" code="cas"/>
    <relator term="censor" code="cns" usefor="bowdlerizer;expurgator;"/>
    <relator term="choreographer" code="chr"/>
    <relator term="cinematographer" code="cng" usefor="director of photography;"/>
    <relator term="client" code="cli"/>
    <relator term="collection registrar" code="cor"/>
    <relator term="collector" code="col"/>
    <relator term="collotyper" code="clt"/>
    <relator term="colorist" code="clr"/>
    <relator term="commentator" code="cmm"/>
    <relator term="commentator for written text" code="cwt"/>
    <relator term="compiler" code="com"/>
    <relator term="complainant" code="cpl"/>
    <relator term="complainant-appellant" code="cpt"/>
    <relator term="complainant-appellee" code="cpe"/>
    <relator term="composer" code="cmp"/>
    <relator term="compositor" code="cmt" usefor="typesetter;"/>
    <relator term="conceptor" code="ccp"/>
    <relator term="conductor" code="cnd"/>
    <relator term="conservator" code="con" usefor="preservationist;"/>
    <relator term="consultant" code="csl"/>
    <relator term="consultant to a project" code="csp"/>
    <relator term="contestant" code="cos"/>
    <relator term="contestant-appellant" code="cot"/>
    <relator term="contestant-appellee" code="coe"/>
    <relator term="contestee" code="cts"/>
    <relator term="contestee-appellant" code="ctt"/>
    <relator term="contestee-appellee" code="cte"/>
    <relator term="contractor" code="ctr"/>
    <relator term="contributor" code="ctb" usefor="collaborator;"/>
    <relator term="copyright claimant" code="cpc"/>
    <relator term="copyright holder" code="cph"/>
    <relator term="corrector" code="crr"/>
    <relator term="correspondent" code="crp"/>
    <relator term="costume designer" code="cst"/>
    <relator term="court governed" code="cou"/>
    <relator term="court reporter" code="crt"/>
    <relator term="cover designer" code="cov" usefor="designer of cover;"/>
    <relator term="creator" code="cre"/>
    <relator term="curator" code="cur" usefor="curator of an exhibition;"/>
    <relator term="dancer" code="dnc"/>
    <relator term="data contributor" code="dtc"/>
    <relator term="data manager" code="dtm"/>
    <relator term="dedicatee" code="dte" usefor="dedicatee of item;"/>
    <relator term="dedicator" code="dto"/>
    <relator term="defendant" code="dfd"/>
    <relator term="defendant-appellant" code="dft"/>
    <relator term="defendant-appellee" code="dfe"/>
    <relator term="degree granting institution" code="dgg" usefor="degree grantor;"/>
    <relator term="degree supervisor" code="dgs"/>
    <relator term="delineator" code="dln"/>
    <relator term="depicted" code="dpc"/>
    <relator term="depositor" code="dpt"/>
    <relator term="designer" code="dsr"/>
    <relator term="director" code="drt"/>
    <relator term="dissertant" code="dis"/>
    <relator term="distribution place" code="dbp"/>
    <relator term="distributor" code="dst"/>
    <relator term="donor" code="dnr"/>
    <relator term="draftsman" code="drm" usefor="technical draftsman;"/>
    <relator term="dubious author" code="dub"/>
    <!-- Incorrect code, but common error -->
    <relator term="editor" code="ed"/>
    <relator term="editor" code="edt" usefor="ed;"/>
    <relator term="editor of compilation" code="edc"/>
    <relator term="editor of moving image work" code="edm" usefor="moving image work editor;"/>
    <relator term="electrician" code="elg"
      usefor="chief electrician;house electrician;master electrician;"/>
    <relator term="electrotyper" code="elt"/>
    <relator term="enacting jurisdiction" code="enj"/>
    <relator term="engineer" code="eng"/>
    <relator term="engraver" code="egr"/>
    <relator term="etcher" code="etr"/>
    <relator term="event place" code="evp"/>
    <relator term="expert" code="exp" usefor="appraiser;"/>
    <relator term="facsimilist" code="fac" usefor="copier;"/>
    <relator term="field director" code="fld"/>
    <relator term="film director" code="fmd"/>
    <relator term="film distributor" code="fds"/>
    <relator term="film editor" code="flm" usefor="motion picture editor;"/>
    <relator term="film producer" code="fmp"/>
    <relator term="filmmaker" code="fmk"/>
    <relator term="first party" code="fpy"/>
    <relator term="forger" code="frg" usefor="copier;counterfeiter;"/>
    <relator term="former owner" code="fmo"/>
    <relator term="funder" code="fnd"/>
    <relator term="geographic information specialist" code="gis"
      usefor="geospatial information specialist;"/>
    <relator term="honoree" code="hnr" usefor="honouree;honouree of item;"/>
    <relator term="host" code="hst"/>
    <relator term="host institution" code="his"/>
    <relator term="illuminator" code="ilu"/>
    <relator term="illustrator" code="ill"/>
    <relator term="inscriber" code="ins"/>
    <relator term="instrumentalist" code="itr"/>
    <relator term="interviewee" code="ive"/>
    <relator term="interviewer" code="ivr"/>
    <relator term="inventor" code="inv" usefor="patent inventor;"/>
    <relator term="issuing body" code="isb"/>
    <relator term="judge" code="jud"/>
    <relator term="jurisdiction governed" code="jug"/>
    <relator term="laboratory" code="lbr"/>
    <relator term="laboratory director" code="ldr" usefor="lab director;"/>
    <relator term="landscape architect" code="lsa"/>
    <relator term="lead" code="led"/>
    <relator term="lender" code="len"/>
    <relator term="libelant" code="lil"/>
    <relator term="libelant-appellant" code="lit"/>
    <relator term="libelant-appellee" code="lie"/>
    <relator term="libelee" code="lel"/>
    <relator term="libelee-appellant" code="let"/>
    <relator term="libelee-appellee" code="lee"/>
    <relator term="librettist" code="lbt"/>
    <relator term="licensee" code="lse"/>
    <relator term="licensor" code="lso" usefor="imprimatur;"/>
    <relator term="lighting designer" code="lgd"/>
    <relator term="lithographer" code="ltg"/>
    <relator term="lyricist" code="lyr"/>
    <relator term="manufacture place" code="mfp"/>
    <relator term="manufacturer" code="mfr"/>
    <relator term="marbler" code="mrb"/>
    <relator term="markup editor" code="mrk" usefor="encoder;"/>
    <relator term="medium" code="med"/>
    <relator term="metadata contact" code="mdc"/>
    <relator term="metal-engraver" code="mte"/>
    <relator term="minute taker" code="mtk"/>
    <relator term="moderator" code="mod"/>
    <relator term="monitor" code="mon"/>
    <relator term="music copyist" code="mcp"/>
    <relator term="musical director" code="msd"/>
    <relator term="musician" code="mus"/>
    <relator term="narrator" code="nrt"/>
    <relator term="onscreen presenter" code="osp"/>
    <relator term="opponent" code="opn"/>
    <relator term="organizer" code="orm" usefor="organizer of meeting;"/>
    <relator term="originator" code="org"/>
    <relator term="other" code="oth"/>
    <relator term="owner" code="own" usefor="current owner;"/>
    <relator term="panelist" code="pan"/>
    <relator term="papermaker" code="ppm"/>
    <relator term="patent applicant" code="pta"/>
    <relator term="patent holder" code="pth" usefor="patentee;"/>
    <relator term="patron" code="pat"/>
    <relator term="performer" code="prf"/>
    <relator term="permitting agency" code="pma"/>
    <relator term="photographer" code="pht"/>
    <relator term="plaintiff" code="ptf"/>
    <relator term="plaintiff-appellant" code="ptt"/>
    <relator term="plaintiff-appellee" code="pte"/>
    <relator term="platemaker" code="plt"/>
    <relator term="praeses" code="pra"/>
    <relator term="presenter" code="pre"/>
    <relator term="printer" code="prt"/>
    <relator term="printer of plates" code="pop" usefor="plates, printer of;"/>
    <relator term="printmaker" code="prm"/>
    <relator term="process contact" code="prc"/>
    <relator term="producer" code="pro"/>
    <relator term="production company" code="prn"/>
    <relator term="production designer" code="prs"/>
    <relator term="production manager" code="pmn"/>
    <relator term="production personnel" code="prd"/>
    <relator term="production place" code="prp"/>
    <relator term="programmer" code="prg"/>
    <relator term="project director" code="pdr"/>
    <relator term="proofreader" code="pfr"/>
    <relator term="provider" code="prv"/>
    <relator term="publication place" code="pup"/>
    <relator term="publisher" code="pbl"/>
    <relator term="publishing director" code="pbd"/>
    <relator term="puppeteer" code="ppt"/>
    <relator term="radio director" code="rdd"/>
    <relator term="radio producer" code="rpc"/>
    <relator term="recording engineer" code="rce"/>
    <relator term="recordist" code="rcd"/>
    <relator term="redaktor" code="red"/>
    <relator term="renderer" code="ren"/>
    <relator term="reporter" code="rpt"/>
    <relator term="repository" code="rps"/>
    <relator term="research team head" code="rth"/>
    <relator term="research team member" code="rtm"/>
    <relator term="researcher" code="res" usefor="performer of research;"/>
    <relator term="respondent" code="rsp"/>
    <relator term="respondent-appellant" code="rst"/>
    <relator term="respondent-appellee" code="rse"/>
    <relator term="responsible party" code="rpy"/>
    <relator term="restager" code="rsg"/>
    <relator term="restorationist" code="rsr"/>
    <relator term="reviewer" code="rev"/>
    <relator term="rubricator" code="rbr"/>
    <relator term="scenarist" code="sce"/>
    <relator term="scientific advisor" code="sad"/>
    <relator term="screenwriter" code="aus" usefor="author of screenplay, etc.;"/>
    <relator term="scribe" code="scr"/>
    <relator term="sculptor" code="scl"/>
    <relator term="second party" code="spy"/>
    <relator term="secretary" code="sec"/>
    <relator term="seller" code="sll"/>
    <relator term="set designer" code="std"/>
    <relator term="setting" code="stg"/>
    <relator term="signer" code="sgn"/>
    <relator term="singer" code="sng" usefor="vocalist;"/>
    <relator term="sound designer" code="sds"/>
    <relator term="speaker" code="spk"/>
    <relator term="sponsor" code="spn" usefor="sponsoring body;"/>
    <relator term="stage director" code="sgd"/>
    <relator term="stage manager" code="stm"/>
    <relator term="standards body" code="stn"/>
    <relator term="stereotyper" code="str"/>
    <relator term="storyteller" code="stl"/>
    <relator term="supporting host" code="sht" usefor="host, supporting;"/>
    <relator term="surveyor" code="srv"/>
    <relator term="teacher" code="tch" usefor="instructor;"/>
    <relator term="technical director" code="tcd"/>
    <relator term="television director" code="tld"/>
    <relator term="television producer" code="tlp"/>
    <relator term="thesis advisor" code="ths" usefor="promoter;"/>
    <relator term="transcriber" code="trc"/>
    <!-- Incorrect code, but common error -->
    <relator term="translator" code="tr"/>
    <relator term="translator" code="trl" usefor="tr;"/>
    <relator term="type designer" code="tyd" usefor="designer of type;"/>
    <relator term="typographer" code="tyg"/>
    <relator term="university place" code="uvp"/>
    <relator term="videographer" code="vdg"/>
    <relator term="voice actor" code="vac"/>
    <relator term="witness" code="wit" usefor="deponent;eyewitness;observer;onlooker;testifier;"/>
    <relator term="wood engraver" code="wde"/>
    <relator term="woodcutter" code="wdc"/>
    <relator term="writer of accompanying material" code="wam"/>
    <relator term="writer of added commentary" code="wac"/>
    <relator term="writer of added lyrics" code="wal"/>
    <relator term="writer of added text" code="wat"/>
    <relator term="writer of introduction" code="win"/>
    <relator term="writer of preface" code="wpr"/>
    <relator term="writer of supplementary textual content" code="wst"/>
  </xsl:variable>

  <!--<xsl:import href="marcStandardIdentifierSourceList.xsl"/>-->
  <!-- MARC Code List for Standrd Identifier Source, https://www.loc.gov/standards/sourcelist/standard-identifier.html, retrieved 2020/09/25 -->
  <xsl:variable name="StandardIdentifierSourceCodes">
    <code>agorha</code>
    <code>agrovoc</code>
    <code>allmovie</code>
    <code>allmusic</code>
    <code>allocine</code>
    <code>amnbo</code>
    <code>ansi</code>
    <code>artsy</code>
    <code>artukart</code>
    <code>artukaw</code>
    <code>atg</code>
    <code>balat</code>
    <code>bbcth</code>
    <code>bdusc</code>
    <code>belvku</code>
    <code>belvwrk</code>
    <code>benezit</code>
    <code>bfi</code>
    <code>bibbi</code>
    <code>bigenc</code>
    <code>bnfcg</code>
    <code>bpn</code>
    <code>bsi</code>
    <code>cabt</code>
    <code>cana</code>
    <code>cantic</code>
    <code>cbwpid</code>
    <code>cerl</code>
    <code>cgndb</code>
    <code>clara</code>
    <code>cnbksy</code>
    <code>csfdcz</code>
    <code>danacode</code>
    <code>darome</code>
    <code>datoses</code>
    <code>discogs</code>
    <code>dkfilm</code>
    <code>doi</code>
    <code>dpb</code>
    <code>ean</code>
    <code>eidr</code>
    <code>emlo</code>
    <code>fast</code>
    <code>fidecp</code>
    <code>filmaff</code>
    <code>filmport</code>
    <code>findagr</code>
    <code>fisa</code>
    <code>freebase</code>
    <code>gacsch</code>
    <code>gec</code>
    <code>geogndb</code>
    <code>geonames</code>
    <code>gettyaat</code>
    <code>gettyart</code>
    <code>gettyobj</code>
    <code>gettytgn</code>
    <code>gettyulan</code>
    <code>gnd</code>
    <code>gnis</code>
    <code>goodra</code>
    <code>gtaa</code>
    <code>gtin-14</code>
    <code>hdl</code>
    <code>iaafa</code>
    <code>ibdb</code>
    <code>iconauth</code>
    <code>idref</code>
    <code>imdb</code>
    <code>isan</code>
    <code>isbn-a</code>
    <code>isbnre</code>
    <code>isbnsbn</code>
    <code>isni</code>
    <code>iso</code>
    <code>isfdbau</code>
    <code>isfdbaw</code>
    <code>isfdbma</code>
    <code>isfdbpu</code>
    <code>isil</code>
    <code>issn-l</code>
    <code>issue-number</code>
    <code>istc</code>
    <code>iswc</code>
    <code>itar</code>
    <code>kda</code>
    <code>kdw</code>
    <code>kinopo</code>
    <code>lattes</code>
    <code>lcmd</code>
    <code>lei</code>
    <code>libaus</code>
    <code>margaz</code>
    <code>matrix-number</code>
    <code>mesh</code>
    <code>mocofo</code>
    <code>moma</code>
    <code>morana</code>
    <code>moviemetf</code>
    <code>moviemetr</code>
    <code>munzing</code>
    <code>muscl</code>
    <code>musicb</code>
    <code>nacat</code>
    <code>natgazfid</code>
    <code>nga</code>
    <code>ngva</code>
    <code>ngvw</code>
    <code>nipo</code>
    <code>nndb</code>
    <code>npg</code>
    <code>odnb</code>
    <code>ofdb</code>
    <code>onix</code>
    <code>opensm</code>
    <code>orcid</code>
    <code>oxforddnb</code>
    <code>permid</code>
    <code>picnypl</code>
    <code>pleiades</code>
    <code>pnta</code>
    <code>porthu</code>
    <code>prabook</code>
    <code>rbmsbt</code>
    <code>rbmsgt</code>
    <code>rbmspe</code>
    <code>rbmsppe</code>
    <code>rbmspt</code>
    <code>rbmsrd</code>
    <code>rbmste</code>
    <code>rid</code>
    <code>rkda</code>
    <code>saam</code>
    <code>scholaru</code>
    <code>scope</code>
    <code>scopus</code>
    <code>snac</code>
    <code>spotify</code>
    <code>sprfbsb</code>
    <code>sprfbsk</code>
    <code>sprfcbb</code>
    <code>sprfcfb</code>
    <code>sprfhoc</code>
    <code>sprfoly</code>
    <code>sprfpfb</code>
    <code>stw</code>
    <code>svfilm</code>
    <code>tatearid</code>
    <code>theatr</code>
    <code>trove</code>
    <code>unescot</code>
    <code>uri</code>
    <code>urn</code>
    <code>vd16</code>
    <code>vd17</code>
    <code>vd18</code>
    <code>vgmdb</code>
    <code>viaf</code>
    <code>videorecording-identifier</code>
    <code>wikidata</code>
    <code>wndla</code>
    <code>ysopai</code>
    <code>xgamea</code>
  </xsl:variable>

  <!--<xsl:import href="marcCompFormMap.xsl"/>-->
  <!-- MARC Form of Composition Code List, November 2016 -->
  <xsl:variable name="compFormMap">
    <compForm term="Anthems">an</compForm>
    <compForm term="Ballads">bd</compForm>
    <compForm term="Bluegrass music">bg</compForm>
    <compForm term="Blues">bl</compForm>
    <compForm term="Ballets">bt</compForm>
    <compForm term="Chaconnes">ca</compForm>
    <compForm term="Chants, Other religions">cb</compForm>
    <compForm term="Chant, Christian">cc</compForm>
    <compForm term="Concerti grossi">cg</compForm>
    <compForm term="Chorales">ch</compForm>
    <compForm term="Chorale preludes">cl</compForm>
    <compForm term="Canons and rounds">cn</compForm>
    <compForm term="Concertos">co</compForm>
    <compForm term="Chansons, polyphonic">cp</compForm>
    <compForm term="Carols">cr</compForm>
    <compForm term="Chance compositions">cs</compForm>
    <compForm term="Cantatas">ct</compForm>
    <compForm term="Country music">cy</compForm>
    <compForm term="Canzonas">cz</compForm>
    <compForm term="Dance forms">df</compForm>
    <compForm term="Divertimentos, serenades, cassations, divertissements, and notturni"
      >dv</compForm>
    <compForm term="Fugues">fg</compForm>
    <compForm term="Flamenco">fl</compForm>
    <compForm term="Folk music">fm</compForm>
    <compForm term="Fantasias">ft</compForm>
    <compForm term="Gospel music">gm</compForm>
    <compForm term="Hymns">hy</compForm>
    <compForm term="Jazz">jz</compForm>
    <compForm term="Musical revues and comedies">mc</compForm>
    <compForm term="Madrigals">md</compForm>
    <compForm term="Minuets">mi</compForm>
    <compForm term="Motets">mo</compForm>
    <compForm term="Motion picture music">mp</compForm>
    <compForm term="Marches">mr</compForm>
    <compForm term="Masses">ms</compForm>
    <compForm term="Multiple forms">mu</compForm>
    <compForm term="Mazurkas">mz</compForm>
    <compForm term="Nocturnes">nc</compForm>
    <compForm term="Not applicable">nn</compForm>
    <compForm term="Operas">op</compForm>
    <compForm term="Oratorios">or</compForm>
    <compForm term="Overtures">ov</compForm>
    <compForm term="Program music">pg</compForm>
    <compForm term="Passion music">pm</compForm>
    <compForm term="Polonaises">po</compForm>
    <compForm term="Popular music">pp</compForm>
    <compForm term="Preludes">pr</compForm>
    <compForm term="Passacaglias">ps</compForm>
    <compForm term="Part-songs">pt</compForm>
    <compForm term="Pavans">pv</compForm>
    <compForm term="Rock music">rc</compForm>
    <compForm term="Rondos">rd</compForm>
    <compForm term="Ragtime music">rg</compForm>
    <compForm term="Ricercars">ri</compForm>
    <compForm term="Rhapsodies">rp</compForm>
    <compForm term="Requiems">rq</compForm>
    <compForm term="Square dance music">sd</compForm>
    <compForm term="Songs">sg</compForm>
    <compForm term="Sonatas">sn</compForm>
    <compForm term="Symphonic poems">sp</compForm>
    <compForm term="Studies and exercises">st</compForm>
    <compForm term="Suites">su</compForm>
    <compForm term="Symphonies">sy</compForm>
    <compForm term="Toccatas">tc</compForm>
    <compForm term="Teatro lirico">tl</compForm>
    <compForm term="Trio-sonatas">ts</compForm>
    <compForm term="Unknown">uu</compForm>
    <compForm term="Villancicos">vi</compForm>
    <compForm term="Variations">vr</compForm>
    <compForm term="Waltzes">wz</compForm>
    <compForm term="Zarzuelas">za</compForm>
    <compForm term="Other">zz</compForm>
  </xsl:variable>

  <!-- ======================================================================= -->
  <!-- PARAMETERS                                                              -->
  <!-- ======================================================================= -->

  <!-- Set to 'true' for items that have been locally digitized  -->
  <xsl:param name="DL_digitized" select="'false'"/>

  <!-- ======================================================================= -->
  <!-- GLOBAL VARIABLES                                                        -->
  <!-- ======================================================================= -->

  <!-- program name -->
  <xsl:variable name="progName">
    <xsl:text>mods2uvaMAP_no_include.xsl</xsl:text>
  </xsl:variable>

  <!-- program version -->
  <xsl:variable name="progVersion">
    <xsl:text>2.04</xsl:text>
  </xsl:variable>

  <!-- new line -->
  <xsl:variable name="nl">
    <xsl:text>&#xa;</xsl:text>
  </xsl:variable>

  <xsl:variable name="PID2">
    <xsl:choose>
      <!-- PID provided in parameter -->
      <xsl:when test="normalize-space($PID) ne ''">
        <xsl:value-of select="$PID"/>
      </xsl:when>
      <!-- PID in identifier/@type or @displayLabel-->
      <!-- Privilege 'metadata pid' over just 'pid' -->
      <xsl:when test="*:mods/*:identifier[matches(@type, 'metadata pid', 'i')]">
        <xsl:value-of select="*:mods/*:identifier[matches(@type, 'metadata pid', 'i')][1]"/>
      </xsl:when>
      <xsl:when test="*:mods/*:identifier[matches(@displayLabel, 'metadata pid', 'i')]">
        <xsl:value-of select="*:mods/*:identifier[matches(@displayLabel, 'metadata pid', 'i')][1]"/>
      </xsl:when>
      <xsl:when test="*:mods/*:identifier[matches(@type, 'pid', 'i')]">
        <xsl:value-of select="*:mods/*:identifier[matches(@type, 'pid', 'i')][1]"/>
      </xsl:when>
      <xsl:when test="*:mods/*:identifier[matches(@displayLabel, 'pid', 'i')]">
        <xsl:value-of select="*:mods/*:identifier[matches(@displayLabel, 'pid', 'i')][1]"/>
      </xsl:when>
      <!-- PID in input file name -->
      <!-- <xsl:otherwise>
        <xsl:variable name="fileName">
          <xsl:value-of select="tokenize(document-uri(.), '/')[last()]"/>
        </xsl:variable>
        <xsl:value-of select="replace(replace($fileName, '-mods.xml$', ''), '_', ':')"/>
      </xsl:otherwise> -->
    </xsl:choose>
  </xsl:variable>

  <!-- ======================================================================= -->
  <!-- UTILITIES / NAMED TEMPLATES                                             -->
  <!-- ======================================================================= -->

  <!-- Account for @qualifier -->
  <xsl:template name="processQualifier">
    <xsl:choose>
      <xsl:when test="@qualifier eq 'inferred'">
        <xsl:text>?</xsl:text>
      </xsl:when>
      <xsl:when test="@qualifier eq 'approximate'">
        <xsl:text>~</xsl:text>
      </xsl:when>
      <xsl:when test="@qualifier eq 'questionable'">
        <xsl:text>%</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Determine current place in hierarchy: surrogate, orig, host -->
  <xsl:template name="whereAmI">
    <xsl:choose>
      <!-- Locally digitized -->
      <xsl:when
        test="$DL_digitized = 'true' and not(ancestor-or-self::*/*:physicalDescription/*:form[matches(., 'electronic|online|remote')])">
        <xsl:if test="not(ancestor::*:relatedItem)">
          <xsl:text>orig_</xsl:text>
        </xsl:if>
      </xsl:when>
      <!--  NOT Digitized -->
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="ancestor::*:relatedItem[matches(@type, 'host')]">
            <xsl:text>host_</xsl:text>
          </xsl:when>
          <xsl:when test="ancestor::*:relatedItem[matches(@type, 'original')]">
            <xsl:text>orig_</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Copy @authority and @displayLabel of top-level elements -->
  <xsl:template name="copyAuthDisplayAttr">
    <xsl:if test="@authority ne ''">
      <xsl:attribute name="authority">
        <xsl:value-of select="normalize-space(@authority)"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@authorityURI ne ''">
      <xsl:attribute name="authorityURI">
        <xsl:value-of select="normalize-space(@authorityURI)"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valueURI ne ''">
      <xsl:attribute name="valueURI">
        <xsl:value-of select="normalize-space(@valueURI)"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@displayLabel ne ''">
      <xsl:attribute name="displayLabel">
        <xsl:value-of select="@displayLabel"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!-- Copy @authority and @displayLabel of non-top-level elements -->
  <!-- Use ./@authority or ./@authorityURI or ./@valueURI or ./@displayLabel if available; otherwise,
    use ../@authority or ../@authorityURI or ../@valueURI or ../@displayLabel -->
  <xsl:template name="copyAuthDisplayAttr2">
    <xsl:choose>
      <xsl:when test="@authority ne ''">
        <xsl:attribute name="authority">
          <xsl:value-of select="normalize-space(@authority)"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="../@authority ne ''">
        <xsl:attribute name="authority">
          <xsl:value-of select="normalize-space(../@authority)"/>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="@authorityURI ne ''">
        <xsl:attribute name="authorityURI">
          <xsl:value-of select="normalize-space(@authorityURI)"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="../@authorityURI ne ''">
        <xsl:attribute name="authorityURI">
          <xsl:value-of select="normalize-space(../@authorityURI)"/>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="@valueURI ne ''">
        <xsl:attribute name="valueURI">
          <xsl:value-of select="normalize-space(@valueURI)"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="../@valueURI ne ''">
        <xsl:attribute name="valueURI">
          <xsl:value-of select="normalize-space(../@valueURI)"/>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="@displayLabel">
        <xsl:attribute name="displayLabel">
          <xsl:value-of select="@displayLabel"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="../@displayLabel">
        <xsl:attribute name="displayLabel">
          <xsl:value-of select="../@displayLabel"/>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Copy an element to output only if it doesn't have a preceding sibling with the same value -->
  <xsl:template name="dedupeFields">
    <xsl:variable name="thisValue">
      <xsl:value-of select="replace(lower-case(normalize-space(.)), '\p{P}+$', '')"/>
    </xsl:variable>
    <xsl:if
      test="not(preceding::*[replace(lower-case(normalize-space(.)), '\p{P}+$', '') eq $thisValue])">
      <xsl:copy-of select="."/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="makeDisplayTitle">
    <xsl:for-each select="*:nonSort">
      <xsl:value-of select="concat(normalize-space(.), ' ')"/>
    </xsl:for-each>
    <xsl:for-each select="*:title">
      <xsl:value-of
        select="replace(replace(normalize-space(.), '[.:,;/]+$', ''), '(\.\w)+$', '$1.')"/>
    </xsl:for-each>
    <xsl:for-each
      select="*:subTitle | *:partName | *:partNumber | ../*:note[@type = 'statement of responsibility']">
      <xsl:choose>
        <xsl:when test="matches(local-name(), 'subTitle')">
          <xsl:choose>
            <xsl:when test="not(matches(../*:title, '=$'))">
              <xsl:text>: </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="matches(local-name(), 'partName|partNumber')">
          <xsl:text>, </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> / </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of
        select="replace(replace(normalize-space(.), '[.:,;/]+$', ''), '(\.\w)+$', '$1.')"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="makeSortTitle">
    <xsl:for-each select="*:title">
      <xsl:value-of select="replace(normalize-space(.), '[.:,;/]+$', '')"/>
    </xsl:for-each>
    <xsl:for-each select="*:subTitle | *:partName | *:partNumber">
      <xsl:choose>
        <xsl:when test="matches(local-name(), 'subTitle')">
          <xsl:choose>
            <xsl:when test="not(matches(../*:title, '=$'))">
              <xsl:text>: </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> </xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>, </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="replace(normalize-space(.), '[.:,;/]+$', '')"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="getSubfield">
    <xsl:param name="stringValue" required="yes"/>
    <xsl:param name="subfield" required="yes"/>
    <xsl:choose>
      <!-- extent has a, b, c subfields -->
      <xsl:when test="matches($stringValue, ':.*;')">
        <xsl:choose>
          <xsl:when test="$subfield eq 'a'">
            <xsl:value-of select="normalize-space(substring-before($stringValue, ':'))"/>
          </xsl:when>
          <xsl:when test="$subfield eq 'b'">
            <xsl:value-of
              select="normalize-space(substring-before(substring-after($stringValue, ':'), ';'))"/>
          </xsl:when>
          <xsl:when test="$subfield eq 'c'">
            <xsl:value-of select="normalize-space(substring-after($stringValue, ';'))"/>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <!-- extent has a and b subfields -->
      <xsl:when test="matches($stringValue, ':')">
        <xsl:choose>
          <xsl:when test="$subfield eq 'a'">
            <xsl:value-of select="normalize-space(substring-before($stringValue, ':'))"/>
          </xsl:when>
          <xsl:when test="$subfield eq 'b'">
            <xsl:value-of select="normalize-space(substring-after($stringValue, ':'))"/>
          </xsl:when>
          <xsl:when test="$subfield eq 'c'"/>
        </xsl:choose>
      </xsl:when>
      <!-- extent has a and c subfields -->
      <xsl:when test="matches($stringValue, ';')">
        <xsl:choose>
          <xsl:when test="$subfield eq 'a'">
            <xsl:value-of select="normalize-space(substring-before($stringValue, ';'))"/>
          </xsl:when>
          <xsl:when test="$subfield eq 'b'"/>
          <xsl:when test="$subfield eq 'c'">
            <xsl:value-of select="normalize-space(substring-after($stringValue, ';'))"/>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <!-- extent has no delimiters -->
      <xsl:otherwise>
        <xsl:if test="$subfield eq 'a'">
          <xsl:value-of select="normalize-space($stringValue)"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ======================================================================= -->
  <!-- MAIN OUTPUT TEMPLATE                                                    -->
  <!-- ======================================================================= -->

  <xsl:template match="/">
    <!-- @schemaLocation is removed, dates within originInfo, recordCreationDate,
      and recordOrigin are reformatted as EDTF, and accessCondition is normalized. -->
    <xsl:variable name="prepMODS">
      <xsl:apply-templates mode="prepMODS"/>
    </xsl:variable>
    <!--<xsl:copy-of select="$prepMODS"/>-->

    <!-- The actual transformation of MODS to uvaMAP takes place in uvaMAP mode. -->
    <xsl:comment>&#32;Generated by <xsl:value-of select="concat($progName, ', v. ', $progVersion, ' ', format-dateTime(current-dateTime(), '[Y]-[M01]-[D01]T[H01]:[m01]'), ' ')"/></xsl:comment>
    <uvaMAP>
      <xsl:apply-templates select="$prepMODS" mode="uvaMAP"/>
    </uvaMAP>

  </xsl:template>

  <!-- ======================================================================= -->
  <!-- MATCH TEMPLATES FOR ELEMENTS (prepMODS mode)                            -->
  <!-- ======================================================================= -->

  <!-- Remove @xsi:schemaLocation on modsCollection element -->
  <xsl:template match="*:modsCollection" mode="prepMODS">
    <xsl:copy>
      <xsl:apply-templates select="@*[not(matches(local-name(), 'schemaLocation'))]" mode="prepMODS"/>
      <xsl:apply-templates mode="prepMODS"/>
    </xsl:copy>
  </xsl:template>

  <!-- Remove @xsi:schemaLocation on MODS element -->
  <xsl:template match="*:mods" mode="prepMODS">
    <!--<xsl:message>PID2='<xsl:value-of select="$PID2"/>'</xsl:message>-->
    <xsl:copy>
      <xsl:apply-templates select="@*[not(matches(local-name(), 'schemaLocation'))]" mode="prepMODS"/>
      <xsl:apply-templates mode="prepMODS"/>
    </xsl:copy>
  </xsl:template>

  <!-- Remove empty elements and attributes that don't have content -->
  <xsl:template match="@*[normalize-space(.) eq ''] | node()[normalize-space(.) eq '']"
    mode="prepMODS"/>

  <!-- Remove redundant attributes -->
  <xsl:template match="@*[matches(name(), 'xmlns:date|xmlns:fn')]" mode="prepMODS"/>

  <!-- Combine start/end dates in a single date element -->
  <xsl:template match="*:originInfo" mode="prepMODS">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="prepMODS"/>
      <!-- Process non-date elements -->
      <xsl:apply-templates
        select="*[not(matches(local-name(), '(copyrightDate|dateCaptured|dateCreated|dateIssued|dateModified|dateOther|dateValid)'))]"
        mode="prepMODS"/>
      <!-- Process date elements without @point -->
      <xsl:for-each
        select="*[matches(local-name(), 'copyrightDate|dateCaptured|dateCreated|dateIssued|dateModified|dateOther|dateValid')][not(@point)]">
        <xsl:variable name="elementName" select="local-name()"/>
        <xsl:element name="{$elementName}" xmlns="http://www.loc.gov/mods/v3">
          <xsl:apply-templates select="@*[not(matches(local-name(), '(keyDate|qualifier)'))]"
            mode="prepMODS"/>
          <xsl:choose>
            <!-- Check to make sure there's at least one digit before adding back @keyDate -->
            <xsl:when test="matches(., '\d') and @keyDate">
              <xsl:attribute name="keyDate">yes</xsl:attribute>
            </xsl:when>
          </xsl:choose>
          <!-- Output this element's value -->
          <xsl:value-of select="replace(normalize-space(.), 'u[^(ndated)]', 'X')"/>
          <!-- Account for @qualifier -->
          <xsl:call-template name="processQualifier"/>
        </xsl:element>
      </xsl:for-each>
      <!-- Process date elements with @point -->
      <xsl:choose>
        <!-- Same number of start & end dates -->
        <xsl:when
          test="count(*[matches(@point, 'start')]) &gt; 0 and count(*[matches(@point, 'end')]) &gt; 0 and count(*[matches(@point, 'start')]) = count(*[matches(@point, 'end')])">
          <xsl:variable name="pointDates">
            <xsl:copy-of select="*[@point]"/>
          </xsl:variable>
          <xsl:for-each select="$pointDates/*[matches(@point, 'start')]">
            <xsl:variable name="elementName" select="local-name()"/>
            <xsl:element name="{$elementName}" xmlns="http://www.loc.gov/mods/v3">
              <xsl:apply-templates
                select="@*[not(matches(local-name(), 'keyDate|point|qualifier'))]"/>
              <!--<xsl:apply-templates select="@encoding"/>-->
              <xsl:choose>
                <!-- Already has @keyDate -->
                <xsl:when test="matches(., '\d') and @keyDate">
                  <xsl:attribute name="keyDate">yes</xsl:attribute>
                </xsl:when>
                <!-- Following sibling with same element name has @keyDate -->
                <xsl:when
                  test="matches(., '\d') and following-sibling::*[matches(local-name(), $elementName) and matches(@point, 'end')][1]/@keyDate">
                  <xsl:attribute name="keyDate">yes</xsl:attribute>
                </xsl:when>
              </xsl:choose>
              <xsl:value-of select="replace(normalize-space(.), 'u[^(ndated)]', 'X')"/>
              <!-- Account for @qualifier on start date -->
              <xsl:call-template name="processQualifier"/>
              <!-- Separate the start and end points with a slash -->
              <xsl:text>/</xsl:text>
              <xsl:for-each
                select="following-sibling::*[matches(local-name(), $elementName) and matches(@point, 'end')][1]">
                <xsl:value-of select="replace(normalize-space(.), 'u[^(ndated)]', 'X')"/>
                <xsl:call-template name="processQualifier"/>
              </xsl:for-each>
            </xsl:element>
          </xsl:for-each>
        </xsl:when>
        <!-- When different numbers of start & end dates, insert a comment and issue a warning message, but leave the dates alone -->
        <xsl:when
          test="count(*[matches(@point, 'start')]) &gt; 0 and count(*[matches(@point, 'end')]) &gt; 0 and count(*[matches(@point, 'start')]) != count(*[matches(@point, 'end')])">
          <xsl:comment>&#32;Unbalanced start/end dates!&#32;</xsl:comment>
          <xsl:apply-templates
            select="*[matches(local-name(), 'copyrightDate|dateCaptured|dateCreated|dateIssued|dateModified|dateOther|dateValid')][@point]"
            mode="prepMODS"/>
        </xsl:when>
        <!-- Single dates with @point -->
        <xsl:otherwise>
          <xsl:for-each
            select="*[matches(local-name(), 'copyrightDate|dateCaptured|dateCreated|dateIssued|dateModified|dateOther|dateValid')][@point]">
            <xsl:variable name="elementName" select="local-name()"/>
            <xsl:element name="{$elementName}" xmlns="http://www.loc.gov/mods/v3">
              <xsl:apply-templates select="@point" mode="prepMODS"/>
              <xsl:apply-templates
                select="@*[not(matches(local-name(), '(keyDate|point|qualifier)'))]" mode="prepMODS"/>
              <xsl:choose>
                <!-- Check to make sure there's at least one digit before adding back @keyDate -->
                <xsl:when test="matches(., '\d') and @keyDate">
                  <xsl:attribute name="keyDate">yes</xsl:attribute>
                </xsl:when>
              </xsl:choose>
              <!-- If this element is an end point, precede it with a slash. -->
              <xsl:if test="matches(@point, 'end')">
                <xsl:text>/</xsl:text>
              </xsl:if>
              <!-- Output this element's value -->
              <xsl:value-of select="replace(normalize-space(.), 'u[^(ndated)]', 'X')"/>
              <!-- Account for @qualifier -->
              <xsl:call-template name="processQualifier"/>
              <!-- If this element is a start point, follow it with a slash. -->
              <xsl:if test="matches(@point, 'start')">
                <xsl:text>/</xsl:text>
              </xsl:if>
            </xsl:element>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- Attempt to correctly set @encoding on recordCreationDate -->
  <xsl:template match="*:recordCreationDate" mode="prepMODS">
    <xsl:copy>
      <xsl:apply-templates select="@*[not(matches(local-name(), 'encoding'))]" mode="prepMODS"/>
      <xsl:variable name="thisContent">
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:variable>
      <xsl:choose>
        <!-- W3C format requires separators -->
        <xsl:when test="
            matches($thisContent, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+(-\d{2}:00|Z)$') or
            matches($thisContent, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+$') or
            matches($thisContent, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$') or
            matches($thisContent, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$') or
            matches($thisContent, '^\d{4}-\d{2}-\d{2}T\d{2}$') or
            matches($thisContent, '^\d{4}-\d{2}-\d{2}$') or
            matches($thisContent, '^\d{4}-\d{2}$') or
            matches($thisContent, '^\d{4}$')">
          <xsl:attribute name="encoding">w3cdtf</xsl:attribute>
        </xsl:when>
        <!-- ISO format does not require separators -->
        <xsl:when test="
            matches($thisContent, '^\d+\.\d+$') or
            matches($thisContent, '^\d{4}-?\d{2}-?\d{2}T\d{2}:?\d{2}:?\d{2}\.\d+(-\d{2}:00|Z)$') or
            matches($thisContent, '^\d{4}-?\d{2}-?\d{2}T\d{2}:?\d{2}:?\d{2}\.\d+$') or
            matches($thisContent, '^\d{4}-?\d{2}-?\d{2}T\d{2}:?\d{2}:?\d{2}$') or
            matches($thisContent, '^\d{4}-?\d{2}-?\d{2}T\d{2}:?\d{2}$') or
            matches($thisContent, '^\d{4}-?\d{2}-?\d{2}T\d{2}$') or
            matches($thisContent, '^\d{4}-?\d{2}-?\d{2}$') or
            matches($thisContent, '^\d{4}-\d{2}$') or
            matches($thisContent, '^\d{4}$')">
          <xsl:attribute name="encoding">iso8601</xsl:attribute>
        </xsl:when>
        <!-- Some other date format -->
        <xsl:otherwise>
          <xsl:apply-templates select="@encoding" mode="prepMODS"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <!-- Record running of this stylesheet -->
  <xsl:template match="*:recordOrigin" mode="prepMODS">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:value-of select="concat(' Dates modified by ', $progName, ', ', $progVersion, ' ')"/>
      <xsl:value-of select="format-dateTime(current-dateTime(), '[Y]-[M02]-[D02]T[H01]:[m]:[s]')"/>
      <xsl:text>.</xsl:text>
    </xsl:copy>
  </xsl:template>

  <!-- restrictions imposed on access to [or use of] a resource -->
  <xsl:template match="*:accessCondition" mode="prepMODS">
    <accessCondition xmlns="http://www.loc.gov/mods/v3">
      <xsl:copy-of select="@type"/>
      <xsl:if test="@displayLabel[not(matches(., 'local|staff', 'i'))]">
        <xsl:attribute name="displayLabel">
          <xsl:value-of select="normalize-space(@displayLabel)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:variable name="href">
        <xsl:choose>
          <xsl:when
            test="matches(normalize-space(.), 'In Copyright - EU Orphan Work|InC-OW-EU/', 'i')"
            >http://rightsstatements.org/vocab/InC-OW-EU/1.0/</xsl:when>
          <xsl:when
            test="matches(normalize-space(.), 'In Copyright - Educational Use Permitted|InC-EDU/', 'i')"
            >http://rightsstatements.org/vocab/InC-EDU/1.0/</xsl:when>
          <xsl:when
            test="matches(normalize-space(.), 'In Copyright - Non-Commercial Use Permitted|InC-NC/', 'i')"
            >http://rightsstatements.org/vocab/InC-NC/1.0/</xsl:when>
          <xsl:when
            test="matches(normalize-space(.), 'In Copyright - Rights-holder(s) Unlocatable or Unidentifiable|InC-RUU/', 'i')"
            >http://rightsstatements.org/vocab/InC-RUU/1.0/</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'In Copyright|InC/', 'i')"
            >http://rightsstatements.org/vocab/InC/1.0/</xsl:when>
          <xsl:when
            test="matches(normalize-space(.), 'No Copyright - Contractual Restrictions|NoC-CR/', 'i')"
            >http://rightsstatements.org/vocab/NoC-CR/1.0/</xsl:when>
          <xsl:when
            test="matches(normalize-space(.), 'No Copyright - Non-Commercial Use Only|NoC-NC/', 'i')"
            >http://rightsstatements.org/vocab/NoC-NC/1.0/</xsl:when>
          <xsl:when
            test="matches(normalize-space(.), 'No Copyright - Other Known Legal Restrictions|NoC-OKLR/', 'i')"
            >http://rightsstatements.org/vocab/NoC-OKLR/1.0/</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'No Copyright - United States|NoC-US/', 'i')"
            >http://rightsstatements.org/vocab/NoC-US/1.0/</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'Copyright Not Evaluated|CNE/', 'i')"
            >http://rightsstatements.org/vocab/CNE/1.0/</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'Copyright Undetermined|UND/', 'i')"
            >http://rightsstatements.org/vocab/UND/1.0/</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'No Known Copyright|NKC/', 'i')"
            >http://rightsstatements.org/vocab/NKC/1.0/</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'CC BY-NC-ND', 'i')"
            >https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode0</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'Attribution-NonCommercial-NoDerivs', 'i')"
            >https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'CC BY-NC-SA', 'i')"
            >https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'Attribution-NonCommercial-ShareAlike', 'i')"
            >https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'CC BY-NC', 'i')"
            >https://creativecommons.org/licenses/by-nc/4.0/legalcode</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'Attribution-NonCommercial', 'i')"
            >https://creativecommons.org/licenses/by-nc/4.0/legalcode</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'CC BY-ND', 'i')"
            >https://creativecommons.org/licenses/by-nd/4.0/legalcode</xsl:when>
          <xsl:when test="matches(normalize-space(.), 'Attribution', 'i')"
            >https://creativecommons.org/licenses/by-nd/4.0/legalcode</xsl:when>
          <xsl:when test="matches(normalize-space(.), '^http[^\s]+$')">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:if test="normalize-space($href) ne ''">
        <xsl:attribute name="xlink:href">
          <xsl:value-of select="$href"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/InC/1.0/')">In
          Copyright</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/InC-OW-EU/1.0/')">In
          Copyright - EU Orphan Work</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/InC-EDU/1.0/')">In
          Copyright - Educational Use Permitted</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/InC-NC/1.0/')">In
          Copyright - Non-Commercial Use Permitted</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/InC-RUU/1.0/')">In
          Copyright - Rights-holder(s) Unlocatable or Unidentifiable</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/NoC-CR/1.0/')">No
          Copyright - Contractual Restrictions</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/NoC-NC/1.0/')">No
          Copyright - Non-Commercial Use Only</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/NoC-OKLR/1.0/')">No
          Copyright - Other Known Legal Restrictions</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/NoC-US/1.0/')">No
          Copyright - United States</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/CNE/1.0/')">Copyright Not
          Evaluated</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/UND/1.0/')">Copyright
          Undetermined</xsl:when>
        <xsl:when test="matches($href, 'http://rightsstatements.org/vocab/NKC/1.0/')">No Known
          Copyright</xsl:when>
        <xsl:when test="matches($href, 'https://creativecommons.org/licenses/by-nd/4.0/legalcode')"
          >Attribution</xsl:when>
        <xsl:when test="matches($href, 'https://creativecommons.org/licenses/by-nd/4.0/legalcode')"
          >CC BY-ND</xsl:when>
        <xsl:when test="matches($href, 'https://creativecommons.org/licenses/by-nc/4.0/legalcode')"
          >Attribution-NonCommercial</xsl:when>
        <xsl:when test="matches($href, 'https://creativecommons.org/licenses/by-nc/4.0/legalcode')"
          >CC BY-NC</xsl:when>
        <xsl:when
          test="matches($href, 'https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode')"
          >Attribution-NonCommercial-ShareAlike</xsl:when>
        <xsl:when
          test="matches($href, 'https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode')">CC
          BY-NC-SA</xsl:when>
        <xsl:when
          test="matches($href, 'https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode')"
          >Attribution-NonCommercial-NoDerivs</xsl:when>
        <xsl:when
          test="matches($href, 'https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode')">CC
          BY-NC-ND</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:otherwise>
      </xsl:choose>
    </accessCondition>
  </xsl:template>

  <!-- ======================================================================= -->
  <!-- MATCH TEMPLATES FOR ELEMENTS (uvaMAP mode)                                    -->
  <!-- ======================================================================= -->

  <xsl:template match="*:mods" mode="uvaMAP">
    <doc>
      <!-- Hold first pass for later processing -->
      <xsl:variable name="pass1">
        <!-- Original Metadata Type -->
        <field name="originalMetadataType">MODS</field>

        <!-- Original source record number -->
        <xsl:choose>
          <xsl:when test="@ID">
            <field name="sourceRecordIdentifier">
              <xsl:value-of select="@ID"/>
            </field>
          </xsl:when>
          <xsl:when test="*:recordInfo/*:recordIdentifier">
            <field name="sourceRecordIdentifier">
              <xsl:copy-of select="*:recordInfo/*:recordIdentifier/@source"/>
              <xsl:value-of select="*:recordInfo/*:recordIdentifier"/>
            </field>
          </xsl:when>
        </xsl:choose>

        <!-- Work Title -->
        <xsl:for-each select="*:titleInfo[matches(@type, 'uniform')][1]">
          <xsl:choose>
            <xsl:when test="@nameTitleGroup">
              <field name="work_title">
                <xsl:variable name="thisNameTitleGroup">
                  <xsl:value-of select="@nameTitleGroup"/>
                </xsl:variable>
                <xsl:variable name="name">
                  <xsl:for-each select="//*:name[@nameTitleGroup eq $thisNameTitleGroup]">
                    <xsl:for-each select="*:namePart">
                      <xsl:value-of select="normalize-space(.)"/>
                      <xsl:if test="not(position() = last())">
                        <xsl:choose>
                          <xsl:when test="not(matches(normalize-space(.), '[.:,;/]+$'))">
                            <xsl:text>, </xsl:text>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:text> </xsl:text>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:if>
                    </xsl:for-each>
                  </xsl:for-each>
                </xsl:variable>
                <xsl:value-of select="concat(replace(normalize-space($name), '\.$', ''), '. ')"/>
                <xsl:value-of
                  select="normalize-space(string-join(*[not(matches(local-name(), 'nonSort'))], '. '))"
                />
              </field>
            </xsl:when>
            <xsl:otherwise>
              <field name="work_title">
                <xsl:value-of
                  select="normalize-space(string-join(*[not(matches(local-name(), 'nonSort'))], '. '))"
                />
              </field>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>

        <!-- Key Date -->
        <!-- Dates should already be in EDTF! -->
        <xsl:variable name="keyDate1">
          <xsl:choose>
            <xsl:when test="*:originInfo/*[@keyDate = 'yes']">
              <xsl:value-of select="replace(descendant::*[@keyDate = 'yes'][1], '[\[\{\}\]]', '')"/>
            </xsl:when>
            <xsl:when test="descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateIssued">
              <xsl:value-of
                select="replace(descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateIssued[1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateCreated">
              <xsl:value-of
                select="replace(descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateCreated[1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:copyrightDate">
              <xsl:value-of
                select="replace(descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:copyrightDate[1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateValid">
              <xsl:value-of
                select="replace(descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateValid[1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateCaptured">
              <xsl:value-of
                select="replace(descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateCaptured[1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateModified">
              <xsl:value-of
                select="replace(descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateModified[1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateOther">
              <xsl:value-of
                select="replace(descendant::*:relatedItem[@type eq 'host']/*:originInfo/*:dateOther[1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*[matches(local-name(), 'dateIssued')]">
              <xsl:value-of
                select="replace(descendant::*[matches(local-name(), 'dateIssued')][1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*[matches(local-name(), 'dateCreated')]">
              <xsl:value-of
                select="replace(descendant::*[matches(local-name(), 'dateCreated')][1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*[matches(local-name(), 'copyrightDate')]">
              <xsl:value-of
                select="replace(descendant::*[matches(local-name(), 'copyrightDate')][1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*[matches(local-name(), 'dateValid')]">
              <xsl:value-of
                select="replace(descendant::*[matches(local-name(), 'dateValid')][1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*[matches(local-name(), 'dateCaptured')]">
              <xsl:value-of
                select="replace(descendant::*[matches(local-name(), 'dateCaptured')][1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*[matches(local-name(), 'dateModified')]">
              <xsl:value-of
                select="replace(descendant::*[matches(local-name(), 'dateModified')][1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
            <xsl:when test="descendant::*[matches(local-name(), 'dateOther')]">
              <xsl:value-of
                select="replace(descendant::*[matches(local-name(), 'dateOther')][1], '[\[\{\}\]]', '')"
              />
            </xsl:when>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="keyDate2">
          <xsl:choose>
            <!-- Date range with qualifiers -->
            <xsl:when test="matches($keyDate1, '(/|\.\.)') and matches($keyDate1, '[\?~%]')">
              <xsl:variable name="keyDate1rev">
                <xsl:value-of select="replace($keyDate1, '\.\.', '/')"/>
              </xsl:variable>
              <xsl:value-of select="concat('[', replace($keyDate1rev, '/', ' TO '), ']')"/>
            </xsl:when>
            <!-- Date range with unspecified digits -->
            <xsl:when test="matches($keyDate1, '/') and matches($keyDate1, '\dX')">
              <xsl:variable name="startDate">
                <xsl:value-of select="replace(substring-before($keyDate1, '/'), 'X', '0')"/>
              </xsl:variable>
              <xsl:variable name="endDate">
                <xsl:choose>
                  <!-- And an unspecified end -->
                  <xsl:when test="matches($keyDate1, '(/$|/\.\.$|/XXXX$)')">
                    <xsl:value-of select="'*'"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of
                      select="replace(replace(substring-after($keyDate1, '/'), 'X', '9'), '^9999$', '*')"
                    />
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:value-of select="concat('[', $startDate, ' TO ', $endDate, ']')"/>
            </xsl:when>
            <!-- Date range with unknown or unspecified end -->
            <xsl:when test="matches($keyDate1, '(^/|^\.\./|^XXXX/)')">
              <xsl:value-of
                select="concat('[* TO ', replace(substring-after($keyDate1, '/'), '^9999$', '*'), ']')"
              />
            </xsl:when>
            <!-- Date range with unknown or unspecified start -->
            <xsl:when test="matches($keyDate1, '(/$|/\.\.$|/XXXX$)')">
              <xsl:value-of select="concat('[', substring-before($keyDate1, '/'), ' TO *]')"/>
            </xsl:when>
            <!-- Enumerated data range -->
            <xsl:when test="matches($keyDate1, '^[\d]+(/|\.\.)[\d]+')">
              <xsl:variable name="keyDate1rev">
                <xsl:value-of select="replace($keyDate1, '\.\.', '/')"/>
              </xsl:variable>
              <xsl:value-of
                select="concat('[', substring-before($keyDate1rev, '/'), ' TO ', replace(substring-after($keyDate1rev, '/'), '^9999$', '*'), ']')"
              />
            </xsl:when>
            <!-- Single date with unspecified digits from the right -->
            <xsl:when test="matches($keyDate1, '^-?\d+X{1,3}$')">
              <xsl:value-of
                select="concat('[', replace($keyDate1, 'X', '0'), ' TO ', replace($keyDate1, 'X', '9'), ']')"
              />
            </xsl:when>
            <!-- Single year with sub-year indication -->
            <xsl:when test="matches($keyDate1, '^-?\d+-(2[1-9]|3[0-9]|4[01])$')">
              <xsl:value-of select="substring-before($keyDate1, '-')"/>
            </xsl:when>
            <!-- Single ISO/EDTF date, incl. optional qualifier  -->
            <xsl:when test="matches($keyDate1, '^-?\d+(-\d{2}(-\d{2})?)?[\?~%]?$')">
              <xsl:value-of select="normalize-space($keyDate1)"/>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="keyDate3">
          <xsl:value-of select="replace($keyDate2, '[\?~%]', '')"/>
        </xsl:variable>
        <!-- Reject date/date range that isn't EDTF/ISO-like -->
        <xsl:choose>
          <xsl:when test="
              matches($keyDate3, '^\[?-?\d+(-\d{2}(-\d{2})?)?( TO -?\d+(-\d{2}(-\d{2})?)?\])?$') or
              matches($keyDate3, '^\[?-?\d+(-\d{2}(-\d{2})?)?( TO \*?\])?$') or matches($keyDate3, '^\*( TO -?\d+(-\d{2}(-\d{2})?)?\])?$')">
            <field name="keyDate">
              <xsl:value-of select="$keyDate3"/>
            </field>
          </xsl:when>
          <xsl:otherwise>
            <xsl:comment>&#32;<xsl:value-of select="$keyDate3"/>&#32;</xsl:comment>
            <xsl:comment>&#32;No EDTF-compliant keyDate found&#32;</xsl:comment>
          </xsl:otherwise>
        </xsl:choose>

        <!-- Resource Type -->
        <xsl:apply-templates select="*:typeOfResource" mode="uvaMAP"/>

        <!-- Physical Description  -->
        <xsl:apply-templates select="*:physicalDescription" mode="uvaMAP"/>

        <!-- Display Title -->
        <xsl:if
          test="*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))][not(normalize-space(.) eq '')]">
          <field name="displayTitle">
            <xsl:variable name="displayTitle">
              <xsl:for-each
                select="*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))][not(normalize-space(.) eq '')][1]">
                <xsl:call-template name="makeDisplayTitle"/>
              </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="normalize-space(replace($displayTitle, '([.:,;/])\.', '$1'))"/>
          </field>
        </xsl:if>

        <!-- Sort Title = w/o leading article -->
        <!-- Capitalize first word -->
        <xsl:if
          test="*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))][not(normalize-space(.) eq '')]">
          <field name="sortTitle">
            <xsl:variable name="sortTitle">
              <xsl:for-each
                select="*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))][not(normalize-space(.) eq '')][1]">
                <xsl:call-template name="makeSortTitle"/>
              </xsl:for-each>
            </xsl:variable>
            <xsl:value-of
              select="lower-case(normalize-space(replace($sortTitle, '([.:,;/])\.', '$1')))"/>
          </field>
        </xsl:if>

        <!-- Title = title proper -->
        <!-- Capitalize first word -->
        <xsl:if
          test="*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))]/*:title[not(normalize-space(.) eq '')]">
          <field name="title">
            <xsl:variable name="title">
              <xsl:value-of
                select="replace(normalize-space(*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))][*:title[not(normalize-space(.) eq '')]]/*:title[not(normalize-space(.) eq '')]), '[\.:,;/]+$', '')"
              />
            </xsl:variable>
            <xsl:value-of select="upper-case(substring($title, 1, 1))"/>
            <xsl:value-of select="substring($title, 2)"/>
          </field>
        </xsl:if>

        <!-- Subtitle -->
        <!-- Capitalize first word -->
        <xsl:for-each
          select="*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))][1]/*:subTitle">
          <field name="subtitle">
            <xsl:value-of
              select="concat(upper-case(substring(normalize-space(.), 1, 1)), substring(normalize-space(.), 2))"
            />
          </field>
        </xsl:for-each>

        <!-- Abbreviated Title -->
        <xsl:for-each select="*:titleInfo[matches(@type, 'abbreviated')]">
          <field name="abbreviatedTitle">
            <xsl:call-template name="makeSortTitle"/>
          </field>
        </xsl:for-each>

        <!-- Translated Title -->
        <xsl:for-each select="*:titleInfo[matches(@type, 'translated')]">
          <field name="translatedTitle">
            <xsl:call-template name="makeSortTitle"/>
          </field>
        </xsl:for-each>

        <!-- Alternative Title -->
        <xsl:for-each select="*:titleInfo[matches(@type, 'alternative')]">
          <field name="alternativeTitle">
            <xsl:call-template name="makeSortTitle"/>
          </field>
        </xsl:for-each>
        <xsl:for-each
          select="*:titleInfo[not(matches(@type, 'abbreviated|alternative|translated|uniform'))][position() &gt; 1]">
          <field name="alternativeTitle">
            <xsl:call-template name="makeSortTitle"/>
          </field>
        </xsl:for-each>

        <!-- Transliterated Title -->
        <xsl:for-each select="*:titleInfo[@transliteration]">
          <field name="transliteratedTitle">
            <xsl:call-template name="makeSortTitle"/>
          </field>
        </xsl:for-each>

        <!-- Names & Identifiers -->
        <xsl:apply-templates select="*:name | *:identifier" mode="uvaMAP"/>

        <!-- Add metadata PID if it's not already present -->
        <!-- PID parameter *DOES NOT* override PID in the file -->
        <xsl:if test="
            not(*:identifier[matches(@displayLabel, 'pid|record displayed in virgo', 'i')]) and
            not(*:identifier[matches(@type, 'pid|record displayed in virgo', 'i')]) and
            matches($PID2, '^[^:]+:\d+$')">
          <field name="identifier" type="Metadata PID">
            <xsl:value-of select="$PID2"/>
          </field>
        </xsl:if>

        <!-- OCLC Number -->
        <xsl:for-each select="*:recordInfo/*:recordIdentifier[matches(@source, 'oco?lc', 'i')]">
          <field name="oclcNumber">
            <xsl:value-of select="normalize-space(.)"/>
          </field>
        </xsl:for-each>

        <!-- Genre -->
        <!-- De-dupe values of genre and typeOfResource elements that are not MODS 3.6 compliant -->
        <xsl:variable name="genres">
          <xsl:apply-templates
            select="*:genre[not(matches(normalize-space(.), '^(text|cartographic|notated music|sound recording|sound recording-musical|sound recording-nonmusical|still image|moving image|three dimensional object|software, multimedia|mixed material)$'))]"
            mode="uvaMAP"/>
          <xsl:for-each
            select="*:typeOfResource[not(matches(normalize-space(.), '^(text|cartographic|notated music|sound recording|sound recording-musical|sound recording-nonmusical|still image|moving image|three dimensional object|software, multimedia|mixed material)$'))]">
            <field name="genre">
              <xsl:call-template name="copyAuthDisplayAttr"/>
              <xsl:value-of select="normalize-space(.)"/>
            </field>
          </xsl:for-each>
          <!-- Add genre term based on note type -->
          <xsl:for-each select="*:note[@type = 'thesis']">
            <field name="genre">Academic theses</field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$genres/*:field">
          <xsl:variable name="thisValue">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:variable>
          <xsl:if test="not(preceding-sibling::*:field[. = $thisValue])">
            <xsl:copy-of select="."/>
          </xsl:if>
        </xsl:for-each>

        <!-- OriginInfo -->
        <xsl:apply-templates select="*:originInfo" mode="uvaMAP"/>

        <!-- Table of contents -->
        <xsl:apply-templates select="*:tableOfContents" mode="uvaMAP"/>

        <!-- Contents based on constituents -->
        <xsl:if test="*:relatedItem[matches(@type, 'constituent')]">
          <xsl:for-each select="*:relatedItem[matches(@type, 'constituent') and *:titleInfo]">
            <field name="work_relatedWork">
              <xsl:attribute name="displayLabel">
                <xsl:choose>
                  <xsl:when test="@otherType">
                    <xsl:value-of select="@otherType"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>Also contains</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:for-each select="*:name/*[normalize-space(.) ne '']">
                <xsl:value-of select="replace(normalize-space(.), '[:,;/]+$', '')"/>
                <xsl:choose>
                  <xsl:when test="position() ne last()">
                    <xsl:text>, </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>. </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
              <xsl:variable name="displayTitle">
                <xsl:for-each
                  select="*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))][1]">
                  <xsl:call-template name="makeDisplayTitle"/>
                </xsl:for-each>
              </xsl:variable>
              <xsl:value-of select="normalize-space(replace($displayTitle, '([.:,;/])\.', '$1'))"/>
            </field>
          </xsl:for-each>
        </xsl:if>

        <!-- Abstract/Summary, AccessCondition, etc. -->
        <xsl:apply-templates select="
            *:abstract | *:accessCondition | *:classification |
            *:language | *:relatedItem[matches(@type, 'otherFormat')] | *:subject/*:cartographics |
            *:targetAudience" mode="uvaMAP"/>
        <!-- Sort location on shelfLocator -->
        <xsl:apply-templates select="*:location" mode="uvaMAP">
          <xsl:sort select="descendant::*:shelfLocator"/>
        </xsl:apply-templates>

        <!-- Notes -->
        <xsl:apply-templates
          select="*:note[not(matches(@type, '59[1-9]')) and normalize-space(.) ne '']" mode="uvaMAP"/>

        <!-- Add rights statement and URIs from external file -->
        <xsl:variable name="pidMatchExact">
          <xsl:value-of select="concat('^', normalize-space($PID2), '$')"/>
        </xsl:variable>
        <xsl:variable name="accessConditionPresent">
          <xsl:choose>
            <xsl:when test="*:accessCondition">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <!-- Subject -->
        <xsl:for-each select="descendant::*:subject">
          <xsl:variable name="thisValue">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:variable>
          <!-- Exclude subjects that only contain a geographic code or hierarchical geographic expression or cartographic info; they're dealt with elsewhere. -->
          <!-- De-dupe subject values -->
          <xsl:if
            test="count(*[not(matches(local-name(), 'cartographics|geographicCode|hierarchicalGeographic'))]) &gt; 0 and not(preceding::*:subject[. eq $thisValue])">
            <field name="subject">
              <xsl:call-template name="copyAuthDisplayAttr"/>
              <xsl:if test="not(@valueURI) and count(*) = 1">
                <xsl:copy-of select="*/@valueURI"/>
              </xsl:if>
              <xsl:variable name="subjectParts">
                <xsl:for-each select="*">
                  <subjectPart>
                    <xsl:choose>
                      <xsl:when test="*">
                        <!-- Exclude geographicCode -->
                        <xsl:for-each
                          select="*[not(matches(local-name(), 'cartographics|geographicCode|hierarchicalGeographic'))]">
                          <xsl:value-of select="normalize-space(.)"/>
                          <xsl:choose>
                            <xsl:when
                              test="not(matches(normalize-space(.), '[\.,;:/-]$')) and not(position() = last())">
                              <xsl:text>, </xsl:text>
                            </xsl:when>
                            <xsl:when test="not(position() = last())">
                              <xsl:text> </xsl:text>
                            </xsl:when>
                          </xsl:choose>
                        </xsl:for-each>
                        <!--<xsl:value-of
                          select="string-join(*[not(matches(local-name(), 'cartographics|geographicCode|hierarchicalGeographic'))], ', ')"
                        />-->
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </subjectPart>
                </xsl:for-each>
              </xsl:variable>
              <xsl:value-of select="string-join($subjectParts/*, '--')"/>
            </field>
          </xsl:if>
          <!-- hierarchicalGeographic as subject heading -->
          <xsl:for-each select="*:hierarchicalGeographic">
            <field name="subject">
              <xsl:choose>
                <xsl:when test="normalize-space(@valueURI) != ''">
                  <xsl:copy-of select="@valueURI"/>
                </xsl:when>
                <xsl:when test="normalize-space(*[position() = last()]/@valueURI) != ''">
                  <xsl:copy-of select="*[position() = last()]/@valueURI"/>
                </xsl:when>
              </xsl:choose>
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:value-of select="string-join(*, '--')"/>
            </field>
          </xsl:for-each>
        </xsl:for-each>
        <!-- Subject Parts/Facets -->
        <!-- Genre as subject -->
        <xsl:variable name="subjectGenres">
          <xsl:for-each select="descendant::*:subject/*:genre">
            <xsl:sort/>
            <field name="subjectGenre">
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:value-of select="normalize-space(.)"/>
            </field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$subjectGenres/*:field">
          <xsl:call-template name="dedupeFields"/>
        </xsl:for-each>
        <!--  Geographics/Geographic code as dedicated geographic subject heading -->
        <xsl:variable name="subjectGeographics">
          <xsl:for-each select="descendant::*[matches(local-name(), 'geographic|geographicCode')]">
            <xsl:sort/>
            <xsl:variable name="thisValue">
              <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <!-- Prepare geographic code for translation -->
            <xsl:variable name="thisValueUnpadded">
              <xsl:value-of select="replace($thisValue, '-+$', '')"/>
            </xsl:variable>
            <!-- Translate geographic code into human-readable string -->
            <xsl:for-each select="$geographicAreas//*:geoArea[@code = $thisValueUnpadded]">
              <field name="subjectGeographic">
                <xsl:call-template name="copyAuthDisplayAttr2"/>
                <xsl:value-of select="normalize-space(.)"/>
              </field>
            </xsl:for-each>
            <field name="subjectGeographic">
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:value-of select="$thisValue"/>
            </field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$subjectGeographics/*:field">
          <xsl:call-template name="dedupeFields"/>
        </xsl:for-each>
        <!-- Occupation as subject -->
        <xsl:variable name="subjectOccupations">
          <xsl:for-each select="descendant::*:subject/*:occupation">
            <xsl:sort/>
            <field name="subjectOccupation">
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:value-of select="normalize-space(.)"/>
            </field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$subjectOccupations/*:field">
          <xsl:call-template name="dedupeFields"/>
        </xsl:for-each>
        <!-- Temporal division as subject -->
        <xsl:variable name="subjectTemporals">
          <xsl:for-each select="descendant::*:subject/*:temporal">
            <xsl:sort/>
            <field name="subjectTemporal">
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:value-of select="normalize-space(.)"/>
            </field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$subjectTemporals/*:field">
          <xsl:call-template name="dedupeFields"/>
        </xsl:for-each>
        <!-- Topic as subject -->
        <xsl:variable name="subjectTopics">
          <xsl:for-each select="descendant::*:subject/*:topic">
            <xsl:sort/>
            <field name="subjectTopic">
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:value-of select="normalize-space(.)"/>
            </field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$subjectTopics/*:field">
          <xsl:call-template name="dedupeFields"/>
        </xsl:for-each>
        <!-- Hierarchical geographic subject -->
        <xsl:variable name="subjectHierarchicals">
          <xsl:for-each select="descendant::*:subject/*:hierarchicalGeographic">
            <xsl:sort/>
            <field name="subjectGeographic">
              <xsl:choose>
                <xsl:when test="normalize-space(@valueURI) != ''">
                  <xsl:copy-of select="@valueURI"/>
                </xsl:when>
                <xsl:when test="normalize-space(*[position() = last()]/@valueURI) != ''">
                  <xsl:copy-of select="*[position() = last()]/@valueURI"/>
                </xsl:when>
              </xsl:choose>
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:value-of select="normalize-space(string-join(*[normalize-space(.) ne ''], '--'))"
              />
            </field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$subjectHierarchicals/*:field">
          <xsl:call-template name="dedupeFields"/>
        </xsl:for-each>
        <!-- Name as subject -->
        <xsl:variable name="subjectNames">
          <xsl:for-each select="descendant::*:subject/*:name">
            <field name="subjectName">
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:copy-of select="@type"/>
              <xsl:variable name="namePartSeparator">
                <xsl:choose>
                  <xsl:when test="descendant::*[position() != last()][matches(., '[\.:,;/-]+$')]">
                    <xsl:text> </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>, </xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:value-of
                select="replace(normalize-space(string-join(*[normalize-space(.) ne ''], $namePartSeparator)), ', \(', ' (')"
              />
            </field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$subjectNames/*:field">
          <xsl:call-template name="dedupeFields"/>
        </xsl:for-each>
        <!-- Title as subject -->
        <xsl:variable name="subjectTitles">
          <xsl:for-each select="descendant::*:subject/*:titleInfo">
            <xsl:sort/>
            <field name="subjectTitle">
              <xsl:call-template name="copyAuthDisplayAttr2"/>
              <xsl:value-of select="normalize-space(string-join(*[normalize-space(.) ne ''], ' '))"
              />
            </field>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$subjectTitles/*:field">
          <xsl:call-template name="dedupeFields"/>
        </xsl:for-each>

        <!-- Relationships -->
        <xsl:apply-templates select="*:relatedItem[matches(@type, 'host|original|series')]"
          mode="uvaMAP"/>
        <xsl:apply-templates select="*:relatedItem[matches(@type, 'isReferencedBy')]" mode="uvaMAP"/>
        <xsl:apply-templates select="*:relatedItem[matches(@type, 'preceding|succeeding')]"
          mode="uvaMAP"/>
        <xsl:apply-templates select="*:relatedItem[matches(@type, 'otherVersion')]" mode="uvaMAP"/>
        <xsl:apply-templates select="*:relatedItem[not(@type)]" mode="uvaMAP"/>
      </xsl:variable>

      <!-- Output record so far -->
      <xsl:copy-of select="$pass1"/>

      <!-- Add work title -->
      <xsl:if test="not($pass1/*:field[@name = 'work_title'])">
        <field name="work_title" supplied="yes">
          <!-- Use title without leading article -->
          <xsl:value-of select="upper-case(substring($pass1/*:field[@name eq 'sortTitle'], 1, 1))"/>
          <xsl:value-of select="substring($pass1/*:field[@name eq 'sortTitle'], 2)"/>
          <!-- Add content type -->
          <xsl:text>¶</xsl:text>
          <xsl:value-of select="$pass1/*:field[@name eq 'contentType']"/>
          <!-- If serial, add issuanceMethod -->
          <xsl:if test="$pass1/*:field[@name eq 'issuanceMethod'][. eq 'serial']">
            <xsl:text>, serial</xsl:text>
          </xsl:if>
          <!-- Add work date -->
          <xsl:choose>
            <xsl:when test="$pass1/*:field[@name eq 'keyDate']">
              <xsl:text>¶</xsl:text>
              <xsl:value-of
                select="replace(replace(replace($pass1/*:field[@name eq 'keyDate'], '[\[\]]', ''), ' TO \*', '/'), ' TO ', '/')"
              />
            </xsl:when>
          </xsl:choose>
          <!-- Add creator or collection name -->
          <xsl:choose>
            <xsl:when test="$pass1/*:field[@name eq 'creator']">
              <xsl:text>¶</xsl:text>
              <xsl:value-of select="$pass1/*:field[@name eq 'creator'][1]"/>
            </xsl:when>
            <xsl:when test="$pass1/*:field[@name eq 'orig_creator']">
              <xsl:text>¶</xsl:text>
              <xsl:value-of select="$pass1/*:field[@name eq 'orig_creator'][1]"/>
            </xsl:when>
            <xsl:when test="$pass1/*:field[@name eq 'work_creator']">
              <xsl:text>¶</xsl:text>
              <xsl:value-of select="$pass1/*:field[@name eq 'work_creator'][1]"/>
            </xsl:when>
            <xsl:when test="$pass1/*:field[@name eq 'host_title']">
              <xsl:text>¶</xsl:text>
              <xsl:value-of select="$pass1/*:field[@name eq 'host_title'][1]"/>
            </xsl:when>
          </xsl:choose>
        </field>
      </xsl:if>
    </doc>
  </xsl:template>

  <!-- cartographic data indicating spatial coverage -->
  <xsl:template match="*:cartographics" mode="uvaMAP">
    <xsl:for-each select="*:coordinates | *:projection | *:scale">
      <field name="{local-name()}">
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:for-each>
  </xsl:template>

  <!-- language of the content of a resource -->
  <xsl:template match="*:language" mode="uvaMAP">
    <xsl:variable name="fieldNameLang">
      <!--<xsl:call-template name="whereAmI"/>-->
      <xsl:choose>
        <xsl:when test="matches(@objectPart, 'translation')">
          <xsl:text>originalLanguage</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>language</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="objectPart">
      <xsl:value-of select="normalize-space(@objectPart)"/>
    </xsl:variable>
    <xsl:for-each select="distinct-values(*:languageTerm)">
      <field name="{$fieldNameLang}">
        <xsl:if test="$objectPart ne '' and $objectPart ne 'translation'">
          <xsl:attribute name="objectPart">
            <xsl:value-of select="$objectPart"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:variable name="langTerm">
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:variable>
        <!-- Get first match of @code in $marcLangList -->
        <xsl:value-of select="$marcLangList//*:lang[@code eq $langTerm][1]"/>
      </field>
    </xsl:for-each>
    <xsl:variable name="fieldNameScript">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>alphabetScript</xsl:text>
    </xsl:variable>
    <xsl:for-each select="distinct-values(*:scriptTerm)">
      <field name="{$fieldNameScript}">
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:for-each>
  </xsl:template>

  <!--  description of the contents of a resource -->
  <xsl:template match="*:tableOfContents" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <!--<xsl:call-template name="whereAmI"/>-->
      <xsl:text>contents</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:apply-templates select="@displayLabel" mode="uvaMAP"/>
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- description of the intellectual level of the audience for which the resource is intended -->
  <xsl:template match="*:targetAudience" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>targetAudience</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:apply-templates select="@displayLabel" mode="uvaMAP"/>
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- name of a person, organization, or event (conference, meeting, etc.) -->
  <xsl:template match="*:name" mode="uvaMAP">
    <xsl:if test="*:namePart[not(normalize-space(.) eq '')]">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:choose>
          <xsl:when test="count(../*:name) = 1">creator</xsl:when>
          <xsl:when test="*:role[*:roleTerm[matches(., '^(creator|cre)$')]]">creator</xsl:when>
          <xsl:when test="@usage eq 'primary'">creator</xsl:when>
          <xsl:otherwise>contributor</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:copy-of select="@authority | @authorityURI | @valueURI | @type"/>
        <xsl:variable name="roles">
          <xsl:for-each select="*:role/*:roleTerm">
            <xsl:variable name="thisValue">
              <xsl:value-of select="replace(lower-case(normalize-space(.)), '[\.:,;/]+$', '')"/>
            </xsl:variable>
            <xsl:choose>
              <!-- Map coded role value to term -->
              <xsl:when test="$marcRelators//*:relator[@code = $thisValue]">
                <role>
                  <xsl:value-of select="$marcRelators//*:relator[@code = $thisValue]/@term"/>
                </role>
              </xsl:when>
              <xsl:otherwise>
                <role>
                  <xsl:value-of select="lower-case(normalize-space(.))"/>
                </role>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:variable>
        <xsl:if test="normalize-space($roles) ne ''">
          <xsl:attribute name="role">
            <xsl:for-each select="distinct-values($roles/*:role)">
              <xsl:if test="position() &gt; 1">
                <xsl:text>, </xsl:text>
              </xsl:if>
              <xsl:value-of select="."/>
            </xsl:for-each>
          </xsl:attribute>
        </xsl:if>
        <xsl:variable name="nameValue">
          <xsl:value-of
            select="normalize-space(string-join(*:namePart[not(matches(@type, 'date'))], ' '))"/>
        </xsl:variable>
        <xsl:value-of select="replace(normalize-space($nameValue), '[:,;/]+$', '')"/>
        <xsl:for-each select="*:namePart[matches(@type, 'date')]">
          <xsl:value-of select="concat(', ', normalize-space(.))"/>
        </xsl:for-each>
      </field>
    </xsl:if>
  </xsl:template>

  <!-- summary of the content of the resource -->
  <xsl:template match="*:abstract" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>abstractSummary</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:apply-templates select="@displayLabel" mode="uvaMAP"/>
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- designation applied to a resource that indicates the subject by applying a formal system of
  coding and organizing resources according to subject areas -->
  <xsl:template match="*:classification" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <!--<xsl:call-template name="whereAmI"/>-->
      <xsl:text>classification</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:call-template name="copyAuthDisplayAttr"/>
      <xsl:copy-of select="@edition"/>
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- term(s) that designates a category characterizing a particular style, form, or content -->
  <xsl:template match="*:genre" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:choose>
        <xsl:when test="matches(., 'government publication', 'i')">
          <xsl:text>governmentPublication</xsl:text>
        </xsl:when>
        <xsl:when test="matches(., 'festschrift', 'i')">
          <xsl:text>isFestschrift</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="contains($fieldName, 'isFestschrift')">
        <field name="isFestschrift">
          <xsl:text>yes</xsl:text>
        </field>
      </xsl:when>
      <xsl:when test="contains($fieldName, 'governmentPublication')">
        <field name="governmentPublication">
          <xsl:choose>
            <xsl:when test="matches(., 'autonomous', 'i')">
              <xsl:text>autonomous</xsl:text>
            </xsl:when>
            <xsl:when test="matches(., 'federal', 'i')">
              <xsl:text>federal</xsl:text>
            </xsl:when>
            <xsl:when test="matches(., 'intergovernmental')">
              <xsl:text>international intergovernmental</xsl:text>
            </xsl:when>
            <xsl:when test="matches(., 'multilocal')">
              <xsl:text>multilocal</xsl:text>
            </xsl:when>
            <xsl:when test="matches(., 'local')">
              <xsl:text>local</xsl:text>
            </xsl:when>
            <xsl:when test="matches(., 'multistate')">
              <xsl:text/>
            </xsl:when>
            <xsl:when test="matches(., 'state')">
              <xsl:text>state</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>government publication</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </field>
      </xsl:when>
      <!-- Expanding marcmuscomp codes with strings appears to duplicate subject headings,
        so not implemented now. -->
      <xsl:when test="matches(@authority, 'marcmuscomp')">
        <xsl:analyze-string select="normalize-space(.)" regex="-+">
          <xsl:non-matching-substring>
            <!-- Use 'formOfComposition' instead of $fieldName? -->
            <field name="{$fieldName}">
              <xsl:attribute name="authority">
                <xsl:text>marcmuscomp</xsl:text>
              </xsl:attribute>
              <xsl:variable name="thisValue">
                <xsl:value-of select="."/>
              </xsl:variable>
              <xsl:value-of select="$compFormMap/*:compForm[. eq $thisValue]/@term"/>
            </field>
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </xsl:when>
      <!-- Ignore lctgm values -->
      <xsl:when test="matches(@authority, 'lctgm')"/>
      <!-- Anything else -->
      <xsl:otherwise>
        <field name="genre">
          <xsl:call-template name="copyAuthDisplayAttr"/>
          <xsl:value-of select="normalize-space(.)"/>
        </field>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- unique standard number or code that distinctively identifies a resource -->
  <xsl:template match="*:identifier" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:choose>
        <xsl:when test="matches(@type, 'oco?lc', 'i')">oclcNumber</xsl:when>
        <xsl:when test="matches(@type, 'lccn', 'i')">libraryCongressControlNumber</xsl:when>
        <xsl:when test="matches(@type, 'isbn', 'i')">internationalStandardBookNumber</xsl:when>
        <xsl:when test="matches(@type, 'issn', 'i')">internationalStandardSerialNumber</xsl:when>
        <xsl:when test="matches(@type, 'isrc', 'i')">internationalStandardRecordingCode</xsl:when>
        <xsl:when test="matches(@type, 'upc', 'i')">universalProductCode</xsl:when>
        <xsl:when test="matches(@type, 'ismn', 'i')">internationalStandardMusicNumber</xsl:when>
        <xsl:when test="matches(@type, 'ian', 'i')">internationalArticleNumber</xsl:when>
        <xsl:when test="matches(@type, 'sici', 'i')">serialItemContributionIdentifier</xsl:when>
        <xsl:when test="matches(@type, 'strn', 'i')">standardTechnicalReportNumber</xsl:when>
        <xsl:when
          test="matches(@type, '(issue.number|matrix.number|music.plate|music.publisher|stock.number|videorecording.identifier)')"
          >publisherDistributorNumber</xsl:when>
        <xsl:when test="matches(@type, 'GPO item number', 'i')">gpoItemNumber</xsl:when>
        <xsl:when test="matches(@type, 'CODEN', 'i')">CODEN</xsl:when>
        <xsl:when
          test="not(matches(@type, '(lccn|isbn|issn|isrc|upc|ismn|ian|sici|stm|stock.number|music.plate|music.publisher)'))">
          <xsl:text>identifier</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:copy-of select="@typeURI"/>
      <!-- Include identifiers with @invalid="yes" -->
      <xsl:copy-of select="@invalid"/>
      <xsl:choose>
        <!-- use @displayLabel when available or @type if it's not -->
        <xsl:when
          test="@displayLabel[not(matches(., 'legacy|local|staff', 'i')) and not(normalize-space(.) eq '')] and matches($fieldName, '(local|otherStandard)?identifier', 'i')">
          <xsl:attribute name="type">
            <xsl:value-of select="normalize-space(@displayLabel)"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when
          test="@type[not(matches(., 'legacy|local|staff|oco?lc|lccn|isbn|issn|isrc|upc|ismn|ian|sici|strn|CODEN|GPO', 'i'))]">
          <xsl:attribute name="type">
            <xsl:value-of
              select="replace(replace(normalize-space(@type), 'oco?lc', 'oclc', 'i'), '\.', ' ')"/>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- Map note/@type to uvaMap element name -->
  <xsl:template match="*:note[not(matches(@type, 'uvax-'))]" mode="uvaMAP">
    <xsl:variable name="whereAmI">
      <xsl:call-template name="whereAmI"/>
    </xsl:variable>
    <xsl:variable name="fieldName">
      <xsl:choose>
        <xsl:when test="matches(@type, 'acquisition')">
          <xsl:text>acqInfo</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'action')">
          <xsl:text>appraisalProcessInfo</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'additional physical form')">
          <xsl:text>addPhysicalForm</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'bibliographical/historical')">
          <xsl:text>biogHist</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'citation/reference')">
          <xsl:text>referencedBy</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'creation/production credits')">
          <xsl:text>credits</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'funding')">
          <xsl:text>sponsor</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'ownership')">
          <xsl:text>custodHist</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'performers')">
          <xsl:text>performers</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'preferred citation')">
          <xsl:text>preferredCitation</xsl:text>
        </xsl:when>
        <xsl:when test="matches(@type, 'publications')">
          <xsl:text>publications</xsl:text>
        </xsl:when>
        <xsl:when
          test="matches(@type, '(original locations|original version|source characteristics|source dimensions|source identifier|source note|source type)')">
          <xsl:text>originalsNote</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>note</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- Exclude notes where @type matches 'private' -->
    <xsl:if test="not(matches(@type, 'private'))">
      <field name="{$whereAmI}{$fieldName}">
        <xsl:if test="
            @type[not(matches(.,
            'local|staff|acquisition|action|additional physical form|bibliographical/historical|citation/reference|creation/production credits|funding|general|ownership|performers|preferred citation|publications|original (locations|version)|source (characteristics|dimensions|identifier|note|type)', 'i'))]">
          <xsl:attribute name="type">
            <xsl:value-of select="@type"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@displayLabel and not(matches(@displayLabel, '^(local|staff)$', 'i'))">
          <xsl:copy-of select="@displayLabel"/>
        </xsl:if>
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:if>
    <xsl:if
      test="matches(., 'bibliograph', 'i') and not(../*:physicalDescription/*:note[matches(@type, 'containsBibrefs')])">
      <field name="containsBibrefs">
        <xsl:text>yes</xsl:text>
      </field>
    </xsl:if>
    <xsl:if
      test="matches(., '(contains|includes).*index', 'i') and not(../*:physicalDescription/*:note[matches(@type, 'containsIndex')])">
      <field name="containsIndex">
        <xsl:text>yes</xsl:text>
      </field>
    </xsl:if>
  </xsl:template>

  <!-- Information about the origin of the resource -->
  <xsl:template match="*:originInfo" mode="uvaMAP">
    <xsl:for-each select="*:publisher">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:text>pubProdDist</xsl:text>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:value-of
          select="replace(normalize-space(replace(., '^[.:,;/\[\]\s]+|[:,;/\[\]\s]+$', '')), 's\.n\.?', 'No name, unknown, or undetermined', 'i')"
        />
      </field>
    </xsl:for-each>

    <!-- Place -->
    <xsl:variable name="places">
      <xsl:for-each select="*:place">
        <xsl:variable name="fieldName">
          <xsl:call-template name="whereAmI"/>
          <xsl:text>pubProdDistPlace</xsl:text>
        </xsl:variable>
        <xsl:for-each
          select="*:placeTerm[matches(@type, 'code') and matches(@authority, 'marccountry')]">
          <xsl:variable name="placeCode">
            <!-- Account for incorrect case and/or length of placeTerm code -->
            <xsl:value-of select="substring(concat(lower-case(.), '   '), 1, 3)"/>
          </xsl:variable>
          <!-- Provide country name for state/territory codes -->
          <xsl:choose>
            <xsl:when test="matches($placeCode, '..a')">
              <field name="{$fieldName}">
                <xsl:text>Australia</xsl:text>
              </field>
            </xsl:when>
            <xsl:when test="matches($placeCode, '..c')">
              <field name="{$fieldName}">
                <xsl:text>Canada</xsl:text>
              </field>
            </xsl:when>
            <xsl:when test="matches($placeCode, '..k')">
              <field name="{$fieldName}">
                <xsl:text>United Kingdom</xsl:text>
              </field>
            </xsl:when>
            <xsl:when test="matches($placeCode, '..u')">
              <field name="{$fieldName}">
                <xsl:text>United States</xsl:text>
              </field>
            </xsl:when>
          </xsl:choose>
          <field name="{$fieldName}">
            <xsl:value-of select="$marcCountryCodes//*:country[@code eq $placeCode]"/>
          </field>
        </xsl:for-each>
        <xsl:for-each select="*:placeTerm[not(matches(@type, 'code'))]">
          <xsl:variable name="thisValue">
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="matches($thisValue, 's\.[1l]\.?', 'i')">
              <field name="{$fieldName}">
                <xsl:text>No place, unknown, or undetermined</xsl:text>
              </field>
            </xsl:when>
            <xsl:when test="$marcCountryCodes//*:country[@code eq $thisValue]">
              <field name="{$fieldName}">
                <xsl:value-of select="$marcCountryCodes//*:country[@code eq $thisValue]"/>
              </field>
            </xsl:when>
            <xsl:otherwise>
              <field name="{$fieldName}">
                <xsl:value-of
                  select="normalize-space(replace(., '^[.:,;/\[\]\s]+|[:,;/\[\]\s]+$', ''))"/>
              </field>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:variable>
    <xsl:for-each select="$places/*:field">
      <xsl:variable name="thisValue">
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:variable>
      <xsl:if test="not(preceding-sibling::*:field[. = $thisValue])">
        <xsl:copy-of select="."/>
      </xsl:if>
    </xsl:for-each>

    <!-- Date -->
    <!-- De-dupe values in same element -->
    <xsl:for-each
      select="*:copyrightDate | *:dateCaptured | *:dateCreated | *:dateIssued | *:dateValid | *:dateOther">
      <xsl:variable name="thisElement">
        <xsl:value-of select="local-name()"/>
      </xsl:variable>
      <xsl:variable name="thisValue">
        <xsl:value-of select="replace(normalize-space(.), '\D', '')"/>
      </xsl:variable>
      <xsl:if
        test="not(normalize-space(.) eq '') and not(preceding::*[matches(local-name(), $thisElement)][replace(normalize-space(.), '\D', '') = $thisValue])">
        <xsl:variable name="fieldName">
          <xsl:call-template name="whereAmI"/>
          <xsl:value-of select="local-name()"/>
        </xsl:variable>
        <field name="{$fieldName}">
          <xsl:if test="not(matches(., 'undated'))">
            <xsl:copy-of select="@encoding"/>
          </xsl:if>
          <xsl:value-of select="normalize-space(.)"/>
        </field>
      </xsl:if>
    </xsl:for-each>

    <!-- Edition/Version -->
    <xsl:for-each select="*:edition">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:text>editionVersion</xsl:text>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:for-each>

    <!-- Date modified -->
    <xsl:for-each select="*:dateModified">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:text>editionVersionDate</xsl:text>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:for-each>

    <!-- Issuance method -->
    <xsl:for-each select="*:issuance">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:text>issuanceMethod</xsl:text>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:for-each>

    <!-- Frequency -->
    <xsl:for-each select="*:frequency">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:text>frequency</xsl:text>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:for-each>
  </xsl:template>

  <!-- Physical description information of the resource -->
  <xsl:template match="*:physicalDescription" mode="uvaMAP">
    <!-- Media Type -->
    <xsl:variable name="mediaTypes">
      <xsl:for-each select="*:form[matches(@type, 'media')]">
        <mediaType>
          <xsl:value-of select="normalize-space(.)"/>
        </mediaType>
      </xsl:for-each>
      <!-- Collect media types based on certain types of <form> -->
      <xsl:for-each
        select="*:form[matches(@authority, 'gmd|marccategory|marcform|marcsmd|rdamedia')]">
        <xsl:variable name="thisValue">
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:variable>
        <xsl:for-each select="$marcMediaMap//*:media[. = $thisValue]">
          <mediaType>
            <xsl:value-of select="@rdaType"/>
          </mediaType>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="mediaTypeFieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>mediaType</xsl:text>
    </xsl:variable>
    <xsl:if
      test="$DL_digitized = 'true' and not(ancestor-or-self::*/*:physicalDescription/*:form[matches(., 'electronic|online|remote')])">
      <field name="mediaType">
        <xsl:text>computer</xsl:text>
      </field>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="$mediaTypes/*:mediaType">
        <xsl:for-each
          select="distinct-values($mediaTypes/*:mediaType[not(matches(., 'unmediated'))])">
          <field>
            <xsl:attribute name="name">
              <xsl:value-of select="$mediaTypeFieldName"/>
            </xsl:attribute>
            <xsl:value-of select="normalize-space(.)"/>
          </field>
        </xsl:for-each>
        <xsl:if
          test="$mediaTypes/*:mediaType[matches(., 'unmediated')] and count(distinct-values($mediaTypes/*:mediaType[not(matches(., 'unmediated'))])) = 0">
          <field>
            <xsl:attribute name="name">
              <xsl:value-of select="$mediaTypeFieldName"/>
            </xsl:attribute>
            <xsl:text>unmediated</xsl:text>
          </field>
        </xsl:if>
      </xsl:when>
      <xsl:when test="*:internetMediaType or *:digitalOrigin">
        <field>
          <xsl:attribute name="name">
            <xsl:value-of select="$mediaTypeFieldName"/>
          </xsl:attribute>
          <xsl:text>computer</xsl:text>
        </field>
      </xsl:when>
    </xsl:choose>

    <!-- Carrier type -->
    <xsl:variable name="carrierTypeFieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>carrierType</xsl:text>
    </xsl:variable>
    <!-- Collect carrier types based on certain values of form -->
    <xsl:variable name="mappedCarrierTypes">
      <xsl:for-each select="*:form[not(matches(@authority, 'rdacarrier'))]">
        <xsl:variable name="thisValue">
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:variable>
        <xsl:for-each select="$marcCarrierMap//*:carrier[. = $thisValue]">
          <xsl:value-of select="@rdaType"/>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="carrierValue">
      <xsl:choose>
        <!-- Use RDA value -->
        <xsl:when test="*:form[matches(@authority, 'rdacarrier')]">
          <xsl:for-each select="*:form[matches(@authority, 'rdacarrier')]">
            <xsl:if test="position() &gt; 1">
              <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="normalize-space(.)"/>
          </xsl:for-each>
        </xsl:when>
        <!-- Map marcsmd to RDA -->
        <xsl:when test="*:form[matches(@authority, 'marcsmd')]">
          <xsl:for-each select="*:form[matches(@authority, 'marcsmd')]">
            <xsl:variable name="thisValue">
              <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <xsl:for-each select="$marcCarrierMap//*:carrier[. = $thisValue]">
              <xsl:if test="position() &gt; 1">
                <xsl:text>, </xsl:text>
              </xsl:if>
              <xsl:value-of select="@rdaType"/>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:when>
        <!-- Map marccategory to RDA -->
        <xsl:when test="*:form[matches(@authority, 'marccategory')]">
          <xsl:for-each select="*:form[matches(@authority, 'marccategory')]">
            <xsl:variable name="thisValue">
              <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <xsl:for-each select="$marcCarrierMap//*:carrier[. = $thisValue]">
              <xsl:if test="position() &gt; 1">
                <xsl:text>, </xsl:text>
              </xsl:if>
              <xsl:value-of select="@rdaType"/>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:when>
        <!-- Map GMD to RDA -->
        <xsl:when test="*:form[matches(@authority, 'gmd')]">
          <xsl:choose>
            <xsl:when test="$mappedCarrierTypes/*:carrierType">
              <xsl:for-each select="$mappedCarrierTypes/*:carrierType">
                <xsl:if test="position() &gt; 1">
                  <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="normalize-space(.)"/>
              </xsl:for-each>
            </xsl:when>
          </xsl:choose>
        </xsl:when>
        <!-- Map marcform to RDA -->
        <xsl:when test="*:form[matches(@authority, 'marcform')]">
          <xsl:choose>
            <xsl:when test="$mappedCarrierTypes/*:carrierType">
              <xsl:for-each select="$mappedCarrierTypes/*:carrierType">
                <xsl:if test="position() &gt; 1">
                  <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="normalize-space(.)"/>
              </xsl:for-each>
            </xsl:when>
          </xsl:choose>
        </xsl:when>
        <!-- Map internetMediaType or digitalOrigin to RDA -->
        <xsl:when test="*:internetMediaType or *:digitalOrigin">
          <xsl:text>online resource</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:if
      test="$DL_digitized = 'true' and not(ancestor-or-self::*/*:physicalDescription/*:form[matches(., 'electronic|online|remote')])">
      <field name="carrierType">
        <xsl:text>online resource</xsl:text>
      </field>
    </xsl:if>
    <field>
      <xsl:attribute name="name">
        <xsl:value-of select="$carrierTypeFieldName"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="normalize-space($carrierValue) ne ''">
          <xsl:value-of select="normalize-space($carrierValue)"/>
        </xsl:when>
        <xsl:when test="matches(ancestor::*:mods/*:typeOfResource, 'text')">
          <xsl:text>volume</xsl:text>
        </xsl:when>
        <xsl:when test="matches(ancestor::*:mods/*:typeOfResource, 'object')">
          <xsl:text>object</xsl:text>
        </xsl:when>
        <xsl:when test="*:extent[matches(., 'compact disc')] or ../*:note[matches(., 'CD')]">
          <xsl:text>computer disc</xsl:text>
        </xsl:when>
        <xsl:when test="*:extent[matches(., 'videodisc')] or ../*:note[matches(., 'DVD')]">
          <xsl:text>videodisc</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>unspecified</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </field>

    <!-- Physical extent -->
    <!-- Multiple extent elements result in multiple physExtent elements in the output -->
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>physExtent</xsl:text>
    </xsl:variable>
    <xsl:for-each select="*:extent">
      <xsl:variable name="unit">
        <xsl:value-of select="replace(normalize-space(@unit), '\W+$', '')"/>
      </xsl:variable>
      <xsl:analyze-string select="normalize-space(.)" regex="\+">
        <xsl:non-matching-substring>
          <xsl:variable name="subfieldA">
            <xsl:call-template name="getSubfield">
              <xsl:with-param name="stringValue">
                <xsl:value-of select="."/>
              </xsl:with-param>
              <xsl:with-param name="subfield">a</xsl:with-param>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="not(normalize-space($subfieldA) eq '')">
            <!-- Substrings beyond the first are mapped to accMatter elements -->
            <field>
              <xsl:attribute name="name">
                <xsl:choose>
                  <xsl:when test="position() = 1">
                    <xsl:value-of select="$fieldName"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>accMatter</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:value-of select="$subfieldA"/>
              <!-- Unless it's already present in $subfieldA, append value of $unit -->
              <xsl:if test="position() = 1 and not(matches($subfieldA, $unit, 'i'))">
                <xsl:value-of select="concat(' ', $unit)"/>
              </xsl:if>
              <!-- Add a closing parenthesis if needed -->
              <xsl:if test="matches($subfieldA, '\([^\)]+$')">
                <xsl:text>)</xsl:text>
              </xsl:if>
            </field>
          </xsl:if>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:for-each>

    <!-- Other "facet-able" physical details -->
    <!-- Results in individual elements -->
    <xsl:for-each
      select="*:note[matches(@type, '^uvax-') and matches(@type, 'alphabetScript|brailleClass|brailleMusicFormat|colorContent|containsBibrefs|containsIndex|filmPresentationFormat|formOfComposition|illustrations|instrumentsVoicesCode|musicKey|musicParts|performanceMedium|physDimensions|playbackChannels|playbackSpecial|playingSpeed|playingTime|projection|relief|scoreFormat|soundContent|transpositionArrangement|videoFormat')]">
      <xsl:variable name="fieldName">
        <xsl:choose>
          <!-- Digitized -->
          <xsl:when
            test="$DL_digitized = 'true' and not(ancestor-or-self::*/*:physicalDescription/*:form[matches(., 'electronic|online|remote')])">
            <xsl:if test="matches(@type, 'physDimensions')">
              <xsl:text>orig_</xsl:text>
            </xsl:if>
          </xsl:when>
          <!--  NOT Digitized -->
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="ancestor::*:relatedItem[matches(@type, 'host')]">
                <xsl:text>host_</xsl:text>
              </xsl:when>
              <xsl:when test="ancestor::*:relatedItem[matches(@type, 'original')]">
                <xsl:text>orig_</xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="substring-after(@type, 'uvax-')"/>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:copy-of select="@displayLabel"/>
        <xsl:value-of select="."/>
      </field>
    </xsl:for-each>

    <!-- Other non-facet-able technical details -->
    <!-- Collected into a single physDetails element -->
    <xsl:if test="
        *:form[matches(@type, 'material|technique')] or *:note[matches(@type, '^uvax-') and
        not(matches(@type, 'alphabetScript|brailleClass|brailleMusicFormat|colorContent|containsBibrefs|containsIndex|filmPresentationFormat|formOfComposition|illustrations|instrumentsVoicesCode|musicKey|musicParts|performanceMedium|physDimensions|playbackChannels|playbackSpecial|playingSpeed|playingTime|projection|relief|scoreFormat|soundContent|transpositionArrangement|videoFormat'))]">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:text>physDetails</xsl:text>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:variable name="sortedDetails">
          <xsl:for-each select="
              *:form[matches(@type, 'material|technique')] |
              *:note[matches(@type, '^uvax-') and not(matches(@type, 'alphabetScript|brailleClass|brailleMusicFormat|colorContent|containsIndex|filmPresentationFormat|formOfComposition|illustrations|instrumentsVoicesCode|musicKey|musicParts|performanceMedium|physDimensions|playbackChannels|playbackSpecial|playingSpeed|playingTime|projection|relief|scoreFormat|soundContent|transpositionArrangement|videoFormat'))]">
            <xsl:sort select="@displayLabel"/>
            <xsl:copy-of select="."/>
          </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="$sortedDetails/*">
          <xsl:if test="position() &gt; 1">
            <xsl:text>; </xsl:text>
          </xsl:if>
          <xsl:variable name="precedingLabel">
            <xsl:value-of select="preceding-sibling::*[1]/@displayLabel"/>
          </xsl:variable>
          <xsl:if test="@displayLabel != $precedingLabel">
            <xsl:value-of
              select="concat(normalize-space(replace(@displayLabel, '[.,;:]+$', '')), ': ')"/>
          </xsl:if>
          <xsl:value-of select="."/>
        </xsl:for-each>
      </field>
    </xsl:if>

    <!-- Other physical description info -->
    <xsl:apply-templates
      select="*:digitalOrigin | *:internetMediaType | *:note[not(matches(@type, '59[1-9]|uvax-')) and normalize-space(.) ne ''] | *:reformattingQuality"
      mode="uvaMAP"/>
  </xsl:template>

  <!-- source of a digital file important to its creation, use and management -->
  <xsl:template match="*:digitalOrigin" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>digitalOrigin</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- assessment of the physical quality of an electronic resource in relation to its intended use -->
  <xsl:template match="*:reformattingQuality" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>reformattingQuality</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- electronic format type, or the data representation of the resource -->
  <xsl:template match="*:internetMediaType" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>internetMediaType</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- Other resources related to the one being described -->
  <!-- Host or Original -->
  <xsl:template match="*:relatedItem[matches(@type, 'host|original')]" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:value-of select="concat(substring(@type, 1, 4), '_')"/>
      <xsl:text>contentType</xsl:text>
    </xsl:variable>
    <xsl:choose>
      <!-- Use typeOfResource when it's available -->
      <xsl:when test="*:typeOfResource">
        <xsl:apply-templates select="*:typeOfResource" mode="uvaMAP"/>
      </xsl:when>
      <!-- Perform a lookup in resourcetypeMap -->
      <xsl:otherwise>
        <xsl:variable name="resourceTypes">
          <!-- Map form and genre elements to resourceType -->
          <xsl:for-each select="*:physicalDescription/*:form | *:mods/*:genre">
            <xsl:variable name="thisValue">
              <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <xsl:for-each select="$resourceMap//*:content[. = $thisValue]">
              <resourceType>
                <xsl:value-of select="@resourceType"/>
              </resourceType>
            </xsl:for-each>
          </xsl:for-each>
          <!-- Map internetMediaType values to resourceType -->
          <xsl:for-each
            select="*:physicalDescription/*:internetMediaType[matches(normalize-space(.), '^(application|audio|image|text|video|font|multipart)')]">
            <resourceType>
              <xsl:choose>
                <xsl:when test="matches(normalize-space(.), '^(application|font|multipart)')">
                  <xsl:text>software, multimedia</xsl:text>
                </xsl:when>
                <xsl:when test="matches(normalize-space(.), '^audio')">
                  <xsl:text>sound recording</xsl:text>
                </xsl:when>
                <xsl:when test="matches(normalize-space(.), '^image')">
                  <xsl:text>still image</xsl:text>
                </xsl:when>
                <xsl:when test="matches(normalize-space(.), '^text')">
                  <xsl:text>text</xsl:text>
                </xsl:when>
                <xsl:when test="matches(normalize-space(.), '^video')">
                  <xsl:text>moving image</xsl:text>
                </xsl:when>
              </xsl:choose>
            </resourceType>
          </xsl:for-each>
        </xsl:variable>
        <xsl:choose>
          <!-- Output values other than 'unspecified', if they're available -->
          <xsl:when test="$resourceTypes/*:resourceType[. != 'unspecified']">
            <xsl:for-each
              select="distinct-values($resourceTypes/*:resourceType[. != 'unspecified'])">
              <field name="{$fieldName}">
                <xsl:value-of select="normalize-space(.)"/>
              </field>
            </xsl:for-each>
          </xsl:when>
          <!-- Output 'unspecified' as a last resort. The items bearing this contentType should have typeOfResource corrected in the source MODS. -->
          <!--<xsl:otherwise>
            <field name="{$fieldName}">
              <xsl:text>unspecified</xsl:text>
            </field>
          </xsl:otherwise>-->
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <!-- Physical Description of related item -->
    <xsl:apply-templates select="*:physicalDescription" mode="uvaMAP"/>
    <xsl:apply-templates
      select="*:abstract | *:accessCondition | *:genre | *:identifier | *:location | *:name | *:note[not(matches(@type, '59[1-9]')) and normalize-space(.) ne ''] | *:originInfo | *:relatedItem[matches(@type, 'series')] | *:titleInfo"
      mode="uvaMAP"/>
    <xsl:apply-templates select="*:part" mode="uvaMAP"/>
  </xsl:template>

  <!-- Series -->
  <xsl:template match="*:relatedItem[matches(@type, 'series')]" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>seriesStatement</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:value-of
        select="normalize-space(string-join(*:titleInfo/*[not(matches(local-name(), 'nonSort'))], ', '))"/>
      <xsl:for-each select="*:originInfo[not(normalize-space(.) = '')]">
        <xsl:text>. </xsl:text>
        <xsl:for-each select="*:place[not(normalize-space(.) = '')]/*:placeTerm">
          <xsl:if test="position() &gt; 1">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="normalize-space(.)"/>
        </xsl:for-each>
        <xsl:text>: </xsl:text>
        <xsl:for-each select="*:dateCreated">
          <xsl:value-of select="."/>
        </xsl:for-each>
      </xsl:for-each>
      <xsl:if test="*:part[not(normalize-space(.) = '')]">
        <xsl:text>, </xsl:text>
      </xsl:if>
      <xsl:for-each select="*:part">
        <xsl:variable name="detailText">
          <xsl:for-each select="*:detail">
            <xsl:if test="position() != 1">
              <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:if test="not(normalize-space(@type) eq '')">
              <xsl:value-of select="concat(normalize-space(@type), ' ')"/>
            </xsl:if>
            <xsl:value-of select="normalize-space(string-join(*[normalize-space(.) ne ''], ' '))"/>
          </xsl:for-each>
          <xsl:if test="*:extent">
            <xsl:text>, &#32;</xsl:text>
            <xsl:for-each select="*:extent">
              <xsl:choose>
                <xsl:when test="*:start or *:end">
                  <xsl:choose>
                    <xsl:when test="matches(@unit, 'page') and *:start and *:end">pp. </xsl:when>
                    <xsl:when test="matches(@unit, 'page') and *:start">p. </xsl:when>
                  </xsl:choose>
                  <xsl:value-of select="*:start"/>
                  <xsl:if test="*:end">
                    <xsl:value-of select="concat('-', *:end)"/>
                  </xsl:if>
                </xsl:when>
                <xsl:when test="*:list">
                  <xsl:value-of select="normalize-space(*:list)"/>
                </xsl:when>
              </xsl:choose>
            </xsl:for-each>
          </xsl:if>
          <xsl:if test="*:date">
            <xsl:text>, &#32;</xsl:text>
            <xsl:value-of select="normalize-space(string-join(*:date, ' '))"/>
          </xsl:if>
        </xsl:variable>
        <xsl:value-of select="normalize-space($detailText)"/>
      </xsl:for-each>
    </field>
  </xsl:template>

  <!-- Constituent -->
  <xsl:template match="*:relatedItem[matches(@type, 'constituent')]" mode="uvaMAP">
    <field name="work_relatedWork">
      <xsl:for-each select="*:name/*[normalize-space(.) ne '']">
        <xsl:value-of select="replace(normalize-space(.), '[:,;/]+$', '')"/>
        <xsl:choose>
          <xsl:when test="position() ne last()">
            <xsl:text>, </xsl:text>
          </xsl:when>
          <xsl:otherwise>. </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
      <xsl:variable name="displayTitle">
        <xsl:for-each
          select="*:titleInfo[matches(@usage, 'primary') or not(matches(@type, 'abbreviated|alternative|translated|uniform'))][1]">
          <xsl:call-template name="makeDisplayTitle"/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="normalize-space(replace($displayTitle, '([.:,;/])\.', '$1'))"/>
    </field>
  </xsl:template>

  <!-- Referenced by -->
  <xsl:template match="*:relatedItem[matches(@type, 'isReferencedBy')]" mode="uvaMAP">
    <field name="referencedBy">
      <xsl:value-of select="string-join(descendant::text()[normalize-space(.) ne ''], ' ')"/>
    </field>
  </xsl:template>

  <!-- Other physical form -->
  <xsl:template match="*:relatedItem[matches(@type, 'otherFormat')]" mode="uvaMAP">
    <field name="addPhysicalForm">
      <xsl:choose>
        <xsl:when test="@displayLabel">
          <xsl:attribute name="displayLabel">
            <xsl:value-of select="replace(@displayLabel, '[.:,;/]+$', '')"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="@otherType">
          <xsl:attribute name="displayLabel">
            <xsl:value-of select="replace(@otherType, '[.:,;/]+$', '')"/>
          </xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <xsl:value-of select="string-join(*[normalize-space(.) ne ''], ' ')"/>
    </field>
  </xsl:template>

  <!-- Preceding/suceeding entry -->
  <xsl:template match="*:relatedItem[matches(@type, 'preceding|succeeding')]" mode="uvaMAP">
    <field name="{@type}Entry">
      <xsl:value-of select="string-join(*[normalize-space(.) ne ''], ' ')"/>
    </field>
  </xsl:template>

  <!-- Other version -->
  <xsl:template match="*:relatedItem[matches(@type, 'otherVersion')]" mode="uvaMAP">
    <field name="otherVersion">
      <xsl:value-of select="string-join(*[normalize-space(.) ne ''], ' ')"/>
    </field>
  </xsl:template>

  <!-- Related item w/o type value -->
  <xsl:template match="*:relatedItem[not(@type)]" mode="uvaMAP">
    <field name="work_relatedWork">
      <xsl:if test="@otherType">
        <xsl:attribute name="displayLabel">
          <xsl:value-of select="normalize-space(@otherType)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:for-each select="*:titleInfo">
        <xsl:value-of select="string-join(*[normalize-space(.) ne ''], ' ')"/>
      </xsl:for-each>
      <xsl:if test="*:name/*[normalize-space(.) ne '']">
        <xsl:text>. </xsl:text>
      </xsl:if>
      <xsl:for-each select="*:name/*[normalize-space(.) ne '']">
        <xsl:value-of select="replace(normalize-space(.), '[:,;/]+$', '')"/>
        <xsl:choose>
          <xsl:when test="position() ne last()">
            <xsl:text>, </xsl:text>
          </xsl:when>
          <xsl:otherwise>.</xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
      <xsl:for-each select="*:location/*:url">
        <xsl:if test="normalize-space(@note) != ''">
          <xsl:value-of
            select="concat(upper-case(substring(normalize-space(@note), 1, 1)), lower-case(substring(normalize-space(@note), 2)), ' ')"
          />
        </xsl:if>
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:for-each>
    </field>
  </xsl:template>

  <!-- Physical part of a resource -->
  <xsl:template match="*:part" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>seriesDetails</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:variable name="detailText">
        <xsl:for-each select="*:detail">
          <xsl:if test="position() != 1">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="normalize-space(string-join(*[normalize-space(.) ne ''], ' '))"/>
        </xsl:for-each>
        <xsl:if test="*:extent">
          <xsl:text>, &#32;</xsl:text>
          <xsl:for-each select="*:extent">
            <xsl:choose>
              <xsl:when test="*:start or *:end">
                <xsl:choose>
                  <xsl:when test="matches(@unit, 'page') and *:start and *:end">pp. </xsl:when>
                  <xsl:when test="matches(@unit, 'page') and *:start">p. </xsl:when>
                </xsl:choose>
                <xsl:value-of select="*:start"/>
                <xsl:if test="*:end">
                  <xsl:value-of select="concat('-', *:end)"/>
                </xsl:if>
              </xsl:when>
              <xsl:when test="*:list">
                <xsl:value-of select="normalize-space(*:list)"/>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
        </xsl:if>
        <xsl:if test="*:date">
          <xsl:text>, &#32;</xsl:text>
          <xsl:value-of select="normalize-space(string-join(*:date, ' '))"/>
        </xsl:if>
      </xsl:variable>
      <xsl:value-of select="normalize-space($detailText)"/>
    </field>
  </xsl:template>

  <!--  word, phrase, character, or group of characters that names a resource or the work contained in it -->
  <xsl:template match="*:titleInfo" mode="uvaMAP">
    <xsl:variable name="whereAmI">
      <xsl:call-template name="whereAmI"/>
    </xsl:variable>
    <field>
      <xsl:attribute name="name">
        <xsl:value-of select="concat($whereAmI, 'title')"/>
      </xsl:attribute>
      <xsl:call-template name="makeDisplayTitle"/>
    </field>
  </xsl:template>

  <!-- restrictions imposed on access to [or use of] a resource -->
  <xsl:template match="*:accessCondition" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:choose>
        <xsl:when test="matches(@type, 'use')">
          <xsl:text>useRestrict</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>accessRestrict</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:if test="@displayLabel[not(matches(., 'local|staff', 'i'))]">
        <xsl:attribute name="displayLabel">
          <xsl:value-of select="normalize-space(@displayLabel)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="normalize-space(@xlink:href) != ''">
        <xsl:attribute name="valueURI">
          <xsl:value-of select="@xlink:href"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!--  institution or repository holding the resource, or a remote location in the form
    of a URL where it is available -->
  <xsl:template match="*:location" mode="uvaMAP">
    <xsl:apply-templates
      select="*:physicalLocation[not(../*:holdingSimple/*:copyInformation/*:subLocation[matches(., 'INTERNET|WITHDRAWN', 'i')])] | *:shelfLocator | *:holdingSimple[not(*:copyInformation/*:subLocation[matches(., 'INTERNET|WITHDRAWN', 'i')])]/*:copyInformation/*:shelfLocator"
      mode="uvaMAP"/>
    <xsl:apply-templates select="*:url" mode="uvaMAP"/>
  </xsl:template>

  <!--  institution or repository that holds the resource or where it is available -->
  <xsl:template match="*:physicalLocation" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>physLocation</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <!-- Create relGroup and locGroup attributes that group data for related resources -->
      <!--<xsl:if test="matches($fieldName, '^host')">
        <xsl:attribute name="relGroup">
          <xsl:value-of select="generate-id(ancestor::*:relatedItem[@type = 'host'][1])"/>
        </xsl:attribute>
        <xsl:attribute name="locGroup">
          <xsl:value-of select="generate-id(ancestor::*:location[1])"/>
        </xsl:attribute>
      </xsl:if>-->
      <xsl:value-of select="normalize-space(.)"/>
      <xsl:for-each
        select="../*:holdingSimple/*:copyInformation/*:subLocation[not(matches(., 'INTERNET|WITHDRAWN', 'i'))]">
        <xsl:value-of select="concat(', ', normalize-space(.))"/>
      </xsl:for-each>
    </field>
  </xsl:template>

  <!-- Shelfmark or other shelving designation that indicates the location identifier for a copy -->
  <xsl:template match="*:shelfLocator" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>callNumber</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:if test="following-sibling::*:note[@type eq 'call_number_sort']">
        <xsl:attribute name="type">
          <xsl:value-of select="lower-case(following-sibling::*:note[@type eq 'call_number_sort'])"
          />
        </xsl:attribute>
      </xsl:if>
      <!-- Create relGroup and locGroup attributes that group data for related resources -->
      <!--<xsl:if test="matches($fieldName, '^host')">
        <xsl:attribute name="relGroup">
          <xsl:value-of select="generate-id(ancestor::*:relatedItem[@type = 'host'][1])"/>
        </xsl:attribute>
        <xsl:attribute name="locGroup">
          <xsl:value-of select="generate-id(ancestor::*:location[1])"/>
        </xsl:attribute>
      </xsl:if>-->
      <xsl:value-of select="normalize-space(.)"/>
    </field>
    <xsl:for-each select="../*:itemIdentifier | ../*:holdingSimple//*:itemIdentifier">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:text>itemID</xsl:text>
      </xsl:variable>
      <field name="{$fieldName}">
        <xsl:copy-of select="@type"/>
        <!-- Create relGroup and locGroup attributes that group data for related resources -->
        <!--<xsl:if test="matches($fieldName, '^host')">
          <xsl:attribute name="relGroup">
            <xsl:value-of select="generate-id(ancestor::*:relatedItem[@type = 'host'][1])"/>
          </xsl:attribute>
          <xsl:attribute name="locGroup">
            <xsl:value-of select="generate-id(ancestor::*:location[1])"/>
          </xsl:attribute>
        </xsl:if>-->
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:for-each>
  </xsl:template>

  <!-- Uniform Resource Location of the resource -->
  <xsl:template match="*:url" mode="uvaMAP">
    <xsl:variable name="fieldName">
      <xsl:call-template name="whereAmI"/>
      <xsl:text>uri</xsl:text>
    </xsl:variable>
    <field name="{$fieldName}">
      <xsl:copy-of select="@access | @usage | @displayLabel"/>
      <!-- <xsl:if test="matches($fieldName, '^host')">
        <xsl:attribute name="relGroup">
          <xsl:value-of select="generate-id(ancestor::*:relatedItem[@type = 'host'][1])"/>
        </xsl:attribute>
        <xsl:attribute name="locGroup">
          <xsl:value-of select="generate-id(ancestor::*:location[1])"/>
        </xsl:attribute>
      </xsl:if>-->
      <xsl:choose>
        <xsl:when test="not(@access) and count(../*:url) = 1 and count(../../*:url) = 1">
          <xsl:attribute name="usage">primary</xsl:attribute>
        </xsl:when>
        <xsl:when test="not(preceding::*:url)">
          <xsl:attribute name="usage">primary</xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <xsl:value-of select="normalize-space(.)"/>
    </field>
  </xsl:template>

  <!-- term that specifies the characteristics and general type of content of the resource -->
  <xsl:template match="*:typeOfResource" mode="uvaMAP">
    <xsl:if test="@collection = 'yes'">
      <xsl:variable name="fieldName">
        <xsl:call-template name="whereAmI"/>
        <xsl:text>isCollection</xsl:text>
      </xsl:variable>
      <field name="{$fieldName}">
        <!-- Create relGroup and locGroup attributes that group data for related resources -->
        <!--<xsl:if test="matches($fieldName, '^host')">
          <xsl:attribute name="relGroup">
            <xsl:value-of select="generate-id(ancestor::*:relatedItem[@type = 'host'][1])"/>
          </xsl:attribute>
        </xsl:if>-->
        <xsl:text>yes</xsl:text>
      </field>
    </xsl:if>
    <xsl:if test="@manuscript = 'yes'">
      <field name="isHandwritten">
        <xsl:if test="ancestor::*:relatedItem[@type = 'host']">
          <xsl:attribute name="relGroup">
            <xsl:value-of select="generate-id(ancestor::*:relatedItem[@type = 'host'][1])"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:text>yes</xsl:text>
      </field>
    </xsl:if>
    <xsl:if
      test="$DL_digitized = 'true' and not(ancestor-or-self::*/*:physicalDescription/*:form[matches(., 'electronic|online|remote')])">
      <field name="contentType">
        <xsl:if test="ancestor::*:relatedItem[@type = 'host']">
          <xsl:attribute name="relGroup">
            <xsl:value-of select="generate-id(ancestor::*:relatedItem[@type = 'host'][1])"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="normalize-space(.)"/>
      </field>
    </xsl:if>
    <xsl:choose>
      <!-- Already a MARC value -->
      <xsl:when
        test="matches(normalize-space(.), '^(text|cartographic|notated music|sound recording|sound recording-musical|sound recording-nonmusical|still image|moving image|three dimensional object|software, multimedia|mixed material)$')">
        <xsl:variable name="fieldName">
          <xsl:call-template name="whereAmI"/>
          <xsl:text>contentType</xsl:text>
        </xsl:variable>
        <field name="{$fieldName}">
          <!-- Create relGroup and locGroup attributes that group data for related resources -->
          <!--<xsl:if test="matches($fieldName, '^host')">
            <xsl:attribute name="relGroup">
              <xsl:value-of select="generate-id(ancestor::*:relatedItem[@type = 'host'][1])"/>
            </xsl:attribute>
          </xsl:if>-->
          <xsl:value-of select="normalize-space(.)"/>
        </field>
      </xsl:when>
      <!-- Not a MARC value, perform a lookup -->
      <xsl:otherwise>
        <xsl:variable name="resourceTypes">
          <!-- Map form and genre elements -->
          <xsl:for-each
            select=". | ancestor::*:mods/*:physicalDescription/*:form | ancestor::*:mods/*:genre">
            <xsl:variable name="thisValue">
              <xsl:value-of select="normalize-space(.)"/>
            </xsl:variable>
            <xsl:for-each select="$resourceMap//*:content[. = $thisValue]">
              <resourceType>
                <xsl:value-of select="@resourceType"/>
              </resourceType>
            </xsl:for-each>
          </xsl:for-each>
          <!-- Map internetMediaType values too -->
          <xsl:for-each
            select="ancestor::*:mods/*:physicalDescription/*:internetMediaType[matches(normalize-space(.), '^(application|audio|image|text|video|font|multipart)')]">
            <resourceType>
              <xsl:choose>
                <xsl:when test="matches(normalize-space(.), '^(application|font|multipart)')">
                  <xsl:text>software, multimedia</xsl:text>
                </xsl:when>
                <xsl:when test="matches(normalize-space(.), '^audio')">
                  <xsl:text>sound recording</xsl:text>
                </xsl:when>
                <xsl:when test="matches(normalize-space(.), '^image')">
                  <xsl:text>still image</xsl:text>
                </xsl:when>
                <xsl:when test="matches(normalize-space(.), '^text')">
                  <xsl:text>text</xsl:text>
                </xsl:when>
                <xsl:when test="matches(normalize-space(.), '^video')">
                  <xsl:text>moving image</xsl:text>
                </xsl:when>
              </xsl:choose>
            </resourceType>
          </xsl:for-each>
        </xsl:variable>
        <xsl:choose>
          <!-- Output values other than 'unspecified', if they're available -->
          <xsl:when test="$resourceTypes/*:resourceType[. != 'unspecified']">
            <xsl:for-each
              select="distinct-values($resourceTypes/*:resourceType[. != 'unspecified'])">
              <field name="contentType">
                <xsl:value-of select="normalize-space(.)"/>
              </field>
            </xsl:for-each>
          </xsl:when>
          <!-- Output 'unspecified' as a last resort. The items bearing this contentType should have typeOfResource corrected in the source MODS. -->
          <xsl:otherwise>
            <field name="contentType">
              <xsl:text>unspecified</xsl:text>
            </field>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
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