# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs-cvs/emacs-cvs-21.3.50-r2.ebuild,v 1.1 2004/11/25 03:26:17 usata Exp $

ECVS_AUTH="ext"
export CVS_RSH="ssh"
ECVS_SERVER="savannah.gnu.org:/cvsroot/emacs"
ECVS_MODULE="emacs"
ECVS_BRANCH="HEAD"
ECVS_USER="anoncvs"
#ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP"
ECVS_SSH_HOST_KEY="savannah.gnu.org,199.232.41.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0="

inherit elisp-common cvs alternatives flag-o-matic eutils

IUSE="X Xaw3d aqua gif gnome gtk jpeg nls png spell tiff"

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
	nls? ( >=sys-devel/gettext-0.11.5 )
	>=sys-apps/portage-2.0.51_rc1"

PROVIDE="virtual/emacs virtual/editor"

SLOT="21.3.50"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~ppc-macos"

DFILE=emacs-${SLOT}.desktop

src_compile() {

	strip-flags
	epatch ${FILESDIR}/emacs-subdirs-el-gentoo.diff
	use ppc-macos && epatch ${FILESDIR}/${P}-nofink.diff

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	if use X; then
		myconf="${myconf} --with-x"
		myconf="${myconf} --with-xpm --with-toolkit-scroll-bars"
		myconf="${myconf} $(use_with jpeg) $(use_with tiff)"
		myconf="${myconf} $(use_with gif) $(use_with png)"
		if use gtk; then
			einfo "Configuring to build with GTK support"
			myconf="${myconf} --with-x-toolkit=gtk"
		elif use Xaw3d; then
			einfo "Configuring to build with Xaw3d support"
			myconf="${myconf} --with-x-toolkit=athena"
		else
			einfo "Configuring to build with lucid toolkit support"
			myconf="${myconf} --without-gtk"
			myconf="${myconf} --with-x-toolkit=lucid"
		fi
	fi

	if use aqua ; then
		einfo "Configuring to build with Carbon Emacs"
		econf --enable-debug \
			--enable-carbon-app=/Applications/Gentoo \
			--without-x \
			$(use_with jpeg) $(use_with tiff) \
			$(use_with gif) $(use_with png) \
			 || die "econf carbon emacs failed"
		make bootstrap || die "make carbon emacs bootstrap failed"
	fi

	econf --enable-debug \
		--program-suffix=.emacs-${SLOT} \
		--without-carbon \
		${myconf} || die "econf emacs failed"

	make bootstrap || die "make emacs bootstrap failed"
}

src_install () {
	# make DESTDIR=${D} install doesn't work
	einstall || die "einstall failed"
	rm ${D}/usr/bin/emacs-${SLOT}.emacs-${SLOT} || die "removing duplicate emacs executable failed"

	if use aqua ; then
		einfo "Installing Carbon Emacs..."
		dodir /Applications/Gentoo/Emacs.app
		pushd mac/Emacs.app
		tar -chf - . | ( cd ${D}/Applications/Gentoo/Emacs.app; tar -xf -)
		popd
	fi

	# fix info documentation
	einfo "Fixing info documentation..."
	dodir /usr/share/info/emacs-${SLOT}
	mv ${D}/usr/share/info/{,emacs-${SLOT}/}dir || die "mv dir failed"
	for i in ${D}/usr/share/info/*
	do
		if [ "${i##*/}" != emacs-${SLOT} ] ; then
			mv ${i} ${i/info/info/emacs-${SLOT}}.info
			gzip -9 ${i/info/info/emacs-${SLOT}}.info
		fi
	done

	if has_version 'app-text/aspell' ; then
		# defaults to aspell if installed
		elisp-site-file-install ${FILESDIR}/40aspell-gentoo.el
	fi
	newenvd ${FILESDIR}/50emacs-${SLOT}.envd 50emacs-${SLOT}

	einfo "Fixing manpages..."
	for m in  ${D}/usr/share/man/man1/* ; do
		mv ${m} ${m/.1/.emacs-${SLOT}.1} || die "mv man failed"
	done

	dodoc BUGS ChangeLog README

	if use gnome; then
		insinto /usr/share/gnome/apps/Application
		doins ${FILESDIR}/${DFILE} || die "install desktop file failed"
	fi
}

update-alternatives() {
	for i in emacs emacsclient etags ctags b2m ebrowse \
		rcs-checkin grep-changelog ; do
		alternatives_auto_makesym "/usr/bin/$i" "/usr/bin/$i.emacs-*"
	done
}

pkg_postinst() {
	use ppc-macos || update-alternatives
}

pkg_postrm() {
	use ppc-macos || update-alternatives
}
