# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/amavis/amavis-0.2.1-r3.ebuild,v 1.2 2002/09/23 20:16:22 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Virus Scanner"
SRC_URI="http://www.amavis.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.amavis.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="net-mail/maildrop
	>=net-mail/tnef-0.13
	>=net-mail/vlnx-407e
	net-mail/qmail"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-securetar.patch
}

src_compile() {
	./reconf
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
	econf \
		--with-logdir=/var/log/scanmail \
		--with-virusdir=/var/tmp/virusmails \
		--enable-qmail || die

	make || die
}

src_install() {
	try make prefix=${D}/usr install
	into /usr
	dodoc AUTHORS BUGS COPYING ChangeLog FAQ HINTS NEWS README* TODO
	dodoc doc/amavis.txt
	dohtml -r doc
	dodir /var/log/scanmail
	dodir /var/tmp/virusmails
	chmod 777 ${D}/var/log/scanmail
	chmod 777 ${D}/var/tmp/virusmails
}

pkg_setup() {
	# from "createaccount" that was designed to run during the
	# installation phase

	error="no"
	whoami=`/usr/bin/id | cut -d'(' -f2 | cut -d')' -f1`

	aliases=/etc/mail/aliases

	if test "`echo \"virusalert\" | grep \"@\" | wc -l`" -eq 1; then
		echo "WARNING: using off-site mail account: \"virusalert\""
		echo "WARNING: be sure it is able to receive mail"
	else
		if test "`ls /home | grep -w \"virusalert\" | wc -l`" -eq 1; then
			true
		else
			if test -n "$aliases"; then
				if test "`grep \"virusalert\" $aliases | wc -l`" -lt 1; then
					if test -w "$aliases"; then
						echo "virusalert: $whoami" >> $aliases
					else
						echo "WARNING: $aliases is not writable by \"$whoami\""
						error="yes"
					fi
				fi
			else
				echo "WARNING: mail aliases file not found: /etc/aliases"
				error="yes"
			fi
		fi
	fi

	if test "$error" = "yes"; then
		einfo "WARNING: could not create mail account: \"virusalert\""
		einfo "WARNING: be sure to create it manually"
	fi
}
