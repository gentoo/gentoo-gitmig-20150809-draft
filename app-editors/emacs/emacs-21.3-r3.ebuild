# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-21.3-r3.ebuild,v 1.13 2004/10/19 09:33:13 absinthe Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="An incredibly powerful, extensible text editor"
HOMEPAGE="http://www.gnu.org/software/emacs"
SRC_URI="mirror://gnu/emacs/${P}.tar.gz
	leim? ( mirror://gnu/emacs/leim-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="21"
KEYWORDS="x86 ppc sparc -alpha arm hppa amd64 -ia64 ~s390"
IUSE="X nls motif leim gnome Xaw3d lesstif"

RDEPEND="sys-libs/ncurses
	sys-libs/gdbm
	X? ( virtual/x11
		>=media-libs/libungif-4.1.0.1b
		>=media-libs/jpeg-6b-r2
		>=media-libs/tiff-3.5.5-r3
		>=media-libs/libpng-1.2.1
		!arm? (
		Xaw3d? ( x11-libs/Xaw3d )
		motif? (
			lesstif? ( x11-libs/lesstif )
			!lesstif? ( >=x11-libs/openmotif-2.1.30 ) )
		gnome? ( gnome-base/gnome-desktop )
		)
	)
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58"

PROVIDE="virtual/emacs virtual/editor"
SANDBOX_DISABLED="1"

DFILE=emacs.desktop

src_compile() {

	# -fstack-protector gets internal compiler error at xterm.c (bug 33265)
	filter-flags -fstack-protector

	# gcc 3.4 with -O3 or stronger flag spoils emacs
	if [ "$(gcc-major-version)" -ge 3 -a "$(gcc-minor-version)" -ge 4 ] ; then
		replace-flags -O[3-9] -O2
	fi

	epatch ${FILESDIR}/${P}-amd64.patch
	epatch ${FILESDIR}/${P}-hppa.patch

	export WANT_AUTOCONF=2.1
	autoconf

	local myconf
	use nls || myconf="${myconf} --disable-nls"
	if use X ; then
		if use motif && use lesstif; then
			append-ldflags -L/usr/X11R6/lib/lesstif -R/usr/X11R6/lib/lesstif
			export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include/lesstif"
		fi
		myconf="${myconf}
			--with-x
			--with-xpm
			--with-jpeg
			--with-tiff
			--with-gif
			--with-png"
		if use Xaw3d ; then
			myconf="${myconf} --with-x-toolkit=athena"
		elif use motif ; then
			myconf="${myconf} --with-x-toolkit=motif"
		else
			# do not build emacs with any toolkit, bug 35300
			myconf="${myconf} --with-x-toolkit=no"
		fi
	else
		myconf="${myconf} --without-x"
	fi
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	einfo "Fixing info documentation..."
	rm -f ${D}/usr/share/info/dir
	for i in ${D}/usr/share/info/*
	do
		mv ${i%.info} $i.info
	done

	einfo "Fixing permissions..."
	find ${D} -perm 664 |xargs chmod 644
	find ${D} -type d |xargs chmod 755

	dodoc BUGS ChangeLog README

	keepdir /usr/share/emacs/${PV}/leim

	if use gnome ; then
		insinto /usr/share/gnome/apps/Application
		doins ${FILESDIR}/${DFILE}
	fi
}
