# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.4.0_beta1.ebuild,v 1.2 2005/01/18 16:01:39 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE educational apps"

KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	# the scripting support in kig is strongly dependent on the version
	# of dev-libs/boost installed, and often fails to compile.
	# I think it only works with 0.30.2, which is too much restrictive.
	myconf="${myconf} --disable-kig-python-scripting"

	kde_src_compile
}
