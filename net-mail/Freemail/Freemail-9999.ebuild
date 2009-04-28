# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/Freemail/Freemail-9999.ebuild,v 1.3 2009/04/28 17:26:19 tommy Exp $

EAPI="2"

ESVN_REPO_URI="http://freenet.googlecode.com/svn/trunk/apps/Freemail"
ESVN_OPTIONS="--ignore-externals"
EANT_BUILD_TARGET="dist"
inherit eutils java-pkg-2 java-ant-2 subversion

DESCRIPTION="Anonymous IMAP/SMTP e-mail server over Freenet"
HOMEPAGE="http://www.freenetproject.org/tools.html"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

CDEPEND="dev-java/bcprov
	net-p2p/freenet[freemail]"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

EANT_GENTOO_CLASSPATH="bcprov freenet"
src_prepare() {
	epatch "${FILESDIR}"/build.patch
	java-ant_rewrite-classpath
}

src_install() {
	java-pkg_dojar lib/Freemail.jar
	dodir /var/freenet/plugins
	fperms freenet:freenet /var/freenet/plugins
	dosym ../../../usr/share/Freemail/lib/Freemail.jar /var/freenet/plugins/Freemail.jar
	dodoc README || die "installation of documentation failed"
}

pkg_preinst() {
	java-pkg-2_pkg_preinst
	subversion_pkg_preinst
}

pkg_postinst () {
	#force chmod for previously existing plugins dir owned by root
	[[ $(stat --format="%U" /var/freenet/plugins) == "freenet" ]] || chown \
		freenet:freenet /var/freenet/plugins
	elog "To load Freemail, go to the plugin page of freenet and enter at"
	elog "Plugin-URL: plugins/Freemail.jar. This should load the Freemail plugin."
	elog "Set your email client to IMAP port 3143 and SMTP port 3025 on localhost."
	elog "To bind freemail to different ports, or to a different freenet node, edit"
	elog "/var/freenet/globalconfig."
}
