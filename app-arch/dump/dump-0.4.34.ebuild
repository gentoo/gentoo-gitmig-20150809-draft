# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.34.ebuild,v 1.13 2004/03/21 01:57:21 jhuebel Exp $

MY_P=${P/4./4b}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
SRC_URI="mirror://sourceforge/dump/${MY_P}.tar.gz"
HOMEPAGE="http://dump.sourceforge.net"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc sparc ia64 ~alpha ~amd64"
IUSE="readline static"

DEPEND=">=sys-fs/e2fsprogs-1.27
	>=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4
	virtual/os-headers
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}
	|| (
		app-arch/star
		app-arch/tar
	)"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ `use readline` ] ; then
		for i in configure.in configure
		do
			sed -i "s:-ltermcap:-lncurses:g" \
				${i}
		done
	fi
}

src_compile() {
	local myconf=""
	use static \
		&& myconf="${myconf} --enable-static" \
		|| myconf="${myconf} --enable-shared"

	econf \
		--with-dumpdatespath=/etc/dumpdates \
		--with-binowner=root \
		--with-bingroup=root \
		--enable-largefile \
		`use_enable readline` \
		${myconf} || die

	emake || die
}

src_install() {
	einstall MANDIR=${D}/usr/share/man/man8 || die

	dodoc CHANGES COPYRIGHT KNOWNBUGS MAINTAINERS README \
		REPORTING-BUGS THANKS TODO
	dodoc -r examples/dump_on_cd
}
