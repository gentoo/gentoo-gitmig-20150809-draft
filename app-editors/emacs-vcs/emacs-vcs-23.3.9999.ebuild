# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs-vcs/emacs-vcs-23.3.9999.ebuild,v 1.11 2011/08/22 19:31:26 ulm Exp $

EAPI=4
WANT_AUTOMAKE="none"

inherit autotools elisp-common eutils flag-o-matic multilib

if [ "${PV##*.}" = "9999" ]; then
	EBZR_PROJECT="emacs"
	EBZR_BRANCH="emacs-23"
	EBZR_REPO_URI="bzr://bzr.savannah.gnu.org/emacs/${EBZR_BRANCH}/"
	# "Nosmart" is much faster for initial branching.
	EBZR_INITIAL_URI="nosmart+${EBZR_REPO_URI}"
	inherit bzr
	SRC_URI=""
else
	SRC_URI="mirror://gentoo/emacs-${PV}.tar.gz
		ftp://alpha.gnu.org/gnu/emacs/pretest/emacs-${PV}.tar.gz"
	# FULL_VERSION keeps the full version number, which is needed in
	# order to determine some path information correctly for copy/move
	# operations later on
	FULL_VERSION="${PV%%_*}"
	S="${WORKDIR}/emacs-${FULL_VERSION}"
fi

DESCRIPTION="The extensible, customizable, self-documenting real-time display editor"
HOMEPAGE="http://www.gnu.org/software/emacs/"

LICENSE="GPL-3 FDL-1.3 BSD as-is MIT W3C unicode PSF-2"
SLOT="23"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="alsa dbus gconf gif gpm gtk gzip-el hesiod jpeg kerberos m17n-lib motif png sound source svg tiff toolkit-scroll-bars X Xaw3d xft +xpm"

RDEPEND="sys-libs/ncurses
	>=app-admin/eselect-emacs-1.2
	net-libs/liblockfile
	hesiod? ( net-dns/hesiod )
	kerberos? ( virtual/krb5 )
	alsa? ( media-libs/alsa-lib )
	gpm? ( sys-libs/gpm )
	dbus? ( sys-apps/dbus )
	X? (
		x11-libs/libXmu
		x11-libs/libXt
		x11-misc/xbitmaps
		gconf? ( >=gnome-base/gconf-2.26.2 )
		gif? ( media-libs/giflib )
		jpeg? ( virtual/jpeg )
		png? ( media-libs/libpng )
		svg? ( >=gnome-base/librsvg-2.0 )
		tiff? ( media-libs/tiff )
		xpm? ( x11-libs/libXpm )
		xft? (
			media-libs/fontconfig
			media-libs/freetype
			x11-libs/libXft
			m17n-lib? (
				>=dev-libs/libotf-0.9.4
				>=dev-libs/m17n-lib-1.5.1
			)
		)
		gtk? ( x11-libs/gtk+:2 )
		!gtk? (
			Xaw3d? ( x11-libs/libXaw3d )
			!Xaw3d? ( motif? ( >=x11-libs/openmotif-2.3:0 ) )
		)
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	gzip-el? ( app-arch/gzip )"

RDEPEND="${RDEPEND}
	>=app-emacs/emacs-common-gentoo-1[X?]"

EMACS_SUFFIX="emacs-${SLOT}-vcs"
SITEFILE="20${PN}-${SLOT}-gentoo.el"

pkg_setup() {
	local olddir="${EBZR_STORE_DIR}/emacs-${EBZR_BRANCH#emacs-}"
	if [ -d "${olddir}" ]; then
		ewarn "bzr.eclass uses branches instead of checkouts now."
		ewarn "Therefore, you may remove the old bzr checkout:"
		ewarn "rm -rf ${olddir}"
	fi
}

src_prepare() {
	if [ "${PV##*.}" = "9999" ]; then
		FULL_VERSION=$(grep 'defconst[	 ]*emacs-version' lisp/version.el \
			| sed -e 's/^[^"]*"\([^"]*\)".*$/\1/')
		[ "${FULL_VERSION}" ] || die "Cannot determine current Emacs version"
		echo
		einfo "Emacs branch: ${EBZR_BRANCH}"
		einfo "Revision: ${EBZR_REVISION:-${EBZR_REVNO}}"
		einfo "Emacs version number: ${FULL_VERSION}"
		[[ ${FULL_VERSION} =~ ^${PV%.*}(\..*)?$ ]] \
			|| die "Upstream version number changed to ${FULL_VERSION}"
		echo
	fi

	sed -i \
		-e "s:/usr/lib/crtbegin.o:$(`tc-getCC` -print-file-name=crtbegin.o):g" \
		-e "s:/usr/lib/crtend.o:$(`tc-getCC` -print-file-name=crtend.o):g" \
		"${S}"/src/s/freebsd.h || die "unable to sed freebsd.h settings"

	if ! use alsa; then
		# ALSA is detected even if not requested by its USE flag.
		# Suppress it by supplying pkg-config with a wrong library name.
		sed -i -e "/ALSA_MODULES=/s/alsa/DiSaBlEaLsA/" configure.in \
			|| die "unable to sed configure.in"
	fi
	if ! use gzip-el; then
		# Emacs' build system automatically detects the gzip binary and
		# compresses el files. We don't want that so confuse it with a
		# wrong binary name
		sed -i -e "s/ gzip/ PrEvEnTcOmPrEsSiOn/" configure.in \
			|| die "unable to sed configure.in"
	fi

	eautoreconf
}

src_configure() {
	ALLOWED_FLAGS=""
	strip-flags
	filter-flags -fstrict-aliasing
	append-flags $(test-flags -fno-strict-aliasing)

	if use sh; then
		replace-flags -O[1-9] -O0		#262359
	elif use ia64; then
		replace-flags -O[2-9] -O1		#325373
	else
		replace-flags -O[3-9] -O2
	fi

	local myconf

	if use alsa && ! use sound; then
		echo
		einfo "Although sound USE flag is disabled you chose to have alsa,"
		einfo "so sound is switched on anyway."
		echo
		myconf="${myconf} --with-sound"
	else
		myconf="${myconf} $(use_with sound)"
	fi

	if use X; then
		myconf="${myconf} --with-x"
		myconf="${myconf} $(use_with gconf)"
		myconf="${myconf} $(use_with toolkit-scroll-bars)"
		myconf="${myconf} $(use_with gif) $(use_with jpeg)"
		myconf="${myconf} $(use_with png) $(use_with svg rsvg)"
		myconf="${myconf} $(use_with tiff) $(use_with xpm)"
		myconf="${myconf} $(use_with xft)"

		if use xft; then
			myconf="${myconf} $(use_with m17n-lib libotf)"
			myconf="${myconf} $(use_with m17n-lib m17n-flt)"
		else
			myconf="${myconf} --without-libotf --without-m17n-flt"
			use m17n-lib && ewarn \
				"USE flag \"m17n-lib\" has no effect because xft is not set."
		fi

		# GTK+ is the default toolkit if USE=gtk is chosen with other
		# possibilities. Emacs upstream thinks this should be standard
		# policy on all distributions
		if use gtk; then
			einfo "Configuring to build with GIMP Toolkit (GTK+)"
			myconf="${myconf} --with-x-toolkit=gtk"
		elif use Xaw3d; then
			einfo "Configuring to build with Xaw3d (Athena/Lucid) toolkit"
			myconf="${myconf} --with-x-toolkit=athena"
		elif use motif; then
			einfo "Configuring to build with Motif toolkit"
			myconf="${myconf} --with-x-toolkit=motif"
		else
			einfo "Configuring to build with no toolkit"
			myconf="${myconf} --with-x-toolkit=no"
		fi

		local f tk=
		for f in gtk Xaw3d motif; do
			use ${f} || continue
			[ "${tk}" ] \
				&& ewarn "USE flag \"${f}\" ignored (superseded by \"${tk}\")"
			tk="${tk}${tk:+ }${f}"
		done
	else
		myconf="${myconf} --without-x"
	fi

	if [ "${PV##*.}" = "9999" ]; then
		# These variables are not needed for building. We add them to
		# configure options because they are stored in the Emacs binary
		# and available in variable "system-configuration-options".
		myconf="${myconf} EBZR_BRANCH=${EBZR_BRANCH} EBZR_REVNO=${EBZR_REVNO}"
	fi

	# According to configure, this option is only used for GNU/Linux
	# (x86_64 and s390). For Gentoo Prefix we have to explicitly spell
	# out the location because $(get_libdir) does not necessarily return
	# something that matches the host OS's libdir naming (e.g. RHEL).
	local crtdir=$($(tc-getCC) -print-file-name=crt1.o)
	crtdir=${crtdir%/*}

	econf \
		--program-suffix=-${EMACS_SUFFIX} \
		--infodir="${EPREFIX}"/usr/share/info/${EMACS_SUFFIX} \
		--with-crt-dir="${crtdir}" \
		$(use_with hesiod) \
		$(use_with kerberos) $(use_with kerberos kerberos5) \
		$(use_with gpm) \
		$(use_with dbus) \
		${myconf}
}

src_compile() {
	export SANDBOX_ON=0			# for the unbelievers, see Bug #131505
	if [ "${PV##*.}" = "9999" ]; then
		emake CC="$(tc-getCC)" bootstrap
		# cleanup, otherwise emacs will be dumped again in src_install
		(cd src; emake versionclean)
	fi
	# set last component of emacs-version to (package revision + 1)
	touch src/emacs-${FULL_VERSION}.${PR#r}
	emake CC="$(tc-getCC)"
}

src_install () {
	local i m

	emake install DESTDIR="${D}"

	rm "${ED}"/usr/bin/emacs-${FULL_VERSION}-${EMACS_SUFFIX} \
		|| die "removing duplicate emacs executable failed"
	mv "${ED}"/usr/bin/emacs-${EMACS_SUFFIX} "${ED}"/usr/bin/${EMACS_SUFFIX} \
		|| die "moving Emacs executable failed"

	# move man pages to the correct place
	for m in "${ED}"/usr/share/man/man1/* ; do
		mv "${m}" "${m%.1}-${EMACS_SUFFIX}.1" || die "mv man failed"
	done

	# move info dir to avoid collisions with the dir file generated by portage
	mv "${ED}"/usr/share/info/${EMACS_SUFFIX}/dir{,.orig} \
		|| die "moving info dir failed"
	touch "${ED}"/usr/share/info/${EMACS_SUFFIX}/.keepinfodir
	docompress -x /usr/share/info/${EMACS_SUFFIX}/dir.orig

	# avoid collision between slots, see bug #169033 e.g.
	rm "${ED}"/usr/share/emacs/site-lisp/subdirs.el
	rm -rf "${ED}"/usr/share/{applications,icons}
	rm "${ED}"/var/lib/games/emacs/{snake,tetris}-scores
	keepdir /var/lib/games/emacs

	local c=";;"
	if use source; then
		insinto /usr/share/emacs/${FULL_VERSION}/src
		# This is not meant to install all the source -- just the
		# C source you might find via find-function
		doins src/*.[ch]
		c=""
	fi

	sed 's/^X//' >"${T}/${SITEFILE}" <<-EOF
	X
	;;; ${PN}-${SLOT} site-lisp configuration
	X
	(when (string-match "\\\\\`${FULL_VERSION//./\\\\.}\\\\>" emacs-version)
	X  ${c}(setq find-function-C-source-directory
	X  ${c}      "${EPREFIX}/usr/share/emacs/${FULL_VERSION}/src")
	X  (let ((path (getenv "INFOPATH"))
	X	(dir "${EPREFIX}/usr/share/info/${EMACS_SUFFIX}")
	X	(re "\\\\\`${EPREFIX}/usr/share/info\\\\>"))
	X    (and path
	X	 ;; move Emacs Info dir before anything else in /usr/share/info
	X	 (let* ((p (cons nil (split-string path ":" t))) (q p))
	X	   (while (and (cdr q) (not (string-match re (cadr q))))
	X	     (setq q (cdr q)))
	X	   (setcdr q (cons dir (delete dir (cdr q))))
	X	   (setq Info-directory-list (prune-directory-list (cdr p)))))))
	EOF
	elisp-site-file-install "${T}/${SITEFILE}" || die

	dodoc README BUGS
}

pkg_preinst() {
	# move Info dir file to correct name
	local infodir=/usr/share/info/${EMACS_SUFFIX} f
	if [ -f "${ED}"${infodir}/dir.orig ]; then
		mv "${ED}"${infodir}/dir{.orig,} || die "moving info dir failed"
	else
		# this should not happen in EAPI 4
		ewarn "Regenerating Info directory index in ${infodir} ..."
		rm -f "${ED}"${infodir}/dir{,.*}
		for f in "${ED}"${infodir}/*; do
			if [[ ${f##*/} != *-[0-9]* && -e ${f} ]]; then
				install-info --info-dir="${ED}"${infodir} "${f}" \
					|| die "install-info failed"
			fi
		done
	fi
}

pkg_postinst() {
	local f
	for f in "${EROOT}"/var/lib/games/emacs/{snake,tetris}-scores; do
		[ -e "${f}" ] || touch "${f}"
	done
	chown games "${EROOT}"/var/lib/games/emacs

	elisp-site-regen
	eselect emacs update ifunset

	if use X; then
		echo
		elog "You need to install some fonts for Emacs."
		elog "Installing media-fonts/font-adobe-{75,100}dpi on the X server's"
		elog "machine would satisfy basic Emacs requirements under X11."
		elog "See also http://www.gentoo.org/proj/en/lisp/emacs/xft.xml"
		elog "for how to enable anti-aliased fonts."
	fi

	echo
	elog "You can set the version to be started by /usr/bin/emacs through"
	elog "the Emacs eselect module, which also redirects man and info pages."
	elog "Therefore, several Emacs versions can be installed at the same time."
	elog "\"man emacs.eselect\" for details."
	echo
	elog "If you upgrade from a previous major version of Emacs, then it is"
	elog "strongly recommended that you use app-admin/emacs-updater to rebuild"
	elog "all byte-compiled elisp files of the installed Emacs packages."
}

pkg_postrm() {
	elisp-site-regen
	eselect emacs update ifunset
}
