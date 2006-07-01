# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pwm/pwm-1.0.20030617.ebuild,v 1.8 2006/07/01 20:56:45 nelchael Exp $

MY_P=${PN}-${PV/1.0./}
DESCRIPTION="A lightweight window manager"
HOMEPAGE="http://modeemi.fi/~tuomov/pwm/"
SRC_URI="http://modeemi.fi/~tuomov/dl/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE="gnome"

RDEPEND="|| ( x11-libs/libX11 virtual/x11 )"
DEPEND="|| ( ( x11-libs/libX11
		x11-libs/libXmu
		x11-proto/xproto )
	virtual/x11 )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:\$(DOCDIR)/pwm:\$(DOCDIR)/${PF}:g" \
		-e "s:^MANDIR=.*$::" \
		-e "s:^DOCDIR=.*$::" \
		-e "s:^ETCDIR=.*$::" \
		Makefile.orig >Makefile
	cp system.mk system.orig
	sed -e "s:-g -O2:${CFLAGS}:" \
		-e 's:\$(WARN)::' \
		system.orig >system.mk
	cp config.h config.orig
	sed -e "s:^#define CF_SYS_CONFIG_LOCATION.*$:#define CF_SYS_CONFIG_LOCATION \"/etc/X11/pwm/\":" \
		config.orig >config.h
}

src_compile() {
	emake PREFIX=/usr \
		MANDIR=/usr/share/man \
		DOCDIR=/usr/share/doc \
		ETCDIR=/etc/X11 \
		|| die "make failed"
}

src_install() {
	make PREFIX=${D}/usr \
		MANDIR=${D}/usr/share/man \
		DOCDIR=${D}/usr/share/doc \
		ETCDIR=${D}/etc/X11 \
		install || die "install failed"

	if use gnome
	then
		insinto /usr/share/gnome/wm-properties
		doins support/PWM.desktop
	fi
	dodoc ChangeLog README
}
