# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/scponly/scponly-4.3.ebuild,v 1.1 2005/12/28 09:56:33 kloeri Exp $

inherit eutils

DESCRIPTION="A tiny pseudoshell which only permits scp and sftp"
HOMEPAGE="http://www.sublimation.org/scponly/"
SRC_URI="http://www.sublimation.org/scponly/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="virtual/libc
	net-misc/openssh"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-getopt.patch
}

src_compile() {
	PATH="${PATH}:/usr/$(get_libdir)/misc" \
	econf \
		--enable-scp-compat \
		--enable-rsync-compat \
		--enable-chrooted-binary \
		|| die "./configure failed"
#		--enable-svn-compat\ # subversion SCS cli compatibility
#		--enable-svnserv-compat\ # subversion SCS svnserve compatibility
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHOR BUILDING-JAILS.TXT CHANGELOG CONTRIB README TODO
	dodoc setup_chroot.sh
}

pkg_postinst() {
	einfo "Setting up chroot in pkg_postinst was removed. Please setup manually."
}
