# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdcd/cdcd-0.5.0-r1.ebuild,v 1.1 2002/07/14 13:26:56 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a simple yet powerful command line cd player"
SRC_URI="http://cdcd.undergrid.net/source_archive/${P}.tar.gz"
HOMEPAGE="http://cdcd.undergrid.net/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.0
	>=sys-libs/readline-4.0
	>=media-libs/libcdaudio-0.99.4"

src_unpack() {
	unpack ${P}.tar.gz
	
	cd ${S}

	patch <<'_end_'      
*** configure.in.orig   Sat Jul 13 04:19:25 2002
--- configure.in        Sat Jul 13 04:19:01 2002
***************
*** 58,62 ****
  fi
  fi
! LIBS="$CURSES $READLINE $CDAUDIO_LIBS"

  AC_OUTPUT(Makefile)
--- 58,62 ----
  fi
  fi
! LIBS="$READLINE $CURSES $CDAUDIO_LIBS"

  AC_OUTPUT(Makefile)
_end_

}

src_compile() {

	econf || die
	make || die
}

src_install () {
	cd ${S}
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
