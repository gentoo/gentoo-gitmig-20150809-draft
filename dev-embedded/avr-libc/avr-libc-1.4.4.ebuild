# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avr-libc/avr-libc-1.4.4.ebuild,v 1.1 2006/04/21 08:32:26 brix Exp $

inherit flag-o-matic

DESCRIPTION="C library for Atmel AVR microcontrollers"
HOMEPAGE="http://www.nongnu.org/avr-libc/"
SRC_URI="http://savannah.nongnu.org/download/avr-libc/${P}.tar.bz2
		http://savannah.nongnu.org/download/avr-libc/${PN}-manpages-${PV}.tar.bz2
		doc? ( http://savannah.nongnu.org/download/avr-libc/${PN}-user-manual-${PV}.tar.bz2 )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE="doc nls"
DEPEND=">=sys-devel/crossdev-0.9.1"
[[ ${CATEGORY/cross-} != ${CATEGORY} ]] \
	&& RDEPEND="!dev-embedded/avr-libc" \
	|| RDEPEND=""

src_compile() {
	export AS=avr-as AR=avr-ar RANLIB=avr-ranlib CC=avr-gcc ABI=retarded

	strip-flags
	strip-unsupported-flags

	mkdir obj-avr
	cd "${S}"/obj-avr

	ECONF_SOURCE="${S}" CHOST="avr" CTARGET="avr" econf \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	cd "${S}"/obj-avr
	make DESTDIR="${D}" install || die "make install failed"

	cd "${S}"
	dodoc AUTHORS ChangeLog* NEWS README

	# man pages can not go into standard locations
	# as they would then overwrite libc man pages
	dosed "s:\$(VERSION):${PVR}:" /usr/bin/avr-man
	insinto /usr/share/doc/${PF}/man/man3
	doins "${WORKDIR}"/man/man3/*
	prepman /usr/share/doc/${PF}

	use doc	&& dohtml "${WORKDIR}"/${PN}-user-manual-${PV}/*
}
