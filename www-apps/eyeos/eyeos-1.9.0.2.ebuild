# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/eyeos/eyeos-1.9.0.2.ebuild,v 1.1 2011/01/03 13:14:12 voyageur Exp $

inherit depend.php versionator webapp eutils

DESCRIPTION="AJAX web-based desktop environment"
HOMEPAGE="http://www.eyeos.org"
if [[ $(get_version_component_count) < 5 ]]; then
	SRC_URI="mirror://sourceforge/eyeos/eyeOS_$(get_version_component_range 1-4).zip"
else
	SRC_URI="mirror://sourceforge/eyeos/eyeOS_$(get_version_component_range 1-4)-$(get_version_component_range 5).zip"
fi

LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

need_httpd_cgi
need_php_httpd

S=${WORKDIR}/eyeOS

src_install () {
	webapp_src_preinst

	dodoc README.txt
	rm -f README.txt

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	#TODO: needs "." too
	for file in index.html package.eyepackage installer installer/index.php installer/files/index.txt installer/files/settings.txt; do
			webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
