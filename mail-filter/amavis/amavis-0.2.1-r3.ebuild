# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/amavis/amavis-0.2.1-r3.ebuild,v 1.4 2004/07/14 16:36:57 agriffis Exp $

inherit eutils

DESCRIPTION="Virus Scanner"
HOMEPAGE="http://www.amavis.org/"
SRC_URI="http://www.amavis.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc"
IUSE=""

DEPEND="mail-filter/maildrop
	>=net-mail/tnef-0.13
	>=app-antivirus/vlnx-407e
	mail-mta/qmail"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-securetar.patch
}

src_compile() {
	./reconf
	epatch ${FILESDIR}/${P}-gentoo.diff
	econf \
		--with-logdir=/var/log/scanmail \
		--with-virusdir=/var/tmp/virusmails \
		--enable-qmail || die
	make || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS BUGS COPYING ChangeLog FAQ HINTS NEWS README* TODO
	dodoc doc/amavis.txt
	dohtml -r doc
	dodir /var/log/scanmail
	dodir /var/tmp/virusmails
	chmod 1777 ${D}/var/log/scanmail
	chmod 1777 ${D}/var/tmp/virusmails
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
