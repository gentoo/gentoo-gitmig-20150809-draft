# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pwm/pwm-1.0.20030617.ebuild,v 1.4 2004/06/19 05:27:46 weeve Exp $

MY_P=${PN}-${PV/1.0./}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A lightweight window manager. It was the first window manager to implement tabbed frames or the back then unique feature allowing multiple client windows can be attached to the same frame or This feature helps keeping windows, especially the numerous xterms, organized. "
SRC_URI="http://modeemi.fi/~tuomov/dl/${MY_P}.tar.gz"
HOMEPAGE="http://modeemi.fi/~tuomov/pwm/"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 sparc ppc"
IUSE="gnome"

DEPEND="virtual/x11"

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

	if [ "`use gnome`" ]
	then
		insinto /usr/share/gnome/wm-properties
		doins support/PWM.desktop
	fi
	dodoc ChangeLog README
}
