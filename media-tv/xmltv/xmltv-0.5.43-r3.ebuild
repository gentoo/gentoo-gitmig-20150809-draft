# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xmltv/xmltv-0.5.43-r3.ebuild,v 1.1 2006/06/01 10:05:53 mattepiu Exp $

inherit eutils perl-module

DESCRIPTION="Set of utilities to manage TV listings stored in the XMLTV format."
HOMEPAGE="http://membled.com/work/apps/xmltv/"
SRC_URI="mirror://sourceforge/xmltv//${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
PREFIX="/usr"

# NOTE: you can customize the xmltv installation by
#       defining a XMLTV_OPTS variable which contains
#       a space-separated list of optional features.
#       If this variable is unspecified or has an
#       empty value, everything will be *enabled*.
#
#  tv_grab_huro        Alternate Hungarian and Romania grabber
#  tv_grab_uk_rt:      Alternate Britain listings grabber
#  tv_grab_uk_bleb:    Fast alternative grabber for the UK
#  tv_grab_it:         Italy listings grabber
#  tv_grab_it_lt:      Alternative grabber for Italy
#  tv_grab_na_icons:   Downloads icons from Zap2IT
#  tv_grab_na_dd:      Alternate American listings grabber
#  tv_grab_nz:         New Zealand listings grabber
#  tv_grab_fi:         Finland listings grabber
#  tv_grab_es:         Spain listings grabber
#  tv_grab_es_digital: Spain digital satellite listings grabber
#  tv_grab_nl:         Netherlands listings grabber
#  tv_grab_nl_wolf:    Alternate Netherlands listings grabber
#  tv_grab_dk:         Denmark listings grabber
#  tv_grab_jp:         Japan listings grabber
#  tv_grab_de_tvtoday: Germany listings grabber
#  tv_grab_se:         Sweden listings grabber
#  tv_grab_se_swedb:   New grabber for Sweden
#  tv_grab_fr:         France listings grabber
#  tv_check:           Graphical front-end for listings data
#  tv_pick_cgi:        CGI front-end for listings data

# EXAMPLES:
# enable just North American grabber
#   XMLTV_OPTS="tv_grab_na"
#
# enable graphical front-end, Italy grabber
#   XMLTV_OPTS="tv_check tv_grab_it"


RDEPEND=">=dev-perl/libwww-perl-5.65
	>=dev-perl/XML-Parser-2.34
	>=dev-perl/XML-Twig-3.10
	>=dev-perl/DateManip-5.42
	>=dev-perl/XML-Writer-0.4.6
		|| ( >=dev-lang/perl-5.8.7 perl-core/Memoize )
		|| ( >=dev-lang/perl-5.8.8 perl-core/Storable )
	dev-perl/Lingua-EN-Numbers-Ordinate
	>=dev-perl/Lingua-Preferred-0.2.4
	>=dev-perl/Term-ProgressBar-2.03
	dev-perl/Compress-Zlib
	dev-perl/Unicode-String
	dev-perl/TermReadKey
	>=dev-lang/perl-5.6.1"

DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.50-r1
	>=sys-apps/sed-4
	"

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_uk_rt ${XMLTV_OPTS} ; then
	newdepend \>=dev-perl/HTML-Parser-3.34
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_bleb ${XMLTV_OPTS} ; then
	newdepend dev-perl/Archive-Zip dev-perl/IO-stringy
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_na_dd ${XMLTV_OPTS} ; then
	newdepend dev-perl/SOAP-Lite dev-perl/TermReadKey
	newdepend \<dev-perl/Class-MethodMaker-2
else
	newdepend \>=dev-perl/Class-MethodMaker-2
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_na_icons ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-TableExtract \>=dev-perl/WWW-Mechanize-1.02
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_fi ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-Tree
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_es ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-Tree
fi

#if [ -z "${XMLTV_OPTS}" ] || has tv_grab_es_digital ${XMLTV_OPTS} ; then
#	newdepend dev-perl/HTML-Tree
#fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_nl ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-Tree
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_nl_wolf ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-Tree
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_huro ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-Tree
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_dk ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-Tree
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_jp ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-Tree dev-perl/Text-Kakasi
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_de_tvtoday ${XMLTV_OPTS} ; then
	newdepend \>=dev-perl/HTML-Parser-3.34 dev-perl/HTML-Tree
fi

#if [ -z "${XMLTV_OPTS}" ] || has tv_grab_se ${XMLTV_OPTS} ; then
#	newdepend dev-perl/XML-LibXML
#fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_se_swedb ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTTP-Cache-Transparent
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_fr ${XMLTV_OPTS} ; then
	newdepend \>=dev-perl/HTML-Parser-3.34 dev-perl/HTML-Tree
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_no ${XMLTV_OPTS} ; then
	newdepend \>=dev-perl/HTML-Parser-3.34 dev-perl/HTML-TableExtract dev-perl/HTML-LinkExtractor
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_pt ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTML-Tree
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_check ${XMLTV_OPTS} ; then
	newdepend dev-perl/perl-tk dev-perl/Tk-TableMatrix
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_pick_cgi ${XMLTV_OPTS} ; then
	newdepend virtual/perl-CGI
fi

if [ -z "${XMLTV_OPTS}" ] || has tv_grab_se_swedb ${XMLTV_OPTS} ; then
	newdepend dev-perl/HTTP-Cache-Transparent
fi


make_config() {
	if [ -z "${XMLTV_OPTS}" ] ; then
	# No customization needed, build everything (default)
		echo "yes"
	return
	else
		# Need to specify custom settings, do not accept defaults
		echo "no"
	fi

	# Enable Australian
	#has tv_grab_au ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Brazil
	has tv_grab_br ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Brazil Cable
	has tv_grab_brnet ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Switzerland
	has tv_grab_ch ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Alternate Brittain
	has tv_grab_uk_rt ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Alternate Brittain 2
	has tv_grab_bleb ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Belgium and Luxemburg 
	has tv_grab_uk_be ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	#Enable Iceland
	has tv_grab_is ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Italy
	has tv_grab_it ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable North America using DataDirect
	has tv_grab_na_dd ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable North America channel icons
	has tv_grab_na_icons  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Finland
	has tv_grab_fi  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Spain
	has tv_grab_es  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Spain Digital
	# has tv_grab_es_digital ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Israel
	has tv_grab_il ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Netherlands
	has tv_grab_nl  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Alternate Netherlands
	has tv_grab_nl_wolf  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Hungary and Romania
	has tv_grab_huro  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Denmark
	has tv_grab_dk ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Japan
	has tv_grab_jp  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Germany
	has tv_grab_de_tvtoday ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Sweden
	#has tv_grab_se  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Sweden 2
	has tv_grab_se_swedb  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable France
	has tv_grab_fr  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Norway
	has tv_grab_no  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Portugal
	has tv_grab_pt  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable South Africa
	has tv_grab_za  ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable GUI checking.
	has tv_check ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable CGI support
	has tv_pick_cgi ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	# Enable Estonia
	has tv_grab_ee ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
	#Enable Reunion Island
	has tv_grab_re ${XMLTV_OPTS}      >&/dev/null && echo "yes" || echo "no"
}

src_unpack() {
	unpack "${A}"

	cd "${S}"
	epatch "${FILESDIR}/tv_grab_de_tvtoday-0.5.43.diff"
}

src_compile() {
	sed -i "s:\$VERSION = '${PV}':\$VERSION = '${PVR}':" Makefile.PL || die
	make_config | perl Makefile.PL PREFIX=/usr
}

src_install() {
	make
	make test
	make DESTDIR=${D} install
#perl-module_src_install

	for i in `grep -rl "${D}" "${D}"` ; do
		sed -e "s:${D}::g" -i "${i}"
	done

	if [ -z "${XMLTV_OPTS}" ] || has tv_pick_cgi ${XMLTV_OPTS} ; then
		dobin choose/tv_pick/tv_pick_cgi
	fi
}

pkg_postinst() {
	if [ -z "${XMLTV_OPTS}" ] || has tv_pick_cgi ${XMLTV_OPTS} ; then
		einfo "To use tv_pick_cgi, please link it from /usr/bin/tv_pick_cgi"
		einfo "to where the ScriptAlias directive is configured."
	fi
}

