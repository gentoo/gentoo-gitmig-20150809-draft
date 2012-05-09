# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-common-gentoo/emacs-common-gentoo-1.3-r2.ebuild,v 1.2 2012/05/09 01:43:57 aballier Exp $

EAPI=4

inherit elisp-common eutils fdo-mime gnome2-utils

DESCRIPTION="Common files needed by all GNU Emacs versions"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="X"

PDEPEND="virtual/emacs"

src_install() {
	insinto "${SITELISP}"
	doins subdirs.el

	keepdir /etc/emacs
	insinto /etc/emacs
	doins site-start.el

	if use X; then
		local i
		domenu emacs.desktop emacsclient.desktop || die

		pushd icons
		newicon sink.png emacs-sink.png || die
		newicon emacs_48.png emacs.png || die
		newicon emacs22_48.png emacs22.png || die
		for i in 16 24 32 48 128; do
			insinto /usr/share/icons/hicolor/${i}x${i}/apps
			newins emacs_${i}.png emacs.png
			[[ ${i} -ne 128 ]] && newins emacs22_${i}.png emacs22.png
		done
		insinto /usr/share/icons/hicolor/scalable/apps
		doins emacs.svg
		popd

		gnome2_icon_savelist
	fi
}

site-start-modified-p() {
	case $(cksum <"${EROOT}${SITELISP}/site-start.el") in
		# checksums of auto-generated site-start.el files
		"2098727038 349") return 1 ;;	# elisp-common.eclass
		"3626264063 355") return 1 ;;	# emacs-common-gentoo-1.0 (cvs rev 1.1)
		"3738455534 394") return 1 ;;	# emacs-common-gentoo-1.0 (cvs rev 1.6)
		"4199862847 394") return 1 ;;	# emacs-common-gentoo-1.1
		"2547348044 394") return 1 ;;	# emacs-common-gentoo-1.2
		"2214952934 397") return 1 ;;	# emacs-common-gentoo-1.2-r1
		"3917799317 397") return 1 ;;	# emacs-common-gentoo-1.2-r2
		*) return 0 ;;
	esac
}

pkg_postinst() {
	if use X; then
		fdo-mime_desktop_database_update
		gnome2_icon_cache_update
	fi

	# make sure that site-gentoo.el exists since site-start.el requires it
	elisp-site-regen

	local line
	while read line; do elog "${line:- }"; done <<-EOF
	All site initialisation for Gentoo-installed packages is added to
	${SITELISP}/site-gentoo.el. In order for this site
	initialisation to be loaded for all users automatically, a default
	site startup file /etc/emacs/site-start.el is installed. You are
	responsible for maintenance of this file.

	Alternatively, individual users can add the following command:

	(require 'site-gentoo)

	to their ~/.emacs initialisation files, or, for greater flexibility,
	users may load single package-specific initialisation files from
	${SITELISP}/site-gentoo.d/.
	EOF

	if [[ -e ${EROOT}${SITELISP}/site-start.el ]]; then
		elog
		ewarn "The location of the site startup file for Emacs has changed to"
		ewarn "/etc/emacs/site-start.el."
		if site-start-modified-p; then
			ewarn "If your site-start.el file contains your own customisation,"
			ewarn "you should move it to the new file. In any case, you should"
			ewarn "remove the old ${SITELISP}/site-start.el file."
		else
			ewarn "Removing the old ${SITELISP}/site-start.el file."
			rm -f "${EROOT}${SITELISP}/site-start.el"
		fi
	fi
}

pkg_postrm() {
	if use X; then
		fdo-mime_desktop_database_update
		gnome2_icon_cache_update
	fi
}
