# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screen/screen-3.9.15.ebuild,v 1.5 2003/04/16 00:19:34 gmsoft Exp $

inherit flag-o-matic

IUSE="pam"
DESCRIPTION="Screen is a full-screen window manager that multiplexes a physical terminal between several processes"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/utilities/screen/${P}.tar.gz"
HOMEPAGE="http://www.math.fu-berlin.de/~guckes/screen/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha hppa mips"

DEPEND=">=sys-libs/ncurses-5.2
	pam? ( >=sys-libs/pam-0.75 )"

src_unpack() {
	unpack ${A} && cd ${S}

	# Fix manpage.
	mv doc/screen.1 doc/screen.1.orig
	sed <doc/screen.1.orig >doc/screen.1 \
		-e "s:/usr/local/etc/screenrc:/etc/screenrc:g;
		s:/usr/local/screens:/var/run/screen:g;
		s:/local/etc/screenrc:/etc/screenrc:g;
		s:/etc/utmp:/var/run/utmp:g;
		s:/local/screens/S-:/var/run/screen/S-:g"
}

src_compile() {
	local myconf

	addpredict "`tty`"
	addpredict "${SSH_TTY}"

	# check config.h for other settings such as the 
	# max-number of windows allowed by screen.
	append-flags "-DPTYMODE=0620 -DPTYGROUP=5"
	use pam && myconf="--enable-pam" && append-flags "-DUSE_PAM"

	econf 	--with-socket-dir=/var/run/screen \
		--with-sys-screenrc=/etc/screenrc \
		--enable-rxvt_osc ${myconf}

#	# Fix bug 12683 by fixing up term.h (remove dups and add missing).
#	# This is really an upstream problem in screen, I think.
#	# (15 Jan 2003 agriffis)
#	mv term.h term.h.old
#	awk '/^#define/ { if (defs[$2]) next; defs[$2] = $3 }
#                    { print }
#                END { for (d in defs) { 
#						if (d !~ /_C../) continue; 
#						d2 = gensub(/C/, "", 1, d);
#						if (d2 in defs) continue; 
#                        print "#define " d2 " " defs[d]
#                      }
#                    }' term.h.old > term.h || die "Failed to fix term.h"

    # Second try to fix bug 12683, this time without changing term.h
	# The last try seemed to break screen at run-time.
	# (16 Jan 2003 agriffis)
	LC_ALL=POSIX make term.h || die "Failed making term.h"

	emake || die "Failed to compile"
}

src_install () {
	dobin screen
	fperms 2755 /usr/bin/screen

	dodir /var/run/screen
	touch ${D}/var/run/screen/.keep

	# can't use this cause fowners do not support multiple args.
	# fowners root.utmp /{usr/bin,var/run}/screen
	chown root.utmp ${D}/{usr/bin,var/run}/screen

	insinto /usr/share/terminfo ; doins terminfo/screencap
	insinto /usr/share/screen/utf8encodings ; doins utf8encodings/??
	insopts -m 644 ; insinto /etc ; doins ${FILESDIR}/screenrc

	use pam && { insinto /etc/pam.d ; newins ${FILESDIR}/screen.pam screen ; }

	dodoc README ChangeLog INSTALL COPYING TODO NEWS* \
	doc/{FAQ,README.DOTSCREEN,fdpat.ps,window_to_display.ps}

	doman doc/screen.1
	doinfo doc/screen.info*
}

pkg_postinst() {
	chmod 0775 /var/run/screen

	einfo "Some dangerous key bindings have been removed or changed to more safe values."
	einfo "For more info, please check /etc/screenrc"
	echo
	einfo "screen is not installed as setuid root, which effectively disables multi-user"
	einfo "mode. To enable it, run:"
	einfo ""
	einfo "\tchmod u+s /usr/bin/screen"
	einfo "\tchmod g-w /var/run/screen"
}
