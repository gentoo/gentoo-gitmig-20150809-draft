# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

DESCRIPTION="Winex - fake ebuild!"
HOMEPAGE="http://www.transgaming.com/"

SLOT="3000"
KEYWORDS="x86 -ppc -sparc"
LICENSE="Aladdin"
IUSE=""

DEPEND=""

pkg_postinst() {
einfo This package was removed from portage tree due to the request from Transgaming. Here is an extract from their email:
einfo The primary reason for the WineX CVS tree being publicly available
einfo "under the Aladdin Free Public License (AFPL) is to give outside"
einfo developers who have an interest in the project the ability to track
einfo our most current work, and to assist us with code or testing.
einfo Our work is very complex though, and only a limited number of
einfo developers have the skills required to contribute.
einfo The intent of the public CVS tree is *not* to provide a 'free' version
einfo of WineX that can be used without paying for it.  We want everyone
einfo with an interest in the project to contribute, whether they contribute
einfo code, or money to assist us with our development efforts.  We felt that
einfo the AFPL was a good compromise to allow that to happen, which is why
einfo we chose it.
}
