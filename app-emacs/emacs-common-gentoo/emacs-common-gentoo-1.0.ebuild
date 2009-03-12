# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-common-gentoo/emacs-common-gentoo-1.0.ebuild,v 1.1 2009/03/12 09:44:24 ulm Exp $

inherit elisp-common eutils fdo-mime gnome2-utils

DESCRIPTION="Common files needed by all GNU Emacs versions"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="X"

PDEPEND="virtual/emacs"

pkg_setup() {
	# clean up orphan file installed by old Emacs ebuilds
	rm -f "${ROOT}${SITELISP}/subdirs.el"
}

src_install() {
	elisp-install . subdirs.el || die

	if use X; then
		local i
		domenu emacs.desktop emacsclient.desktop || die
		newicon emacs_48.png emacs.png || die
		for i in 16 24 32 48; do
			insinto /usr/share/icons/hicolor/${i}x${i}/apps
			newins emacs_${i}.png emacs.png || die
		done
	fi
}

make-site-start() {
	ebegin "Creating default ${SITELISP}/site-start.el"
	cat <<-EOF >"${T}/site-start.el"
	;;; site-start.el

	;;; Commentary:
	;; This default site startup file was created by package
	;; ${CATEGORY}/${PF}. You may modify this file, replace it
	;; by your own site initialisation, or even remove it completely.

	;;; Code:
	;; Load site initialisation for Gentoo installed packages.
	(require 'site-gentoo)

	;;; site-start.el ends here
	EOF
	mv "${T}/site-start.el" "${ROOT}${SITELISP}/site-start.el"
	eend $? "Installation of site-start.el failed"
}

pkg_config() {
	if [ ! -e "${ROOT}${SITELISP}/site-start.el" ]; then
		einfo "Press ENTER to create a default site-start.el file"
		einfo "for GNU Emacs, or Control-C to abort now ..."
		read
		make-site-start
	else
		einfo "site-start.el for GNU Emacs already exists."
	fi
}

pkg_postinst() {
	if use X; then
		fdo-mime_desktop_database_update
		gnome2_icon_cache_update
	fi

	if [ ! -e "${ROOT}${SITELISP}/site-start.el" ]; then
		if [ ! -e "${ROOT}${SITELISP}"/site-gentoo.el ]; then
			# This seems to be a new install. Create site-gentoo.el and
			# a default site-start.el, so that Gentoo packages will work.
			elisp-site-regen
			make-site-start
		else
			# site-gentoo.el already exists. Give a hint how to
			# (re-)create the site-start.el file.
			elog "If this is a new install, you may want to run:"
			elog "\"emerge --config =${CATEGORY}/${PF}\""
		fi
	fi
}

pkg_postrm() {
	if use X; then
		fdo-mime_desktop_database_update
		gnome2_icon_cache_update
	fi
}
