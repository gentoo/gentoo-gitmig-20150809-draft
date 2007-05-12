# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/toshiba-utils/toshiba-utils-2.0.1-r2.ebuild,v 1.5 2007/05/12 13:32:08 armin76 Exp $

inherit eutils autotools

S=${WORKDIR}/toshutils-${PV}
DESCRIPTION="Toshiba Laptop Utilities"
HOMEPAGE="http://www.buzzard.org.uk/toshiba/"
SRC_URI="http://www.buzzard.org.uk/toshiba/downloads/toshutils-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-ppc x86"
IUSE="gtk X"

DEPEND="gtk? ( =x11-libs/gtk+-1* )
	X? ( x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i -e "s:asm/io.h:sys/io.h:" src/hotkey.c

	rm -f config.{cache,log,status} src/*.o

	sed -i -e "s:-m486 -O2::" \
		-e "s:\(^CFLAGS =.*\):\1 ${CFLAGS}:" \
		-e "s:^install\:.*:install\: all install-prog:" \
		-e "s:-fwritable-strings::g" \
		src/Makefile.in \
		|| die "sed failed"
	epatch ${FILESDIR}/${P}-arg-fix.diff
	use gtk || epatch ${FILESDIR}/${P}-gentoo.diff
	eautoconf || die "autoconf failed"
}

src_compile() {
	econf \
		$(use_with X x) \
		|| die "econf failed"
	make depend || die "make depend failed"
	make -C src || die "make src failed"
}

src_install() {
	dodir /usr/bin
	make -C src DESTDIR=${D} install || die "make install failed"

	dodoc README* TODO CONTRIBUTE FAQ ChangeLog
	doman doc/*.{1x,1,8}
	docinto pdf ; dodoc doc/*.pdf

	insinto /etc/modules.d
	newins ${FILESDIR}/toshiba-modules.d toshiba
}

pkg_postinst() {
	ewarn "Dont forget Toshiba Laptop Support for your kernel."
	ewarn "(under Processor Type and Features, CONFIG_TOSHIBA)"
	if [[ ${ROOT} == / ]] ; then
		[[ -x /sbin/update-modules ]] && /sbin/update-modules || /sbin/modules-update
	fi
}

pkg_config() {
	# use this only if you dont have devfs... the driver is already devfs aware.
	if [ "`ls -l ${ROOT}/dev/toshiba 2>/dev/null | awk '{print $$6}'`" != "181" ]
	then
		rm -f ${ROOT}/dev/toshiba
		mknod -m 666 ${ROOT}/dev/toshiba c 10 181
	fi
}
