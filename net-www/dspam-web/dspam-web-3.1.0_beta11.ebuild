# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dspam-web/dspam-web-3.1.0_beta11.ebuild,v 1.2 2004/07/22 21:05:10 dholm Exp $

inherit webapp

MY_PN=${PN/-web/}
MY_PV=${PV/_beta11/.beta.1.1}
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="Web based administration and user controls for dspam"
SRC_URI="http://www.nuclearelephant.com/projects/dspam/sources/${MY_P}.tar.gz"

HOMEPAGE="http://www.nuclearelephant.com/projects/dspam/index.html"
LICENSE="GPL-2"
DEPEND=">=mail-filter/dspam-3.1.0_beta11
	>=net-www/apache-1.3
	>=dev-lang/perl-5.8.2
	>=dev-perl/GD-2.0
	dev-perl/GD-Graph3d
	dev-perl/GDGraph
	dev-perl/GDTextUtil"
KEYWORDS="~x86 ~ppc"
S=${WORKDIR}/${MY_P}/cgi

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	webapp_src_preinst

	sed -e 's,/var/dspam,/etc/mail/dspam,' \
		-e 's,/usr/local,/usr,' \
		-i ${S}/admin.cgi
	sed -e 's,/var/dspam,/etc/mail/dspam,' \
		-e 's,/usr/local,/usr,' \
		-i ${S}/dspam.cgi

	insinto ${MY_HTDOCSDIR}
	insopts -m644 -o apache -g apache

	doins *.css
	doins *.gif
	doins rgb.txt
	doins default.prefs
	doins admins

	newins ${FILESDIR}/htaccess .htaccess
	newins ${FILESDIR}/htpasswd .htpasswd

	insopts -m755 -o apache -g apache
	doins *.cgi

	for CGI_SCRIPT in admin.cgi  admingraph.cgi  dspam.cgi  graph.cgi; do
		webapp_runbycgibin perl ${MY_HTDOCSDIR}/${CGI_SCRIPT}
	done

	dodir ${MY_HTDOCSDIR}/templates

	insinto ${MY_HTDOCSDIR}/templates
	doins templates/*.html

	#All files must be owned by server
	cd ${D}${MY_HTDOCSDIR}
	for x in `find . -type f -print` ; do
		webapp_serverowned ${MY_HTDOCSDIR}/$x
	done

	webapp_src_install
}

pkg_config () {
	# add apache to the dspam group so the CGIs can access the data

	local groups
	groups=`groups apache`
	groups=`echo ${groups} | sed -e 's/ /,/g'`
	usermod -G "${groups},dspam" apache
}

pkg_postinst () {
	einfo "The CGIs need to be executed as group dspam in order to write"
	einfo "to the dspam data directory. You will need to configure apache"
	einfo "manually to do this. Another option is to add the user apache"
	einfo "to the dspam group. You can do this automatically by running:"
	echo
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	echo
	einfo "This app requires basic auth in order to operate properly."
	einfo "You will need to add dspam users to the .htpasswd file or"
	einfo "configure a different authentication mechanism for the user"
	einfo "accounts."
}
