# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dspam-web/dspam-web-3.6.8-r1.ebuild,v 1.3 2007/04/03 18:09:21 gustavoz Exp $

inherit webapp eutils autotools

DESCRIPTION="Web based administration and user controls for dspam"
HOMEPAGE="http://dspam.nuclearelephant.com/"
SRC_URI="http://dspam.nuclearelephant.com/sources/dspam-${PV}.tar.gz
	mirror://gentoo/dspam-${PV}-patches-20061219.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

DEPEND=">=mail-filter/dspam-${PV}"
RDEPEND="${DEPEND}
	>=dev-perl/GD-2.0
	dev-perl/GD-Graph3d
	dev-perl/GDGraph
	dev-perl/GDTextUtil"

# some FHS-like structure
HOMEDIR="/var/spool/dspam"
CONFDIR="/etc/mail/dspam"

S="${WORKDIR}/dspam-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch"
	epatch "${WORKDIR}"/patches

	AT_M4DIR="${S}/m4"
	eautoreconf
}

src_compile() {
	econf \
			--with-dspam-home=${HOMEDIR} \
			--sysconfdir=${CONFDIR}  || die "econf failed"
	cd "${S}/webui"
	emake || die "emake failed"
}

src_install() {
	webapp_src_preinst

	cd "${S}/webui"
	insinto "${MY_HTDOCSDIR}"
	insopts -m644
	doins htdocs/*.{css,gif}
	insinto "${MY_CGIBINDIR}/templates"
	doins cgi-bin/templates/*.html
	insinto "${MY_CGIBINDIR}"
	doins cgi-bin/{admins,configure.pl,default.prefs,rgb.txt,*.cgi}

	webapp_configfile "${MY_CGIBINDIR}"/{admins,configure.pl,default.prefs,rgb.txt}

	webapp_hook_script "${FILESDIR}/setperms"
	webapp_postinst_txt en "${FILESDIR}/postinst-en.txt"

	webapp_src_install
}

pkg_postinst() {
	ewarn "If you're using apache dspam-web's config requires the scripts in the cgi-bin"
	ewarn "to be run as dspam:dspam. You will have to put a global SuexecUserGroup"
	ewarn "declaration in the main server config which will force everything in cgi-bin"
	ewarn "to run as dspam:dspam."
	ewarn "You should use a dedicated virtual host for this application or at least"
	ewarn "one that don't have any other cgi scripts."
	echo
	webapp_pkg_postinst
}
