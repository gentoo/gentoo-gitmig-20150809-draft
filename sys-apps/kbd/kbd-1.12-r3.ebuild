# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.12-r3.ebuild,v 1.2 2004/12/08 00:49:01 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://freshmeat.net/projects/kbd/"
SRC_URI="ftp://ftp.cwi.nl/pub/aeb/kbd/${P}.tar.gz
	ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/kbd/${P}.tar.gz
	nls? ( http://www.users.one.se/liket/svorak/svorakln.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="nls"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )"

src_unpack() {
	local a

	# Workaround problem on JFS filesystems, see bug 42859
	for a in ${A} ; do
		echo ">>> Unpacking ${a} to ${WORKDIR}"
		gzip -dc ${DISTDIR}/${a} | tar xf -
	done

	cd ${S}
	sed -i \
		-e "s:-O2:${CFLAGS}:g" \
		-e 's:install -s:install:' \
		src/Makefile.in

	# Other patches from RH
	epatch ${FILESDIR}/${PN}-1.08-terminal.patch

	# Fixes a problem where loadkeys matches dvorak the dir, and not the
	# .map inside
	epatch ${FILESDIR}/${P}-find-map-fix.patch

	# Sparc have not yet fixed struct kbd_rate to use 'period' and not 'rate'
	epatch ${FILESDIR}/${P}-kbd_repeat-v2.patch

	# misc fixes from debian
	epatch ${FILESDIR}/${P}-debian.patch

	# Provide a QWERTZ and QWERTY cz map #19010
	cp data/keymaps/i386/{qwerty,qwertz}/cz.map || die "cz qwerty"
	epatch ${FILESDIR}/${P}-cz-qwerty-map.patch
}

src_compile() {
	local myconf=
	# Non-standard configure script; --disable-nls to
	# disable NLS, nothing to enable it.
	use nls || myconf="--disable-nls"
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share \
		${myconf} || die

	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	mv ${D}/usr/bin/setfont ${D}/bin/
	dosym /bin/setfont /usr/bin/setfont

	dodoc CHANGES CREDITS README
	dodir /usr/share/doc/${PF}/html
	cp -dR doc/* ${D}/usr/share/doc/${PF}/html/

	if use nls ; then
		cd ${WORKDIR}/mnt/e/SvorakLN
		insinto /usr/share/keymaps/i386/dvorak/
		doins .svorakmap svorak.map.gz
		dodoc Svorak.txt
	fi
}
