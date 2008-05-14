# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kedit/kedit-3.5.9.ebuild,v 1.7 2008/05/14 12:25:17 corsair Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE: very simple text editor"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

src_compile() {
	kde-meta_src_compile
	sed -e "/^Categories/s/=.*$/=Qt;KDE;Utility;TextEditor;/" \
		-e "/Mimetype/s/$/;/" -i "${S}"/${PN}/KEdit.desktop \
		|| die "Sed to fix .desktop entry failed."
}
