# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs-cvs/emacs-cvs-22.0.97.ebuild,v 1.1 2007/04/04 06:43:24 opfer Exp $

WANT_AUTOCONF="2.61"
WANT_AUTOMAKE="latest"

inherit alternatives autotools elisp-common eutils flag-o-matic

DESCRIPTION="The extensible, customizable, self-documenting real-time display editor"
SRC_URI="ftp://alpha.gnu.org/gnu/emacs/pretest/emacs-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/emacs/"
IUSE="alsa aqua gif gnome gtk gzip-el jpeg lesstif motif nls png spell source tiff toolkit-scroll-bars X Xaw3d "

RESTRICT="$RESTRICT nostrip"

X_DEPEND="x11-libs/libXmu x11-libs/libXpm x11-libs/libXt x11-misc/xbitmaps || ( media-fonts/font-adobe-100dpi media-fonts/font-adobe-75dpi )"

DEPEND="sys-libs/ncurses
	sys-libs/zlib
	spell? ( || ( app-text/ispell app-text/aspell ) )
	X? ( $X_DEPEND )
	X? ( gif? ( media-libs/giflib )
		jpeg? ( media-libs/jpeg )
		tiff? ( media-libs/tiff )
		png? ( media-libs/libpng )
		gtk? ( =x11-libs/gtk+-2* )
		!gtk? ( Xaw3d? ( x11-libs/Xaw3d ) )
		!Xaw3d? ( motif? ( x11-libs/openmotif ) )
		!motif? ( lesstif? ( x11-libs/lesstif ) )
		gnome? ( gnome-base/gnome-desktop ) )
	alsa? ( media-sound/alsa-headers )
	gzip-el? ( app-arch/gzip  )
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/emacs virtual/editor"

SLOT="22.0.97"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
S="${WORKDIR}/emacs-${PV}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i -e "s:/usr/lib/crtbegin.o:$(`tc-getCC` -print-file-name=crtbegin.o):g" \
		-e "s:/usr/lib/crtend.o:$(`tc-getCC` -print-file-name=crtend.o):g" \
		"${S}"/src/s/freebsd.h || die "unable to sed freebsd.h settings"
	if ! use gzip-el; then
		# Emacs' build system automatically detects the gzip binary and compresses
		# el files.	 We don't want that so confuse it with a wrong binary name
		sed -i -e "s/ gzip/ PrEvEnTcOmPrEsSiOn/" configure.in || die "unable to sed configure.in"
	fi

	epatch "${FILESDIR}/${PN}-freebsd-sparc.patch"
	use ppc-macos && epatch "${FILESDIR}/emacs-cvs-21.3.50-nofink.diff"

	eautoreconf
}

src_compile() {
	export SANDBOX_ON=0			# for the unbelievers, see Bug #131505
	ALLOWED_FLAGS=""
	strip-flags
	unset LDFLAGS
	replace-flags -O[3-9] -O2
	sed -i -e "s/-lungif/-lgif/g" configure* src/Makefile* || die

	local myconf

	if use X; then
		myconf="${myconf} --with-x"
		myconf="${myconf} --with-xpm"
		myconf="${myconf} $(use_with toolkit-scroll-bars)"
		myconf="${myconf} $(use_with jpeg) $(use_with tiff)"
		myconf="${myconf} $(use_with gif) $(use_with png)"
		if use gtk; then
			einfo "Configuring to build with GTK support"
			myconf="${myconf} --with-x-toolkit=gtk"
		elif use Xaw3d; then
			einfo "Configuring to build with Xaw3d(athena) support"
			myconf="${myconf} --with-x-toolkit=athena"
			myconf="${myconf} --without-gtk"
			myconf="${myconf} --with-x-toolkit=lucid"
		elif use motif; then
			einfo "Configuring to build with motif toolkit support"
			myconf="${myconf} --without-gtk"
			myconf="${myconf} --with-x-toolkit=motif"
		elif use lesstif; then
			einfo "Configuring to build with lesstif toolkit support"
			myconf="${myconf} --without-gtk"
			myconf="${myconf} --with-x-toolkit=motif"
		fi
	else
		myconf="${myconf} --without-x"
	fi

	if use aqua; then
		einfo "Configuring to build with Carbon Emacs"
		econf \
			--enable-carbon-app=/Applications/Gentoo \
			--without-x \
			$(use_with jpeg) $(use_with tiff) \
			$(use_with gif) $(use_with png) \
			 || die "econf carbon emacs failed"
	else
		econf \
			--program-suffix=.emacs-${SLOT} \
			--without-carbon \
			${myconf} || die "econf emacs failed"
	fi

	emake CC="$(tc-getCC) " bootstrap \
		|| die "make bootstrap failed."
}

src_install () {
	emake install DESTDIR="${D}" || die "make install failed"

	rm "${D}"/usr/bin/emacs-${SLOT}.emacs-${SLOT} || die "removing duplicate emacs executable failed"
	dohard /usr/bin/emacs.emacs-${SLOT} /usr/bin/emacs-${SLOT} || die

	if use aqua ; then
		einfo "Installing Carbon Emacs..."
		dodir /Applications/Gentoo/Emacs.app
		pushd mac/Emacs.app
		tar -chf - . | ( cd "${D}/Applications/Gentoo/Emacs.app"; tar -xf -)
		popd
	fi

	# fix info documentation
	einfo "Fixing info documentation..."
	dodir /usr/share/info/emacs-${SLOT}
	mv "${D}"/usr/share/info/{,emacs-${SLOT}/}dir || die "mv dir failed"
	for i in "${D}"/usr/share/info/*
	do
		if [ "${i##*/}" != emacs-${SLOT} ] ; then
			mv ${i} ${i/info/info/emacs-${SLOT}}.info
		fi
	done

	insinto /etc/env.d
	cat >"${D}"/etc/env.d/50emacs-cvs-${SLOT} <<EOF
INFOPATH=/usr/share/info/emacs-${SLOT}
EOF
	einfo "Fixing manpages..."
	for m in  "${D}"/usr/share/man/man1/* ; do
		mv ${m} ${m/.1/.emacs-${SLOT}.1} || die "mv man failed"
	done

	# avoid collision between slots
	rm "${D}"/usr/share/emacs/site-lisp/subdirs.el

	if use source; then
		insinto /usr/share/emacs/${SLOT}/src
		# This is not meant to install all the source -- just the
		# C source you might find via find-function
		doins src/*.[ch]
		cat >00emacs-cvs-${SLOT}-gentoo.el <<EOF
(when (substring emacs-version 0 (length "${SLOT}"))
  (setq find-function-C-source-directory "/usr/share/emacs/${SLOT}/src"))
EOF
		elisp-site-file-install 00emacs-cvs-${SLOT}-gentoo.el
	fi

	dodoc BUGS ChangeLog README
}

update-alternatives() {
	# extract the suffix of the manpages to determine the correct compression program
	local suffix=$(echo /usr/share/man/man1/emacs.emacs-*.1*|sed 's/.*\.1//')

	# this creates symlinks for binaries and man pages, so the correct ones in a slotted
	# environment can be accessed
	for i in emacs emacsclient etags ctags b2m ebrowse \
		rcs-checkin grep-changelog ;
	do
		alternatives_auto_makesym "/usr/bin/$i" "/usr/bin/$i.emacs-*"
	done

	for j in emacs emacsclient etags ctags
	do
		alternatives_auto_makesym "/usr/share/man/man1/$j.1${suffix}" "/usr/share/man/man1/$j.emacs-*"
	done
}

pkg_postinst() {
	test -f ${ROOT}/usr/share/emacs/site-lisp/subdirs.el ||
		cp ${ROOT}/usr/share/emacs{/${SLOT},}/site-lisp/subdirs.el

	use ppc-macos || update-alternatives
	elisp-site-regen

	# ecompress from Portage 2.2.* does auto-compression
	# which is not desired for the dir file, so remove it to
	# let it be recreated
	rm "${ROOT}/usr/share/info/emacs-${SLOT}/dir.*" 2> /dev/null

	if use X; then
		elog "You need to install some fonts for Emacs.	 Under monolithic"
		elog "XFree86/Xorg you typically had such fonts installed by default."
		elog "With modular Xorg, you will have to perform this step yourself."
		elog "Installing media-fonts/font-adobe-{75,100}dpi would satisfy basic"
		elog "Emacs requirements under X11."
	fi
}

pkg_postrm() {
	use ppc-macos || update-alternatives
	elisp-site-regen
}
