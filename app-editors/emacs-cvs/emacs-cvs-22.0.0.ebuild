# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs-cvs/emacs-cvs-22.0.0.ebuild,v 1.1 2004/07/01 18:07:26 usata Exp $

ECVS_AUTH="ext"
export CVS_RSH="ssh"
ECVS_SERVER="savannah.gnu.org:/cvsroot/emacs"
ECVS_MODULE="emacs"
ECVS_BRANCH="emacs-unicode-2"
ECVS_USER="anoncvs"
ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP"
ECVS_SSH_HOST_KEY="savannah.gnu.org,199.232.41.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0="

inherit elisp-common cvs alternatives

IUSE="X Xaw3d gif gnome gtk jpeg nls png spell tiff"

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Emacs is the extensible, customizable, self-documenting real-time display editor."
SRC_URI=""
HOMEPAGE="http://www.gnu.org/software/emacs"

# Never use the sandbox, it causes Emacs to segfault on startup
SANDBOX_DISABLED="1"
RESTRICT="$RESTRICT nostrip"

DEPEND=">=sys-libs/ncurses-5.3
	sys-libs/gdbm
	dev-python/pexpect
	spell? ( || ( app-text/ispell app-text/aspell ) )
	X? ( virtual/x11
		gif? ( >=media-libs/libungif-4.1.0.1b )
		jpeg? ( >=media-libs/jpeg-6b )
		tiff? ( >=media-libs/tiff-3.5.7 )
		png? ( >=media-libs/libpng-1.2.5 )
		gtk? ( =x11-libs/gtk+-2* )
		!gtk? ( Xaw3d? ( x11-libs/Xaw3d ) )
		gnome? ( gnome-base/gnome-desktop ) )
	nls? ( >=sys-devel/gettext-0.11.5 )"

PROVIDE="virtual/emacs virtual/editor"

SLOT="${PV}"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DFILE=emacs.desktop

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	myconf="${myconf} $(use_with X x)"

	if use X; then
		myconf="${myconf} --with-xpm"
		myconf="${myconf} $(use_with jpeg) $(use_with tiff)"
		myconf="${myconf} $(use_with gif) $(use_with png)"
		if use gtk; then
			einfo "Configuring to build with GTK support"
			myconf="${myconf} --with-x-toolkit=gtk
				--with-toolkit-scroll-bars"
		elif use Xaw3d; then
			einfo "Configuring to build with Xaw3d support"
			myconf="${myconf} --with-x-toolkit=athena
				--with-toolkit-scroll-bars"
		else
			einfo "Configuring to build without X toolkit support"
			myconf="${myconf} --without-gtk"
			myconf="${myconf} --with-x-toolkit=no"
			myconf="${myconf} --without-toolkit-scroll-bars"
		fi
	fi

	unset CFLAGS CPPFLAGS

	econf --enable-debug \
		--program-suffix=-${PV} \
		${myconf} || die

	make bootstrap || die
}

src_install () {
	einstall || die
	rm ${D}/usr/bin/emacs-${PV}-${PV}

	# fix info documentation
	find ${D}/usr/share/info -type f -exec mv {} {}.info \;

	if has_version 'app-text/aspell' ; then
		# defaults to aspell if installed
		elisp-site-file-install ${FILESDIR}/40aspell-gentoo.el
	fi

	for m in  ${D}/usr/share/man/man1/* ; do
		mv ${m} ${m/.1/-${PV}.1}
	done

	dodoc BUGS ChangeLog README

	if use gnome; then
		insinto /usr/share/gnome/apps/Application
		doins ${FILESDIR}/${DFILE}
	fi
}

# do not update alternatives
