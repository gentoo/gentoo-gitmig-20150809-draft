# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screen/screen-4.0.1-r1.ebuild,v 1.7 2003/12/15 03:45:08 brad_mssw Exp $

inherit flag-o-matic

IUSE="pam"
DESCRIPTION="Screen is a full-screen window manager that multiplexes a physical terminal between several processes"
HOMEPAGE="http://www.guckes.net/screen/"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/utilities/screen/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc hppa amd64"

DEPEND=">=sys-libs/ncurses-5.2
	>=sys-apps/sed-4
	pam? ( >=sys-libs/pam-0.75 )"

src_unpack() {
	unpack ${A} && cd ${S}

	# Bug: 34599 integer overflow in 4.0.1  (Nov 29 2003 -solar)
	epatch ${FILESDIR}/${PN}-${PV}-int-overflow-fix.patch

	# Fix manpage.
	sed -i \
		-e "s:/usr/local/etc/screenrc:/etc/screenrc:g;
		s:/usr/local/screens:/var/run/screen:g;
		s:/local/etc/screenrc:/etc/screenrc:g;
		s:/etc/utmp:/var/run/utmp:g;
		s:/local/screens/S-:/var/run/screen/S-:g" doc/screen.1 || \
			die "sed doc/screen.1 failed"
}

src_compile() {
	local myconf

	addpredict "`tty`"
	addpredict "${SSH_TTY}"

	# check config.h for other settings such as the
	# max-number of windows allowed by screen.
	append-flags "-DPTYMODE=0620 -DPTYGROUP=5"
	use pam && myconf="--enable-pam" && append-flags "-DUSE_PAM"

	econf \
		--with-socket-dir=/var/run/screen \
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

	emake || die "emake failed"
}

src_install () {
	dobin screen || die "dobin failed"
	keepdir /var/run/screen
	fowners root:utmp /{usr/bin,var/run}/screen
	fperms 2755 /usr/bin/screen

	insinto /usr/share/terminfo ; doins terminfo/screencap
	insinto /usr/share/screen/utf8encodings ; doins utf8encodings/??
	insopts -m 644 ; insinto /etc ; doins ${FILESDIR}/screenrc

	use pam && {
		insinto /etc/pam.d
		newins ${FILESDIR}/screen.pam.system-auth screen
	}

	dodoc README ChangeLog INSTALL TODO NEWS* patchlevel.h \
		doc/{FAQ,README.DOTSCREEN,fdpat.ps,window_to_display.ps} || \
			die "dodoc failed"

	doman doc/screen.1 || die "doman failed"
	doinfo doc/screen.info* || die "doinfo failed"
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
	einfo "\tchmod go-w /var/run/screen"
}
