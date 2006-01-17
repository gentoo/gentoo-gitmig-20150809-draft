# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libiodbc/libiodbc-3.51.2.ebuild,v 1.11 2006/01/17 02:35:22 vapier Exp $

inherit eutils

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.iodbc.org/"
SRC_URI="http://www.iodbc.org/downloads/iODBC/${P}.tar.gz"

LICENSE="LGPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="gtk"

DEPEND=">=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	gtk? ( >=x11-libs/gtk+-1.2.10 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/libiodbc-3.51.2_install_symlink.diff
}

src_compile() {
	local myconf=""
	use gtk \
		&& myconf="${myconf} --enable-gui=yes" \
		|| myconf="${myconf} --disable-gui"

	econf \
		--with-layout=gentoo \
		${myconf} || die
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README*
	#find doc/ -name "Makefile*" -exec rm '{}' \;
	#dohtml doc/*
}
