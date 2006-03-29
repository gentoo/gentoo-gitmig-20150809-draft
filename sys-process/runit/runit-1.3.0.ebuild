# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/runit/runit-1.3.0.ebuild,v 1.6 2006/03/29 00:33:02 vapier Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A UNIX init scheme with service supervision"
HOMEPAGE="http://smarden.org/runit/"
SRC_URI="http://smarden.org/runit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 ~sparc x86"
IUSE="static"

DEPEND=""

S=${WORKDIR}/admin/${P}

src_unpack() {
	unpack ${A}
	cd ${S}

	# we either build everything or nothing static
	sed -i -e 's:-static: :' src/Makefile
	use static && append-ldflags -static

	echo "$(tc-getCC) ${CFLAGS}"  > src/conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > src/conf-ld
}

src_compile() {
	cd src
	emake || die "make failed"
}

src_install() {
	dodir /var
	keepdir /etc/runit{,/runsvdir{,/default,/all}}
	dosym default /etc/runit/runsvdir/current
	dosym ../etc/runit/runsvdir/current /var/service

	cd src
	dobin chpst runsv runsvchdir runsvctrl runsvdir \
		runsvstat sv svlogd svwaitdown svwaitup || die "dobin"
	into /
	dosbin runit-init runit utmpset || die "dosbin"

	cd ${S}
	dodoc package/{CHANGES,README,THANKS}
	dohtml doc/*.html
	doman man/*

	exeinto /etc/runit/
	doexe ${FILESDIR}/{1,2,3,ctrlaltdel}
	for tty in tty1 tty2 tty3 tty4 tty5 tty6; do
		exeinto /etc/runit/runsvdir/all/getty-$tty/
		for script in run finish; do
			newexe ${FILESDIR}/$script.getty $script
			dosed "s:TTY:${tty}:g" /etc/runit/runsvdir/all/getty-$tty/$script
		done
		dosym ../all/getty-$tty /etc/runit/runsvdir/default/getty-$tty
	done
}
