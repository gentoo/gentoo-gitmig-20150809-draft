# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.28-r1.ebuild,v 1.3 2002/07/17 20:44:57 drobbins Exp $

MY_P=${P/4./4b}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
SRC_URI="http://download.sourceforge.net/dump/${MY_P}.tar.gz"
SLOT="0"
HOMEPAGE="http://dump.sourceforge.net"

DEPEND=">=sys-apps/e2fsprogs-1.27
	>=sys-apps/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4
	>=sys-kernel/linux-headers-2.4.10
	readline? ( sys-libs/readline )"

RDEPEND="sys-apps/star"

LICENSE="BSD"
SLOT="0"

src_unpack() {

	unpack ${A}
	cd ${S}
	use readline && ( \
		for i in configure configure.in
		do
			cp ${i} ${i}.orig
			sed "s:-ltermcap:-lncurses:g" \
				${i}.orig > ${i}
		done
	)
}

src_compile() {
	
	local myconf

	use readline \
		&& myconf="--enable-readline" \
		|| myconf="--disable-readline"

	use static \
		&& myconf="${myconf} --snable-static" \
		|| myconf="${myconf} --enable-shared"

	econf \
		--with-dumpdatespath=/etc/dumpdates \
		--with-binowner=root \
		--with-bingroup=root \
		--enable-largefile \
		${myconf} || die

	emake || die
}
src_install () {
#	into /
#	dosbin dump/dump restore/restore
#	doman restore/restore.8
#	doman dump/dump.8
	einstall \
		MANDIR=${D}/usr/share/man/man8 || die
	dodoc CHANGES COPYRIGHT INSTALL KNOWNBUGS MAINTAINERS README \
		REPORTING-BUGS THANKS TODO
	dodoc -r examples/dump_on_cd
}
