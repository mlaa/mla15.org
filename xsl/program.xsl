<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="text" indent="no"/>

    <xsl:param name="xml-dir"/>
    <xsl:param name="json-dir"/>

    <xsl:variable name="public-sessions">|219|334|376|407|537|642|643|70|129|322|406|459|641|</xsl:variable>
    <xsl:variable name="presidential-theme-sessions">|7|8|10|11|12A|14|15|16|22|26|28|31|32A|40|41|42|45|47|51|52|53|54|58|59|64|65|71|78|81|85|87|88|91|95|99|101|108|112|113|116|122|124|125|128|129|131|134|137|139|142|144|146|147|148|150|154|157|158|167|169|173|177|180|189|190|193|197|199|200|207|212|213|214|216|219|220|221|222|223|231|241|242|245|248|250|257|259|261|262|263|264|271|272|275|280|284|288|292|294|295|300|311|315|316|318|323|324|327|338|340|342|344|346|351|352|360|363|364|369|374|375|379|381|388|394|399|402|406|424|425|426|430|434|435|436|440|443|444|445|447|451|452|453|458|461|463|465|466|468|480|481|482|487|492|493|495|497|501|503|507|509|510|514|518|522|532|539|540|541|548|549|561|565|566|567|569|570|571|573|582|584|585|589|590|595|597|601|606|607|608|612|613|614|619|620|623|624|625|626|629|631|634|636|637|640|656|657|662|670|672|673|675|682|684|692|696|697|700|701|702|708|715|716|717|721|722|728|729|734|735|739|741|746|747|748|751|755|758|764|767|770|781|</xsl:variable>

    <xsl:variable name="morning">|4|5|6|7|8|9|10|11|</xsl:variable>
    <xsl:variable name="afternoon">|12|13|14|15|16|17|</xsl:variable>
    <xsl:variable name="evening">|18|19|</xsl:variable>
    <xsl:variable name="late-night">|20|21|22|23|</xsl:variable>

    <!-- Do "queries" in P_DTL_LINE always have a P_PRINT_ORD value of '95'? -->

    <xsl:variable name="date" select="current-date()"/>
    <xsl:variable name="time" select="current-time()"/>

    <xsl:variable name="year" select="substring(string($date), 1, 4)"/>
    <xsl:variable name="month-num" select="number(substring(string($date), 6, 2))"/>
    <xsl:variable name="day" select="number(substring(string($date), 9, 2))"/>

    <xsl:variable name="hour-num" select="number(substring(string($time), 1, 2))"/>
    <xsl:variable name="minutes" select="substring(string($time), 4, 2)"/>

    <xsl:variable name="month">
        <xsl:choose>
            <xsl:when test="$month-num = 12">Dec.</xsl:when>
            <xsl:when test="$month-num = 1">Jan.</xsl:when>
            <xsl:when test="$month-num = 2">Feb.</xsl:when>
            <xsl:when test="$month-num = 3">Mar.</xsl:when>
            <xsl:when test="$month-num = 4">Apr.</xsl:when>
            <xsl:when test="$month-num = 5">May</xsl:when>
            <xsl:when test="$month-num = 6">Jun.</xsl:when>
            <xsl:when test="$month-num = 7">Jul.</xsl:when>
            <xsl:when test="$month-num = 8">Aug.</xsl:when>
            <xsl:when test="$month-num = 9">Sep.</xsl:when>
            <xsl:when test="$month-num = 10">Oct.</xsl:when>
            <xsl:when test="$month-num = 11">Nov.</xsl:when>
            <xsl:otherwise>Jan.</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="hour">
        <xsl:choose>
            <xsl:when test="$hour-num = 0">12</xsl:when>
            <xsl:when test="$hour-num > 12"><xsl:value-of select="$hour-num - 12"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$hour-num"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="meridien">
        <xsl:choose>
            <xsl:when test="$hour-num > 11">p.m.</xsl:when>
            <xsl:otherwise>a.m.</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>


    <!-- Master template -->

    <xsl:template match="CONV_QUARK_XML | CONV_PROG_PARTICIPANT_XML">

        <!-- First pass (XML) -->
        <xsl:variable name="program">

            <xsl:apply-templates select="LIST_G_P_SEQ"/>

            <!-- Missing sessions -->

        </xsl:variable>

        <!-- Sort on session start time -->
        <xsl:variable name="sorted-program">
            <sessions>
                <xsl:for-each select="$program/session">
                    <xsl:sort select="concat(day/@num, substring('0', string-length(start-time/@abbrev)), start-time/@abbrev, start-time/@minutes)" order="ascending" data-type="number"/>
                    <xsl:sort select="replace(sequence, 'A$', '.5')" order="ascending" data-type="number"/>
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </sessions>
        </xsl:variable>

        <!-- Write as XML -->
        <xsl:result-document href="{$xml-dir}/program.xml" method="xml" indent="yes">
            <xsl:copy-of select="$sorted-program"/>
        </xsl:result-document>

        <!-- Second pass (JSON) -->
        <xsl:apply-templates select="$sorted-program"/>

    </xsl:template>


    <!-- First pass -->

    <xsl:template match="LIST_G_P_SEQ">
        <xsl:apply-templates select="G_P_SEQ"/>
    </xsl:template>

    <xsl:template match="G_P_SEQ">

        <session id="{P_PROG_ID}">

            <sequence>
                <xsl:choose>
                    <xsl:when test="P_SEQ and P_SEQ != ''"><xsl:value-of select="P_SEQ"/><xsl:value-of select="P_SEQ_SFX"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="P_PROG_ID"/></xsl:otherwise>
                </xsl:choose>
            </sequence>

            <title>
                <xsl:analyze-string select="translate(P_PROG_TLT, '+', '–')" regex="_([^_]+)_">
                    <xsl:matching-substring><em><xsl:value-of select="regex-group(1)"/></em></xsl:matching-substring>
                    <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
                </xsl:analyze-string>
            </title>

            <!-- UPDATE: Days of the week -->
            <xsl:choose>
                <xsl:when test="P_DAY = '08-JAN-15'">
                    <date>8 January</date>
                    <day num="1" abbrev="th" ambig="Thurs.">Thursday</day>
                </xsl:when>
                <xsl:when test="P_DAY = '09-JAN-15'">
                    <date>9 January</date>
                    <day num="2" abbrev="fr" ambig="Fri.">Friday</day>
                </xsl:when>
                <xsl:when test="P_DAY = '10-JAN-15'">
                    <date>10 January</date>
                    <day num="3" abbrev="sa" ambig="Sat.">Saturday</day>
                </xsl:when>
                <xsl:when test="P_DAY = '11-JAN-15'">
                    <date>11 January</date>
                    <day num="4" abbrev="su" ambig="Sun.">Sunday</day>
                </xsl:when>
                <xsl:otherwise>
                    <date>[Unknown]</date>
                    <day num="0" abbrev="[Unknown]" ambig="[Unknown]">[Unknown]</day>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:analyze-string select="P_TIME" regex="([0-9]{{1,2}}):([0-9]{{2}}) ?(noon|a\.m\.|p\.m\.)?(\+([0-9]{{1,2}}):([0-9]{{2}}) (noon|a\.m\.|p\.m\.))?">

                <xsl:matching-substring>

                    <xsl:variable name="start-meridien">
                        <xsl:choose>
                            <xsl:when test="regex-group(3)"><xsl:value-of select="regex-group(3)"/></xsl:when>
                            <xsl:when test="regex-group(7)"><xsl:value-of select="regex-group(7)"/></xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="end-meridien">
                        <xsl:choose>
                            <xsl:when test="regex-group(7)"><xsl:value-of select="regex-group(7)"/></xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="start-time-abbrev">
                        <xsl:choose>
                            <xsl:when test="$start-meridien = 'p.m.'"><xsl:value-of select="number(regex-group(1)) + 12"/></xsl:when>
                            <xsl:when test="$start-meridien = '[Unknown]'">[Unknown]</xsl:when>
                            <xsl:otherwise><xsl:value-of select="regex-group(1)"/></xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="end-time-abbrev">
                        <xsl:choose>
                            <xsl:when test="$end-meridien = 'p.m.'"><xsl:value-of select="number(regex-group(5)) + 12"/></xsl:when>
                            <xsl:when test="$end-meridien = '[Unknown]'">[Unknown]</xsl:when>
                            <xsl:otherwise><xsl:value-of select="regex-group(5)"/></xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="start-time-ambiguation">
                        <xsl:choose>
                            <xsl:when test="contains($morning, concat('|', $start-time-abbrev, '|'))">mor</xsl:when>
                            <xsl:when test="contains($afternoon, concat('|', $start-time-abbrev, '|'))">aft</xsl:when>
                            <xsl:when test="contains($evening, concat('|', $start-time-abbrev, '|'))">eve</xsl:when>
                            <xsl:when test="contains($late-night, concat('|', $start-time-abbrev, '|'))">ln</xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="end-time-ambiguation">
                        <xsl:choose>
                            <xsl:when test="contains($morning, concat('|', $end-time-abbrev, '|'))">mor</xsl:when>
                            <xsl:when test="contains($afternoon, concat('|', $end-time-abbrev, '|'))">aft</xsl:when>
                            <xsl:when test="contains($evening, concat('|', $end-time-abbrev, '|'))">eve</xsl:when>
                            <xsl:when test="contains($late-night, concat('|', $start-time-abbrev, '|'))">ln</xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <start-time abbrev="{$start-time-abbrev}" minutes="{regex-group(2)}" ambig="{$start-time-ambiguation}" header="{regex-group(1)}:{regex-group(2)} {$start-meridien}">
                        <xsl:value-of select="regex-group(1)"/>:<xsl:value-of select="regex-group(2)"/><xsl:text> </xsl:text><xsl:value-of select="$start-meridien"/>
                    </start-time>

                    <xsl:if test="regex-group(4)">
                        <end-time abbrev="{$end-time-abbrev}" minutes="{regex-group(6)}" ambig="{$end-time-ambiguation}">
                            <xsl:value-of select="regex-group(5)"/>:<xsl:value-of select="regex-group(6)"/><xsl:text> </xsl:text><xsl:value-of select="$end-meridien"/>
                        </end-time>
                    </xsl:if>

                </xsl:matching-substring>

                <xsl:non-matching-substring>
                    <extra-time-info>[Unknown] <xsl:value-of select="."/></extra-time-info>
                </xsl:non-matching-substring>

            </xsl:analyze-string>

            <xsl:if test="(P_HOTEL and P_HOTEL != '') or (P_OFFSITE and P_OFFSITE = 'Y')">

                <venue>

                    <!-- UPDATE: Venues -->
                    <xsl:attribute name="abbrev">
                        <xsl:choose>
                            <xsl:when test="P_HOTEL = 'VCC East'">ve</xsl:when>
                            <xsl:when test="P_HOTEL = 'VCC West'">vw</xsl:when>
                            <xsl:when test="P_OFFSITE and P_OFFSITE = 'Y'">off</xsl:when>
                            <xsl:otherwise>[Unknown]</xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>

                    <xsl:value-of select="P_HOTEL"/>

                </venue>

            </xsl:if>

            <xsl:if test="P_ROOM and P_ROOM != ''">
                <room><xsl:value-of select="P_ROOM"/></room>
            </xsl:if>

            <xsl:if test="P_SOCIAL and P_SOCIAL = 'Y'">
                <type abbrev="soc">Social</type>
            </xsl:if>

            <xsl:if test="contains($presidential-theme-sessions, concat('|', P_SEQ, P_SEQ_SFX, '|'))">
                <type abbrev="pre">Presidential Theme</type>
            </xsl:if>

            <xsl:if test="contains($public-sessions, concat('|', P_SEQ, P_SEQ_SFX, '|'))">
                <type abbrev="pub">Open to the Public</type>
            </xsl:if>

            <details>

                <line role="calendar"><xsl:value-of select="translate(P_TM_SLOT, '+', '–')"/></line>

                <xsl:if test="LIST_G_P_DTL_LINE">

                    <xsl:for-each select="LIST_G_P_DTL_LINE/G_P_DTL_LINE">

                        <xsl:sort select="P_PRINT_ORD" data-type="number" order="ascending"/>

                        <xsl:if test="P_DTL_LINE and P_DTL_LINE != '' and P_PRINT_ORD != '95'">

                            <!-- These series of RegExes impart italics and insert links around e-mail addresses and URLs. -->
                            <!-- They are "barely good enough" e-mail address / URL detectors, and they are TERRIBLE e-mail address / URL validators! -->
                            <!-- XSLT RegEx is sloooooooooooow. -->
                            <!-- UPDATE 2012-11-27: Added more Os to slow. -->

                            <xsl:variable name="sequence" select="../../P_SEQ"/>

                            <xsl:choose>

                                <xsl:when test="P_PRINT_ORD &lt;= 10 or ($sequence != '406' and $sequence != '641')">

                                    <line>

                                        <xsl:analyze-string select="translate(P_DTL_LINE, '+', '–')" regex="(https?://[^ ]+[^\. ])">
                                            <xsl:matching-substring><a href="{regex-group(1)}" target="_blank"><xsl:value-of select="regex-group(1)"/></a></xsl:matching-substring>
                                            <xsl:non-matching-substring>

                                                <xsl:analyze-string select="." regex="([0-9A-Za-z][^&lt;&gt; ]*@[0-9A-Za-z][^&lt;&gt; ]*\.[A-Za-z]{{2,9}})">
                                                    <xsl:matching-substring><a target="_blank"><xsl:attribute name="href">mailto:<xsl:value-of select="regex-group(1)"/></xsl:attribute><xsl:value-of select="regex-group(1)"/></a></xsl:matching-substring>
                                                    <xsl:non-matching-substring>

                                                          <xsl:analyze-string select="." regex="([^@ ]{{4,}}\.(com|org|net|uk|gov|edu))([ \.,;\(])">
                                                            <xsl:matching-substring><a href="http://{regex-group(1)}" target="_blank"><xsl:value-of select="regex-group(1)"/></a><xsl:value-of select="regex-group(3)"/></xsl:matching-substring>
                                                            <xsl:non-matching-substring>

                                                                  <xsl:analyze-string select="." regex="see (meetings|sessions) ([0-9]+) and ([0-9]+) and ([0-9]+)">
                                                                    <xsl:matching-substring>see <xsl:value-of select="regex-group(1)"/><xsl:text> </xsl:text><a href="#{regex-group(2)}"><xsl:value-of select="regex-group(2)"/></a>, <a href="#{regex-group(3)}"><xsl:value-of select="regex-group(3)"/></a>, and <a href="#{regex-group(4)}"><xsl:value-of select="regex-group(4)"/></a></xsl:matching-substring>
                                                                    <xsl:non-matching-substring>

                                                                        <xsl:analyze-string select="." regex="see (meetings|sessions) ([0-9]+) and ([0-9]+)">
                                                                            <xsl:matching-substring>see <xsl:value-of select="regex-group(1)"/><xsl:text> </xsl:text><a href="#{regex-group(2)}"><xsl:value-of select="regex-group(2)"/></a> and <a href="#{regex-group(3)}"><xsl:value-of select="regex-group(3)"/></a></xsl:matching-substring>
                                                                            <xsl:non-matching-substring>

                                                                                <xsl:analyze-string select="." regex="For linked sessions, see meetings *(and *)?\.">
                                                                                    <xsl:matching-substring></xsl:matching-substring>
                                                                                    <xsl:non-matching-substring>

                                                                                        <xsl:analyze-string select="." regex="Literature and Science Studies \(334\)">
                                                                                            <xsl:matching-substring><a href="#334">Literature and Science Studies</a></xsl:matching-substring>
                                                                                            <xsl:non-matching-substring>

                                                                                                <xsl:analyze-string select="." regex="the forum The Presidential Forum: Negotiating Sites of Memory \(219\)">
                                                                                                    <xsl:matching-substring><a href="#219">The Presidential Forum: Negotiating Sites of Memory</a></xsl:matching-substring>
                                                                                                    <xsl:non-matching-substring>

                                                                                                        <xsl:analyze-string select="." regex="_([^_]+)_">
                                                                                                            <xsl:matching-substring><em><xsl:value-of select="regex-group(1)"/></em></xsl:matching-substring>
                                                                                                            <xsl:non-matching-substring>

                                                                                                                <xsl:analyze-string select="." regex="@IT@([^@]+)@RO@">
                                                                                                                    <xsl:matching-substring><em><xsl:value-of select="regex-group(1)"/></em></xsl:matching-substring>
                                                                                                                    <xsl:non-matching-substring>

                                                                                                                        <xsl:analyze-string select="." regex="^  . ">
                                                                                                                            <xsl:matching-substring></xsl:matching-substring>
                                                                                                                            <xsl:non-matching-substring>
                                                                                                                                <xsl:value-of select="replace(., '--', '—')"/>
                                                                                                                            </xsl:non-matching-substring>
                                                                                                                        </xsl:analyze-string>
                                                                                                                    </xsl:non-matching-substring>
                                                                                                                </xsl:analyze-string>

                                                                                                            </xsl:non-matching-substring>
                                                                                                        </xsl:analyze-string>

                                                                                                    </xsl:non-matching-substring>
                                                                                                </xsl:analyze-string>

                                                                                            </xsl:non-matching-substring>
                                                                                        </xsl:analyze-string>

                                                                                    </xsl:non-matching-substring>
                                                                                </xsl:analyze-string>

                                                                            </xsl:non-matching-substring>
                                                                        </xsl:analyze-string>

                                                                    </xsl:non-matching-substring>
                                                                </xsl:analyze-string>

                                                            </xsl:non-matching-substring>
                                                        </xsl:analyze-string>

                                                    </xsl:non-matching-substring>
                                                </xsl:analyze-string>

                                            </xsl:non-matching-substring>
                                        </xsl:analyze-string>

                                    </line>

                                </xsl:when>

                                <!-- UPDATE: Specially formatted sessions -->
                                <xsl:when test="$sequence = '406' and position() = last()">
                                  <line>1. Welcome, Larry Grant, Musqueam Nation</line>
                                  <line>2. Report of the Executive Director, Rosemary G. Feal</line>
                                  <line>3. The Presidential Address, Margaret W. Ferguson, Univ. of California, Davis, MLA President. Ferguson will explore strategies of negotiation (involving challenge, persuasion, translation, interpretation, performance of real or feigned hope and expressing awareness of possible failure) among several contested sites of memory in today's academy. These include Vancouver itself, the humanities classroom today and in the past, and the MLA, as an organization whose members have competing memories about its mission.</line>
                                  <line>Reception immediately following.</line>
                                </xsl:when>

                                <xsl:when test="$sequence = '641' and position() = last()">
                                  <line>1. Margaret W. Ferguson will announce the newly elected honorary member and fellows.</line>
                                  <line>2. Roland Greene, Stanford Univ., MLA First Vice President, will present the William Riley Parker Prize; James Russell Lowell Prize; MLA Prize for a First Book; Mina P. Shaughnessy Prize; MLA Prize for Independent Scholars; Howard R. Marraro Prize; Katherine Singer Kovacs Prize; Aldo and Jeanne Scaglione Prize for Comparative Literary Studies; Aldo and Jeanne Scaglione Prize for French and Francophone Studies; Aldo and Jeanne Scaglione Prize for Germanic Languages and Literatures; Aldo and Jeanne Scaglione Prize for a Translation of a Literary Work; Aldo and Jeanne Scaglione Publication Award for a Manuscript in Italian Literary Studies; MLA Prize for a Bibliography, Archive, or Digital Project; William Sanders Scarborough Prize; Fenia and Yaakov Leviant Memorial Prize in Yiddish Studies; and MLA Prize in Native American Literatures, Cultures, and Languages.</line>
                                  <line>3. Rosemary G. Feal, MLA, will present the <em>MLA International Bibliography</em> Fellowship Awards.</line>
                                  <line>4. Rosemary G. Feal will announce the recipients of the seal of approval from the Committee on Scholarly Editions.</line>
                                  <line>5. Sibelan Forrester, Swarthmore Coll., ADFL President, will present the ADFL Award for Distinguished Service to the Profession to Olga Kagan, Univ. of California, Los Angeles.</line>
                                  <line>6. Remarks by Olga Kagan</line>
                                  <line>7. Dana A. Williams, Howard Univ., ADE President, will present the ADE Francis Andrew March Award to Neal Lester, Arizona State Univ.</line>
                                  <line>8. Remarks by Neal Lester</line>
                                  <line>9. Margaret W. Ferguson will present the MLA Award for Lifetime Scholarly Achievement to Rolena Adorno, Yale Univ.</line>
                                  <line>10. Remarks by Rolena Adorno</line>
                                  <line>Reception immediately following.</line>
                                </xsl:when>

                            </xsl:choose>


                        </xsl:if>

                    </xsl:for-each>

                </xsl:if>

            </details>

            <!-- Currently unused -->

            <xsl:if test="S_TYPE and S_TYPE != ''">

                <xsl:choose>
                    <xsl:when test="S_TYPE = 'Special Session'">
                        <type abbrev="sps"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Special Event'">
                        <type abbrev="spe"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'MLA Organization'">
                        <type abbrev="mla"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Allied Organization'">
                        <type abbrev="all"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Affliate Organization'">
                        <type abbrev="aff"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Affiliate Organization'">
                        <type abbrev="aff"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'American Literature Section'">
                        <type abbrev="als"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Division'">
                        <type abbrev="div"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Discussion Group'">
                        <type abbrev="dis"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Forum'">
                        <type abbrev="for"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:when test="S_TYPE = 'Forum Linked Session'">
                        <type abbrev="fls"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:when>
                    <xsl:otherwise>
                        <type abbrev="[Unknown]"><xsl:value-of select="S_TYPE"/></type>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:if>

            <xsl:if test="LIST_G_1">

                <xsl:for-each select="LIST_G_1/G_1">

                    <xsl:sort data-type="number" order="ascending">
                        <xsl:attribute name="select">
                            <xsl:choose>
                                <xsl:when test="P_ROLE = 'Session Leader or Presider'">1</xsl:when>
                                <xsl:when test="P_ROLE = 'Speaker'">2</xsl:when>
                                <xsl:when test="P_ROLE = 'Respondent or Panelist'">3</xsl:when>
                                <xsl:otherwise>4</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                    </xsl:sort>

                    <speaker>

                        <xsl:attribute name="role">
                            <xsl:choose>
                                <xsl:when test="P_ROLE = 'Session Leader or Presider'">leader</xsl:when>
                                <xsl:when test="P_ROLE = 'Speaker'">speaker</xsl:when>
                                <xsl:when test="P_ROLE = 'Respondent or Panelist'">respondent</xsl:when>
                                <xsl:otherwise>[Unknown]</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>

                        <xsl:value-of select="P_FNAME"/><xsl:text> </xsl:text><xsl:value-of select="P_LNAME"/>

                    </speaker>

                </xsl:for-each>

            </xsl:if>

        </session>

    </xsl:template>

    <xsl:template name="parse-calendar">

        <xsl:param name="str"/>

        <!-- Strip out meridiens and "noon" -->
        <xsl:variable name="str2" select="replace($str, ' noon', '')"/>
        <xsl:variable name="str3" select="replace($str2, ' a.m.', '')"/>
        <xsl:variable name="str4" select="replace($str3, ' p.m.', '')"/>

        <!-- UPDATE: Venue names -->
        <!-- Shorten venue names -->

        <xsl:value-of select="$str4"/>

    </xsl:template>


    <!-- Second pass (JSON output) -->

    <xsl:template match="sessions">

        <xsl:result-document href="{$json-dir}/program.json">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates select="session" mode="program">
                <xsl:sort select="concat(day/@num, substring('0', string-length(start-time/@abbrev)), start-time/@abbrev, start-time/@minutes)" order="ascending" data-type="number"/>
                <xsl:sort select="replace(sequence, 'A$', '.5')" order="ascending" data-type="number"/>
              </xsl:apply-templates>
            <xsl:text>]</xsl:text>
        </xsl:result-document>

        <xsl:result-document href="{$json-dir}/updated.json">
            <xsl:text>{</xsl:text>
            <xsl:text>"date":"</xsl:text><xsl:value-of select="$day"/><xsl:text> </xsl:text><xsl:value-of select="$month"/><xsl:text> </xsl:text><xsl:value-of select="$year"/><xsl:text>",</xsl:text>
            <xsl:text>"time":"</xsl:text><xsl:value-of select="$hour"/>:<xsl:value-of select="$minutes"/><xsl:text> </xsl:text><xsl:value-of select="$meridien"/><xsl:text>",</xsl:text>
            <xsl:text>"timezone":"EST"</xsl:text>
            <xsl:text>}</xsl:text>
        </xsl:result-document>

    </xsl:template>

    <xsl:template match="session" mode="program">

        <xsl:if test="position() = 1 or start-time/@header != preceding-sibling::session[1]/start-time/@header">

            <!-- Subheads for approximate session times -->
            <xsl:variable name="tod" select="concat(day, start-time/@abbrev)"/>
            <xsl:variable name="concurrent" select="self::session|following-sibling::session[concat(day, start-time/@abbrev) = $tod]"/>
            <xsl:variable name="subhead-categories">
                <xsl:text>[</xsl:text>
                <xsl:text>"</xsl:text><xsl:value-of select="day/@abbrev"/><xsl:text>",</xsl:text>
                <xsl:text>"</xsl:text><xsl:value-of select="start-time/@ambig"/><xsl:text>"</xsl:text>
                <!-- UPDATE: All filterable session classes -->
                <xsl:if test="count($concurrent[venue/@abbrev = 've']) &gt; 0">
                    <xsl:text>,"ve"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[venue/@abbrev = 'vw']) &gt; 0">
                    <xsl:text>,"vw"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[venue/@abbrev = 'eh']) &gt; 0">
                    <xsl:text>,"eh"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[venue/@abbrev = 'off']) &gt; 0">
                    <xsl:text>,"off"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[type/@abbrev = 'pub']) &gt; 0">
                    <xsl:text>,"pub"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[type/@abbrev = 'soc']) &gt; 0">
                    <xsl:text>,"soc"</xsl:text>
                </xsl:if>
                <xsl:if test="count($concurrent[type/@abbrev = 'pre']) &gt; 0">
                    <xsl:text>,"pre"</xsl:text>
                </xsl:if>
                <xsl:text>]</xsl:text>
            </xsl:variable>

            <!-- JSON output -->
            <xsl:text>{</xsl:text>
            <xsl:text>"type":"subhead",</xsl:text>
            <xsl:text>"cat":</xsl:text><xsl:value-of select="$subhead-categories"/><xsl:text>,</xsl:text>
            <xsl:text>"title":"</xsl:text><xsl:value-of select="day"/>, <xsl:value-of select="start-time/@header"/><xsl:text>"</xsl:text>
            <xsl:text>},</xsl:text>

        </xsl:if>

        <xsl:variable name="session-categories">
            <xsl:text>[</xsl:text>
            <xsl:text>"</xsl:text><xsl:value-of select="day/@abbrev"/><xsl:text>",</xsl:text>
            <xsl:text>"</xsl:text><xsl:value-of select="start-time/@ambig"/><xsl:text>",</xsl:text>
            <xsl:text>"</xsl:text><xsl:value-of select="venue/@abbrev"/><xsl:text>"</xsl:text>
            <xsl:for-each select="type">
                <xsl:text>,"</xsl:text>
                <xsl:value-of select="@abbrev"/>
                <xsl:text>"</xsl:text>
            </xsl:for-each>
            <xsl:if test="room = 'Exhibit Hall Theater'">
                <xsl:text>,"eh"</xsl:text>
            </xsl:if>
            <xsl:text>]</xsl:text>
        </xsl:variable>

        <!-- JSON output -->
        <xsl:text>{</xsl:text>
        <xsl:text>"id":"</xsl:text><xsl:value-of select="sequence"/><xsl:text>",</xsl:text>
        <xsl:text>"oid":"</xsl:text><xsl:value-of select="@id"/><xsl:text>",</xsl:text>
        <xsl:text>"cat":</xsl:text><xsl:value-of select="$session-categories"/><xsl:text>,</xsl:text>
        <xsl:text>"title":"</xsl:text><xsl:apply-templates select="title/node()"/><xsl:text>",</xsl:text>
        <xsl:text>"loc":"</xsl:text><xsl:call-template name="parse-calendar"><xsl:with-param name="str" select="details/line[@role = 'calendar'][1]/node()"/></xsl:call-template><xsl:text>",</xsl:text>
        <xsl:text>"cal":"</xsl:text><xsl:value-of select="day"/>, <xsl:apply-templates select="details/line[@role = 'calendar'][1]/node()"/><xsl:text>",</xsl:text>
        <xsl:text>"text":[</xsl:text>
        <xsl:for-each select="details/line">
            <xsl:if test="not(@role) or @role != 'calendar'">
                <xsl:text>"</xsl:text><xsl:apply-templates select="node()"/><xsl:text>"</xsl:text>
                <xsl:if test="position() != last()">,</xsl:if>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>]}</xsl:text>
        <xsl:if test="position() != last()">,</xsl:if>

    </xsl:template>

    <xsl:template match="*">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:for-each select="@*">
            <xsl:text> </xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>=\&quot;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>\&quot;</xsl:text>
        </xsl:for-each>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates select="* | text()"/>
        <xsl:text>&lt;/</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="text()">

        <xsl:analyze-string select="." regex="\s+">
            <xsl:matching-substring><xsl:text> </xsl:text></xsl:matching-substring>
            <xsl:non-matching-substring><xsl:value-of select="replace(., '&quot;', '\\&quot;')"/></xsl:non-matching-substring>
        </xsl:analyze-string>

    </xsl:template>

</xsl:stylesheet>
