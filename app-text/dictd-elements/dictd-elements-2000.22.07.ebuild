# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd-elements/dictd-elements-2000.22.07.ebuild,v 1.2 2001/04/24 22:58:35 michael Exp $

#P=
A=elements-20001107-pre.tar.gz
S=${WORKDIR}
DESCRIPTION=""
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${A}"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins elements.dict.dz
	doins elements.index
}

pkg_postinst() {
if [ -f /etc/dict/dictd.conf ]; then
cat >> /etc/dict/dictd.conf << __EOF__
database elements  { data "/usr/lib/dict/elements.dict.dz"
                     index "/usr/lib/dict/elements.index" }
__EOF__
fi
}

pkg_postrm() {
if [ -f /etc/dict/dictd.conf ]; then
  cat /etc/dict/dictd.conf | sed -e '/elements/d' > /etc/dict/dictd.conf.$$
  mv /etc/dict/dictd.conf.$$ /etc/dict/dictd.conf
fi
}

# vim: ai et sw=4 ts=4
