# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libksieve/libksieve-3.5.9.ebuild,v 1.7 2008/05/18 15:10:02 maekke Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="library enable support for sieve (imap server-side filtering standard) in kde apps, used by kmail"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

# The tests are broken. Fixes bug 188946.
RESTRICT="test"
