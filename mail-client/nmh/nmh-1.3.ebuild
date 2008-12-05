# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/nmh/nmh-1.3.ebuild,v 1.1 2008/12/05 01:51:31 darkside Exp $

inherit eutils
DESCRIPTION="New MH mail reader"
SRC_URI="http://savannah.nongnu.org/download/nmh/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/nmh/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	|| ( sys-libs/gdbm =sys-libs/db-1.85* )
	>=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patches from bug #22173.
	epatch "${FILESDIR}"/${P}-inc-login.patch
	epatch "${FILESDIR}"/${P}-install.patch
	# bug #57886
	epatch "${FILESDIR}"/${P}-m_getfld.patch
}

src_compile() {
	[ -z "${EDITOR}" ] && export EDITOR="prompter"
	[ -z "${PAGER}" ] && export PAGER="/usr/bin/more"

	# Redefining libdir to be bindir so the support binaries get installed
	# correctly.  Since no libraries are installed with nmh, this does not
	# pose a problem at this time.
	econf \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--with-editor=${EDITOR} \
		--with-pager=${PAGER} \
		--enable-nmh-pop \
		--sysconfdir=/etc/nmh \
		--libdir=/usr/bin \
		|| die
	emake -j1 || die
}

src_install() {
	emake -j1 prefix="${D}"/usr \
		mandir="${D}"/usr/share/man \
		libdir="${D}"/usr/bin \
		etcdir="${D}"/etc/nmh install || die
	dodoc ChangeLog DATE MACHINES README 
}
