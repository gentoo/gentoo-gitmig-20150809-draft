# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pwm/pwm-1.0.20010309.ebuild,v 1.5 2002/08/14 15:45:39 murphy Exp $

NPV=20010309
S=${WORKDIR}/pwm-${NPV}
DESCRIPTION="A lightweight window manager"
SRC_URI="http://www.students.tut.fi/~tuomov/dl/pwm-${NPV}.tar.gz"
HOMEPAGE="http://www.students.tut.fi/~tuomov/pwm"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

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
	     || die
}

src_install() {
	make PREFIX=${D}/usr \
	     MANDIR=${D}/usr/share/man	\
	     DOCDIR=${D}/usr/share/doc \
	     ETCDIR=${D}/etc/X11 \
	     install || die

	if [ "`use gnome`" ]
	then
		insinto /usr/share/gnome/wm-properties
		doins support/PWM.desktop
	fi
	dodoc ChangeLog README
}
