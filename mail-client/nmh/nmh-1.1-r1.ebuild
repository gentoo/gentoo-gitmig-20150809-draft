# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/nmh/nmh-1.1-r1.ebuild,v 1.6 2008/12/09 03:53:43 darkside Exp $

inherit eutils
DESCRIPTION="New MH mail reader"
SRC_URI="http://savannah.nongnu.org/download/nmh/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/nmh/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

DEPEND="virtual/libc
	=sys-libs/db-1.85*
	>=sys-libs/ncurses-5.2"

S=${WORKDIR}/${PN}

src_compile() {

	[ -z "${EDITOR}" ] && export EDITOR="prompter"
	[ -z "${PAGER}" ] && export PAGER="/usr/bin/more"

	# Patches from bug #22173.
	epatch ${FILESDIR}/${P}-inc-login.patch || die "epatch failed"
	epatch ${FILESDIR}/${P}-install.patch || die "epatch failed"
	# vi test access violation patch
	epatch ${FILESDIR}/${P}-configure-vitest.patch || die "epatch failed"
	# bug #57886
	epatch ${FILESDIR}/${P}-m_getfld.patch || die "epatch failed"
	# bug #69688
	epatch ${FILESDIR}/${P}-annotate-fix.patch || die "epatch failed"

	# Redifining libdir to be bindir so the support binaries get installed
	# correctly.  Since no libraries are installed with nmh, this does not
	# pose a problem at this time.
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--with-editor=${EDITOR} \
		--with-pager=${PAGER} \
		--enable-nmh-pop \
		--with-locking=lockf \
		--sysconfdir=/etc/nmh \
		--libdir=/usr/bin || die
	make || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/bin \
		etcdir=${D}/etc/nmh install || die
	dodoc COMPLETION-TCSH COMPLETION-ZSH TODO FAQ DIFFERENCES \
		MAIL.FILTERING Changelog* COPYRIGHT
}
