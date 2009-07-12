# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libksieve/libksieve-3.5.10.ebuild,v 1.7 2009/07/12 09:48:15 armin76 Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="library enable support for sieve (imap server-side filtering standard) in kde apps, used by kmail"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

# The tests are broken. Fixes bug 188946.
RESTRICT="test"
