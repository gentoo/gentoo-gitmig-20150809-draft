# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dictd-web1913/dictd-web1913-1.4-r1.ebuild,v 1.5 2003/07/16 15:15:56 pvdabeel Exp $

MY_P=${P/td/t}-pre
S=${WORKDIR}
DESCRIPTION="Webster's Revised Unabridged Dictionary (1913) for dict"
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${MY_P}.tar.gz"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins web1913.dict.dz
	doins web1913.index
}

# vim: ai et sw=4 ts=4
