# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd-misc/dictd-misc-1.5b.ebuild,v 1.2 2001/04/24 22:58:35 michael Exp $

#P=
A=dict-misc-1.5b-pre.tar.gz
S=${WORKDIR}
DESCRIPTION=""
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${A}"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins easton.dict.dz
	doins easton.index
	doins hitchcock.dict.dz
	doins hitchcock.index
	doins world95.dict.dz
	doins world95.index
}

pkg_postinst() {
if [ -f /etc/dict/dictd.conf ]; then
cat >> /etc/dict/dictd.conf << __EOF__
database easton  { data "/usr/lib/dict/easton.dict.dz"
                   index "/usr/lib/dict/easton.index" }
database hitchcock  { data "/usr/lib/dict/hitchcock.dict.dz"
                      index "/usr/lib/dict/hitchcock.index" }
database worl95  { data "/usr/lib/dict/world95.dict.dz"
                   index "/usr/lib/dict/world95.index" }
__EOF__
fi
}

pkg_postrm() {
if [ -f /etc/dict/dictd.conf ]; then
  cat /etc/dict/dictd.conf | sed -e '/easton/d' -e '/hitchcock/d' \
     -e '/world95/d' > /etc/dict/dictd.conf.$$
  mv /etc/dict/dictd.conf.$$ /etc/dict/dictd.conf
fi
}


# vim: ai et sw=4 ts=4
