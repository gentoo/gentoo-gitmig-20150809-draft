# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/amavis/amavis-0.3.12.ebuild,v 1.2 2003/04/19 23:39:00 prez Exp $

DESCRIPTION="A perl module which integrates virus scanning software with your MTA"
HOMEPAGE="http://www.amavis.org"
SRC_URI="mirror://sourceforge/amavis/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="dev-lang/perl
	sys-apps/file
	app-arch/arc
	sys-apps/bzip2
	app-arch/lha
	app-arch/unarj
	sys-apps/sharutils
	app-arch/unrar
	app-arch/zoo
	dev-perl/IO-stringy
	dev-perl/Unix-Syslog
	dev-perl/MailTools
	dev-perl/MIME-Base64
	>=dev-perl/MIME-tools-5.313
	>dev-perl/Convert-UUlib-0.2
	>=dev-perl/Convert-TNEF-0.06
	>=dev-perl/Compress-Zlib-1.14
	dev-perl/Archive-Tar
	>=dev-perl/Archive-Zip-1.0
	dev-perl/libnet
	virtual/mta
	virtual/mda
	virtual/antivirus"

S="${WORKDIR}/${P/_/}"

pkg_setup() {

	if ! grep -q ^amavis: /etc/group ; then
                groupadd -g 10025 amavis \
			|| die "problem adding the amavis group"
		grpconv || die "failed running grpconv"
        fi

	if ! grep -q ^amavis: /etc/passwd ; then
                useradd -u 10025 -g amavis amavis \
			|| die "problem adding the amavis user"
		pwconv || die "failed running pwconv"
        fi

	if ! grep -a ^virusalert: /etc/mail/aliases ; then
		cp /etc/mail/aliases /etc/mail/aliases.orig
		echo >> /etc/mail/aliases
		echo "# user that virus messages are forwarded to" \
			>> /etc/mail/aliases
		echo "virusalert: root" >> /etc/mail/aliases
		newaliases || die "check your /etc/mail/aliases for problems"
	fi

}

mymta=`grep "^virtual/mta net-mail\/\(exim\|postfix\|qmail\)" /var/cache/edb/virtuals | awk -F/ '{print $3}'`

src_unpack() {

	unpack ${A}
	cd ${S}

	if [ "$mymta" == "postfix" ]; then
		patch -p1 < ${FILESDIR}/0.3.12-postfix.diff || die "patch failed"
	fi

}

src_compile() {

	cp configure configure.tmp
	sed \
		-e "s:/usr/local/f-prot:/opt/f-prot:" \
		-e "s:ac_dummy=\"\$PATH\:/usr/bin\:/usr/local/bin\":ac_dummy=\"\$PATH\:/usr/bin\:/usr/local/bin\:/opt/vlnx\":" \
		< configure.tmp > configure 

	local myconf

	if [ "$mymta" == "postfix" ]; then
		myconf="--enable-postfix"
	elif [ "$mymta" == "qmail" ]; then
		myconf="--enable-qmail"
	elif [ "$mymta" == "exim" ]; then
		myconf="--enable-exim"
	elif [ "$mymta" == "sendmail" ]; then
		myconf="--enable-sendmail"
	fi

	# The quarantine directory for infected emails
	myconf="${myconf} --with-virusdir=/var/amavis/quarantine"

	econf ${myconf} || die "configure failed"

	make || die "make failed"

}

src_install() {

	dodir /var/amavis/quarantine

	if [ "$mymta" == "qmail" ]; then
		chown -R qmailq:qmail ${D}/var/amavis
	else
		chown -R amavis:amavis ${D}/var/amavis
	fi	

	chmod -R 770 ${D}/var/amavis

	keepdir /var/amavis /var/amavis/quarantine

	einstall \
		logdir=${D}/var/amavis \
		runtime_dir=${D}/var/amavis \
		virusdir=${D}/var/amavis/quarantine \
		|| die "make install failed"

	dodoc AUTHORS BUGS ChangeLog FAQ HINTS INSTALL NEWS README* TODO

}

pkg_postinst() {

	einfo ""
	einfo "For amavis to work properly with your $mymta installation"
	einfo "there are some configuration changes required"
	einfo ""
	einfo "less /usr/share/doc/${P}/README.$mymta.gz"
	einfo ""

}
