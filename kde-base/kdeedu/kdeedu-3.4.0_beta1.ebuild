# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.4.0_beta1.ebuild,v 1.1 2005/01/14 00:19:31 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE educational apps"

KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	# the scripting support in kig does not compile, maybe related to bug #40543
	myconf="${myconf} --disable-kig-python-scripting"

	kde_src_compile
}
