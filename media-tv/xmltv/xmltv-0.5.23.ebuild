# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/xmltv/xmltv-0.5.23.ebuild,v 1.2 2004/01/16 17:19:38 max Exp $

inherit perl-module

DESCRIPTION="Set of utilities to manage TV listings stored in the XMLTV format."
HOMEPAGE="http://membled.com/work/apps/xmltv/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

# NOTE: you can customize the xmltv installation by
#       defining a XMLTV_OPTS variable which contains
#       a space-separated list of optional features.
#       If this variable is unspecified or has an
#       empty value, everything will be *enabled*.
#
#  none:            Don't enable any of the features below
#  tv_grab_de:      Germany and Austria listing grabbers
#  tv_grab_uk:      Britain listings grabber
#  tv_grab_uk_rt:   Alternate Britain listings grabber
#  tv_grab_it:      Italy listings grabber
#  tv_grab_na:      North America listings grabber
#  tv_grab_sn:      Sweden and Norway listings grabber
#  tv_grab_nz:      New Zealand listings grabber
#  tv_grab_fi:      Finland listings grabber
#  tv_grab_es:      Spain listings grabber
#  tv_grab_nl:      Netherlands listings grabber
#  tv_grab_nl_wolf: Alternate Netherlands listings grabber
#  tv_grab_hu:      Hungary listings grabber
#  tv_grab_dk:      Denmark listings grabber
#  tv_check:        Graphical front-end for listings data
#  tv_pick_cgi:     CGI front-end for listings data

# EXAMPLES:
# enable just North American grabber
#   XMLTV_OPTS="tv_grab_na"
#
# enable graphical front-end, New Zealand and Italy grabbers
#   XMLTV_OPTS="tv_check tv_grab_nz tv_grab_it"

DEPEND=">=sys-apps/sed-4
	>=dev-perl/libwww-perl-5.65
	>=dev-perl/XML-Twig-3.09
	dev-perl/XML-Writer
	>=dev-perl/DateManip-5.42
	dev-perl/Memoize
	>=dev-perl/Term-ProgressBar-2.03
	dev-perl/Compress-Zlib
	dev-perl/Lingua-EN-Numbers-Ordinate
	dev-perl/Lingua-Preferred
	>=dev-perl/Storable-2.04
	dev-perl/Unicode-String"

# for tv_check
DEPEND="${DEPEND} dev-perl/perl-tk dev-perl/Tk-TableMatrix dev-perl/XML-Simple"
# for tv_grab_na
DEPEND="${DEPEND} dev-perl/HTML-Parser"
# for tv_grab_sn
DEPEND="${DEPEND} >=dev-perl/HTML-TableExtract-1.08"
# for tv_grab_nz
DEPEND="${DEPEND} >=dev-lang/python-1.5.2"
# for tv_grab_fi tv_grab_es tv_grab_nl tv_grab_nl_wolf tv_grab_hu tv_grab_dk
DEPEND="${DEPEND} dev-perl/HTML-Tree"

### disabled until portage dependecy checker has notions of things
###  other then incrementals that are in /etc/make.conf
###  6/13/2003 Max Kalika <max@gentoo.org>
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_na ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} dev-perl/HTML-Parser"
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_sn ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} >=dev-perl/HTML-TableExtract-1.0.8"
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_nz ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} >=dev-lang/python-1.5.1"
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_fi ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} dev-perl/HTML-Tree"
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_es ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} dev-perl/HTML-Tree"
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_nl ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} dev-perl/HTML-Tree"
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_nl_wolf ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} dev-perl/HTML-Tree"
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_hu ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} dev-perl/HTML-Tree"
#[ -z "${XMLTV_OPTS}" -o "`has tv_grab_dk ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} dev-perl/HTML-Tree"
#[ -z "${XMLTV_OPTS}" -o "`has tv_check ${XMLTV_OPTS}`" ] \
#	&& DEPEND="${DEPEND} dev-perl/perl-tk dev-perl/Tk-TableMatrix dev-perl/XML-Simple"

make_config() {
	if [ -z "${XMLTV_OPTS}" ] ; then
		# No customization needed, build everything (default)
		echo "yes"
		return
	else
		# Need to specify custom settings, do not accept defaults
		echo "no"
	fi

	# Enable Germany and Austria (disabled currently)
	#[ "`has tv_grab_de ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Brittain
	[ "`has tv_grab_uk ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Alternate Brittain
	[ "`has tv_grab_uk_rt ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Italy
	[ "`has tv_grab_it ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable North America
	[ "`has tv_grab_na ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Sweden and Norway
	[ "`has tv_grab_sn ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable New Zealand
	[ "`has tv_grab_nz ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Finland
	[ "`has tv_grab_fi ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Spain
	[ "`has tv_grab_es ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Netherlands
	[ "`has tv_grab_nl ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Alternate Netherlands
	[ "`has tv_grab_nl_wolf ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Hungary
	[ "`has tv_grab_hu ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable Denmark
	[ "`has tv_grab_dk ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable GUI checking.
	[ "`has tv_check ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
	# Enable CGI support
	[ "`has tv_pick_cgi ${XMLTV_OPTS}`" ] && echo "yes" || echo "no"
}

src_compile() {
	make_config | perl-module_src_compile
}

src_install() {
	perl-module_src_install

	for i in `grep -rl "${D}" "${D}"` ; do
		sed -e "s:${D}::g" -i "${i}"
	done

	if [ -z "${XMLTV_OPTS}" -o "`has tv_pick_cgi ${XMLTV_OPTS}`" ] ; then
		dobin choose/tv_pick/tv_pick_cgi
		einfo
		einfo "To use tv_pick_cgi, please link it from /usr/bin/tv_pick_cgi"
		einfo "to where the ScriptAlias directive is configured."
		einfo
	fi
}

pkg_postinst() {
	ewarn "If you are upgrading from < 0.5.10 and you need to use the"
	ewarn "DE (Germany/Austria), UK or UK_RT (Britain), or IT (Italy)"
	ewarn "grabbers, please make sure you have the appropriate value"
	ewarn "specified in your XMLTV_OPTS setting because these grabbers"
	ewarn "no longer build by default."
	echo
}
