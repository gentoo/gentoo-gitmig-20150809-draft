# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xmltv/xmltv-0.5.43-r4.ebuild,v 1.7 2006/07/01 16:27:47 mcummings Exp $

inherit eutils perl-module

DESCRIPTION="Set of utilities to manage TV listings stored in the XMLTV format."
HOMEPAGE="http://membled.com/work/apps/xmltv/"
SRC_URI="mirror://sourceforge/xmltv//${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
PREFIX="/usr"

# NOTE: you can customize the xmltv installation by
#       defining USE FLAGS (custom ones in 
#	/etc/portage/package.use for example).
#
#	Do "equery u media-tv/xmltv" for the complete
#	list of the flags you can set, with description.

# EXAMPLES:
# enable just North American grabber
#  in /etc/portage/package.use : media-tv/xmltv na_dd
#
# enable graphical front-end, Italy grabber
#  in /etc/portage/package.use : media-tv/xmltv tv_check it

IUSE="be br brnet ch uk_rt uk_bleb is it na_dd na_icons fi es ee il re nl nl_wolf huro dk jp de_tvtoday se_swedb fr no pt za tv_pick_cgi tv_check"

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
	>=dev-perl/Class-MethodMaker-2
	>=dev-lang/perl-5.6.1"

DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.50-r1
	na_dd? ( dev-perl/HTML-TableExtract >=dev-perl/WWW-Mechanize-1.02 )
	de_tvtoday? ( >=dev-perl/HTML-Parser-3.34 dev-perl/HTML-Tree )
	dk? ( dev-perl/HTML-Tree )
	es? ( dev-perl/HTML-Tree )
	fi? ( dev-perl/HTML-Tree )
	fr? ( >=dev-perl/HTML-Parser-3.34 dev-perl/HTML-Tree )
	huro? ( dev-perl/HTML-Tree )
	jp? ( dev-perl/HTML-Tree dev-perl/Text-Kakasi )
	na_dd? ( dev-perl/SOAP-Lite dev-perl/TermReadKey )
	nl? ( dev-perl/HTML-Tree )
	nl_wolf? ( dev-perl/HTML-Tree )
	no? ( >=dev-perl/HTML-Parser-3.34 dev-perl/HTML-TableExtract dev-perl/HTML-LinkExtractor )
	pt? ( dev-perl/HTML-Tree dev-perl/Unicode-UTF8simple )
	se? ( dev-perl/XML-LibXML )
	se_swedb? ( dev-perl/HTTP-Cache-Transparent )
	uk_bleb? ( dev-perl/Archive-Zip dev-perl/IO-stringy )
	tv_check? ( dev-perl/perl-tk dev-perl/Tk-TableMatrix )
	tv_pick_cgi? ( perl-core/CGI )
	"

make_config() {
	# Never except default configuration
	echo "no"

	# Enable Australian
	#use au && echo "yes" || echo "no"
	# Enable Brazil
	use br && echo "yes" || echo "no"
	# Enable Brazil Cable
	use brnet && echo "yes" || echo "no"
	# Enable Switzerland
	use ch && echo "yes" || echo "no"
	# Enable Alternate Brittain
	use uk_rt && echo "yes" || echo "no"
	# Enable Alternate Brittain 2
	use uk_bleb && echo "yes" || echo "no"
	# Enable Belgium and Luxemburg 
	use be && echo "yes" || echo "no"
	#Enable Iceland
	use is && echo "yes" || echo "no"
	# Enable Italy
	use it && echo "yes" || echo "no"
	# Enable North America using DataDirect
	use na_dd && echo "yes" || echo "no"
	# Enable North America channel icons
	use na_icons  && echo "yes" || echo "no"
	# Enable Finland
	use fi  && echo "yes" || echo "no"
	# Enable Spain
	use es  && echo "yes" || echo "no"
	# Enable Spain Digital
	# use es_digital && echo "yes" || echo "no"
	# Enable Israel
	use il && echo "yes" || echo "no"
	# Enable Netherlands
	use nl  && echo "yes" || echo "no"
	# Enable Alternate Netherlands
	use nl_wolf  && echo "yes" || echo "no"
	# Enable Hungary and Romania
	use huro  && echo "yes" || echo "no"
	# Enable Denmark
	use dk && echo "yes" || echo "no"
	# Enable Japan
	use jp  && echo "yes" || echo "no"
	# Enable Germany
	use de_tvtoday && echo "yes" || echo "no"
	# Enable Sweden
	#use se  && echo "yes" || echo "no"
	# Enable Sweden 2
	use se_swedb  && echo "yes" || echo "no"
	# Enable France
	use fr  && echo "yes" || echo "no"
	# Enable Norway
	use no  && echo "yes" || echo "no"
	# Enable Portugal
	use pt  && echo "yes" || echo "no"
	# Enable South Africa
	use za  && echo "yes" || echo "no"
	# Enable GUI checking.
	use tv_check && echo "yes" || echo "no"
	# Enable CGI support
	use tv_pick_cgi && echo "yes" || echo "no"
	# Enable Estonia
	use ee && echo "yes" || echo "no"
	#Enable Reunion Island
	use re && echo "yes" || echo "no"
}

src_unpack() {
	unpack "${A}"

	cd "${S}"
	epatch "${FILESDIR}/tv_grab_de_tvtoday-0.5.43.diff"
}

src_compile() {
	sed -i "s:\$VERSION = '${PV}':\$VERSION = '${PVR}':" Makefile.PL || die
	make_config | perl-module_src_compile || die "error compiling"
}

src_install() {
	# actually make test should be unneede, but if non na grabbers
	# start to not install remove comment below
	# make test
	#make
	#make DESTDIR=${D} install
	perl-module_src_install || die "error installing"

	for i in `grep -rl "${D}" "${D}"` ; do
		sed -e "s:${D}::g" -i "${i}"
	done

	if use tv_pick_cgi ; then
		dobin choose/tv_pick/tv_pick_cgi || die "error creating tv_pick_cgi"
	fi
}

pkg_postinst() {
	if use tv_pick_cgi ; then
		einfo "To use tv_pick_cgi, please link it from /usr/bin/tv_pick_cgi"
		einfo "to where the ScriptAlias directive is configured."
	fi
}

