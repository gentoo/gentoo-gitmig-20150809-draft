# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@intphsys.com>

S=${WORKDIR}/${P}
DESCRIPTION="A lightweight window manager"
SRC_URI="http://www.students.tut.fi/~tuomov/dl/${P}.tar.gz"
HOMEPAGE="http://www.students.tut.fi/~tuomov/pwm"

DEPEND=">=x11-base/xfree-4.0.1"


src_unpack() {

	unpack ${A}

	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:\$(DOCDIR)/pwm:\$(DOCDIR)/${PF}:g" 			\
	    Makefile.orig >Makefile
	cp system.mk system.orig
	sed -e "s:-g -O2:${CFLAGS}:"					\
	    -e 's:\$(WARN)::'						\
	    system.orig >system.mk
}

src_compile() {

	make PREFIX=/usr						\
	     MANDIR=/usr/share/man/man1					\
	     DOCDIR=/usr/share/doc					\
	     ETCDIR=/etc/X11						\
	     CF_SYS_CONFIG_LOCATION=/etc/X11/pwm/			\
	     || die
}

src_install() {

	make PREFIX=${D}/usr						\
	     MANDIR=${D}/usr/share/man/man1				\
	     DOCDIR=${D}/usr/share/doc					\
	     ETCDIR=${D}/etc/X11					\
	     install || die

	if [ "`use gnome`" ] ; then
	
		insinto /usr/share/gnome/wm-properties
		doins support/PWM.desktop
	fi

	dodoc ChangeLog README
}
