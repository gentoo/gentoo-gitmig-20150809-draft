# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dspam-web/dspam-web-3.8.0.ebuild,v 1.9 2007/09/25 04:41:52 mrness Exp $

inherit webapp eutils autotools

PATCHES_RELEASE_DATE="20070909"

DESCRIPTION="Web based administration and user controls for dspam"
HOMEPAGE="http://dspam.nuclearelephant.com/"
SRC_URI="http://dspam.nuclearelephant.com/sources/dspam-${PV}.tar.gz
	mirror://gentoo/dspam-${PV}-patches-${PATCHES_RELEASE_DATE}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

# These are really run-time dependencies, but we need to make sure they are installed
# before pkg_setup runs the built_with_use tests
DEPEND=">=mail-filter/dspam-${PV}
	dev-perl/GD"

RDEPEND="${DEPEND}
	dev-perl/GD-Graph3d
	dev-perl/GDGraph
	dev-perl/GDTextUtil"

# some FHS-like structure
HOMEDIR="/var/spool/dspam"
CONFDIR="/etc/mail/dspam"

S="${WORKDIR}/dspam-${PV}"

pkg_setup() {
	local use_tests_failed=false
	if built_with_use "mail-filter/dspam" user-homedirs; then
		echo
		eerror "The DSPAM web interface requires that mail-filter/dspam be installed without user-homedirs USE flag."
		eerror "Please disable this flag and re-emerge dspam."
		use_tests_failed=true
	fi
	if ! built_with_use "dev-perl/GD" png; then
		echo
		eerror "The DSPAM web interface requires that dev-perl/GD be installed with png USE flag."
		eerror "Please enable this flag and re-emerge GD."
		use_tests_failed=true
	fi
	${use_tests_failed} && die "Dependency installed with incompatible USE flags"

	webapp_pkg_setup
}

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
