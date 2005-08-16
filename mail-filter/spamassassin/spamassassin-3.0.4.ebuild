# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamassassin/spamassassin-3.0.4.ebuild,v 1.11 2005/08/16 09:52:10 mcummings Exp $

inherit perl-module

MY_P=Mail-SpamAssassin-${PV//_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="SpamAssassin is an extensible email filter which is used to identify spam."
HOMEPAGE="http://spamassassin.apache.org/"
SRC_URI="mirror://apache/spamassassin/source/${MY_P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 mips"
IUSE="berkdb qmail ssl doc"

# To consider (not all may be in tree at this time - mcummings):
# dev-perl/Net-SMTP
# dev-perl/Mail-SPF-Query
# dev-perl/IP-Country-Fast
# dev-perl/Net-Ident
# perl-core/Time-HiRes
# DB support? mysql, postgres, etc.

DEPEND=">=dev-lang/perl-5.8.2-r1
	>=dev-perl/PodParser-1.22
	perl-core/MIME-Base64
	perl-core/Storable
	>=dev-perl/HTML-Parser-3.31
	>=dev-perl/Net-DNS-0.34
	dev-perl/Digest-SHA1
	ssl? (
		dev-perl/IO-Socket-SSL
		dev-libs/openssl
	)
	berkdb? (
		perl-core/DB_File
	)"

src_move_doc() {
	echo "Renaming $1 to $2"
	mv $1 $2 || die failed to move documentation
}

src_append_doc() {
	echo "Appending $1 to $2"
	cat $1 >> $2 || die failed to append documentation
}

src_compile() {
	# - Set SYSCONFDIR explicitly so we can't get bitten by bug 48205 again
	#   (just to be sure, nobody knows how it could happen in the first place).
	myconf="SYSCONFDIR=/etc DATADIR=/usr/share/spamassassin"

	# If ssl is enabled, spamc can be built with ssl support
	if use ssl; then
		myconf="${myconf} ENABLE_SSL=yes"
	else
		myconf="${myconf} ENABLE_SSL=no"
	fi

	# Set the path to the Perl executable explictly.  This will be used to
	# create the initial sharpbang line in the scripts and might cause
	# a versioned app name end in there, see
	# <http://bugs.gentoo.org/show_bug.cgi?id=62276>
	myconf="${myconf} PERL_BIN=/usr/bin/perl"

	# If you are going to enable taint mode, make sure that the bug where
	# spamd doesn't start when the PATH contains . is addressed, and make
	# sure you deal with versions of razor <2.36-r1 not being taint-safe.
	# <http://bugzilla.spamassassin.org/show_bug.cgi?id=2511> and
	# <http://spamassassin.org/released/Razor2.patch>.
	myconf="${myconf} PERL_TAINT=no"

	# No settings needed for 'make all'.
	mymake=""

	# Neither for 'make install'.
	myinst=""

	# Some more files to be installed (README* and Changes are already
	# included per default)
	mydoc="NOTICE
	TRADEMARK
	LICENSE
	CREDITS
	INSTALL
	UPGRADE
	BUGS
	USAGE
	README.spamd
	README.sql
	README.ldap
	procmailrc.example
	sample-nonspam.txt
	sample-spam.txt
	STATISTICS.set0
	STATISTICS.set1
	STATISTICS.set2
	STATISTICS.set3"


	use qmail && mydoc="${mydoc} README.qmail"

	# Add Gentoo tag to make it easier for the upstream devs to spot
	# possible modifications or patches.
	version_tag="g${PV:6}${PR}"
	version_str="${PV//_/-}-${version_tag}"

	# Create the Gentoo config file before Makefile.PL is called so it
	# is copied later on.
	echo "version_tag ${version_tag}" > rules/11_gentoo.cf

	# Setting the following env var ensures that no questions are asked.
	export PERL_MM_USE_DEFAULT=1
	perl-module_src_prep
	# Run the autoconf stuff now, just to make the build sequence look more
	# familiar to the user :)  Plus feeding the VERSION_STRING skips some
	# calls to Perl.
	make spamc/Makefile VERSION_STRING="${version_str}"

	# Now compile all the stuff selected.
	perl-module_src_compile
	if use qmail; then
		make spamc/qmail-spamc || die building qmail-spamc failed
	fi

	# Rename some docu files so they don't clash with others
	src_move_doc   spamd/README              README.spamd
	src_move_doc   spamc/README.qmail        README.qmail
	src_move_doc   sql/README                README.sql
	src_append_doc sql/README.bayes          README.sql
	src_append_doc sql/README.awl            README.sql
	src_move_doc   ldap/README               README.ldap
	src_move_doc   rules/STATISTICS.txt      STATISTICS.set0
	src_move_doc   rules/STATISTICS-set1.txt STATISTICS.set1
	src_move_doc   rules/STATISTICS-set2.txt STATISTICS.set2
	src_move_doc   rules/STATISTICS-set3.txt STATISTICS.set3
	# Remove the MANIFEST files as they aren't docu files
	rm -f MANIFEST*

	if use doc; then
		make text_html_doc
	fi

}

src_install () {
	perl-module_src_install

	# Move spamd to sbin where it belongs.
	dodir /usr/sbin
	mv "${D}"/usr/bin/spamd "${D}"/usr/sbin/spamd  || die

	if use qmail; then
		dobin spamc/qmail-spamc
	fi

	dosym /etc/mail/spamassassin /etc/spamassassin

	# Add the init and config scripts.
	newinitd "${FILESDIR}"/3.0.0-spamd.init spamd
	newconfd "${FILESDIR}"/3.0.0-spamd.conf spamd

	if use doc; then
		dodoc ${mydoc}
		dodoc spamd/PROTOCOL
		dohtml doc/*.html
	fi

	cp ${FILESDIR}/secrets.cf ${D}/etc/mail/spamassassin/secrets.cf
	fperms 0400 ${D}/etc/mail/spamassassin/secrets.cf
	echo " ">> ${D}/etc/mail/spamassassin/local.cf
	echo "# Sensitive data, such as database connection info, should">> ${D}/etc/mail/spamassassin/local.cf
	echo "# be stored in /etc/mail/spamassassin/secrets.cf with">> ${D}/etc/mail/spamassassin/local.cf
	echo "# appropriate permissions">> ${D}/etc/mail/spamassassin/local.cf

}

pkg_postinst() {
	perl-module_pkg_postinst

	if ! has_version "perl-core/DB_File"; then
		einfo "The Bayes backend requires the Berkeley DB to store its data. You"
		einfo "need to emerge perl-core/DB_File or USE=berkdb to make it available."
	fi

	if has_version "mail-filter/razor"; then
		if ! has_version ">=mail-filter/razor-2.61"; then
				ewarn "You have $(best_version mail-filter/razor) installed but SpamAssassin"
				if has_version "<mail-filter/razor-2.40"; then
					ewarn "requires at least version 2.40, version 2.61 or later is recommended."
				else
					ewarn "recommends at least version 2.61."
				fi
		fi
	fi

	if use doc; then
		einfo
		einfo "Please read the file"
		einfo "  /usr/share/doc/${PF}/INSTALL.gz"
		einfo "to find out which optional modules you need to install to enable"
		einfo "additional features which depend on them."
		einfo
		einfo "If upgraded from 2.x, please read the file"
		einfo "  /usr/share/doc/${PF}/UPGRADE.gz"
		einfo
	fi
	ewarn
	ewarn "spamd is not designed to listen to an untrusted network"
	ewarn "and is vulnerable to DoS attacks (and eternal doom) if"
	ewarn "configured to do so"
	ewarn
	ewarn "If you plan on using the -u flag to spamd, please read the notes"
	ewarn "in /etc/conf.d/spamd regarding the location of the pid file."
}
