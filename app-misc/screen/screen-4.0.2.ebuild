# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screen/screen-4.0.2.ebuild,v 1.22 2004/12/05 00:55:24 swegener Exp $

inherit eutils flag-o-matic

DESCRIPTION="Screen is a full-screen window manager that multiplexes a physical terminal between several processes"
HOMEPAGE="http://www.gnu.org/software/screen/"
SRC_URI="mirror://gnu/screen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="pam nethack uclibc"

RDEPEND=">=sys-libs/ncurses-5.2
	pam? ( >=sys-libs/pam-0.75 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A} && cd ${S} || die

	# Bug 34599: integer overflow in 4.0.1  
	# (Nov 29 2003 -solar)
	epatch ${FILESDIR}/screen-4.0.1-int-overflow-fix.patch

	# Bug 31070: configure problem which affects alpha  
	# (13 Jan 2004 agriffis)
	epatch ${FILESDIR}/screen-4.0.1-vsprintf.patch

	# uclibc doesnt have sys/stropts.h
	use uclibc && epatch ${FILESDIR}/${PV}-no-pty.patch

	# Fix manpage.
	sed -i \
		-e "s:/usr/local/etc/screenrc:/etc/screenrc:g" \
		-e "s:/usr/local/screens:/var/run/screen:g" \
		-e "s:/local/etc/screenrc:/etc/screenrc:g" \
		-e "s:/etc/utmp:/var/run/utmp:g" \
		-e "s:/local/screens/S-:/var/run/screen/S-:g" \
		doc/screen.1 \
		|| die "sed doc/screen.1 failed"

	# configure as delivered with screen is made with autoconf-2.5
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
}

src_compile() {
	addpredict "`tty`"
	addpredict "${SSH_TTY}"

	# check config.h for other settings such as the
	# max-number of windows allowed by screen.
	append-flags "-DPTYMODE=0620 -DPTYGROUP=5"
	append-ldflags -Wl,-z,now

	use pam && append-flags "-DUSE_PAM"
	use nethack || append-flags "-DNONETHACK"

	econf \
		$(use_enable pam) \
		--with-socket-dir=/var/run/screen \
		--with-sys-screenrc=/etc/screenrc \
		--enable-rxvt_osc \
		|| die "econf failed"

	# Second try to fix bug 12683, this time without changing term.h
	# The last try seemed to break screen at run-time.
	# (16 Jan 2003 agriffis)
	LC_ALL=POSIX make term.h || die "Failed making term.h"

	emake || die "emake failed"
}

src_install() {
	dobin screen || die "dobin failed"
	keepdir /var/run/screen || die "keepdir failed"
	fowners root:utmp /{usr/bin,var/run}/screen || die "fowners failed"
	fperms 2755 /usr/bin/screen || die "fperms failed"

	insinto /usr/share/terminfo
	doins terminfo/screencap || die "doins failed"
	insinto /usr/share/screen/utf8encodings
	doins utf8encodings/?? || die "doins failed"
	insinto /etc
	doins ${FILESDIR}/screenrc || die "doins failed"

	use pam && {
		insinto /etc/pam.d
		newins ${FILESDIR}/screen.pam.system-auth screen || die "newins failed"
	}

	dodoc \
		README ChangeLog INSTALL TODO NEWS* patchlevel.h \
		doc/{FAQ,README.DOTSCREEN,fdpat.ps,window_to_display.ps} \
		|| die "dodoc failed"

	doman doc/screen.1 || die "doman failed"
	doinfo doc/screen.info* || die "doinfo failed"
}

pkg_postinst() {
	chmod 0775 ${ROOT}/var/run/screen

	einfo "Some dangerous key bindings have been removed or changed to more safe values."
	einfo "For more info, please check /etc/screenrc"
	einfo
	einfo "screen is not installed as setuid root, which effectively disables multi-user"
	einfo "mode. To enable it, run:"
	einfo ""
	einfo "\tchmod u+s /usr/bin/screen"
	einfo "\tchmod go-w /var/run/screen"
}
