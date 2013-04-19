require 'rspec'
require 'admin-utils/au_ftp'

include AuFtp

describe "Ftp Works" do

  it "should open an ftp connection" do
    ftp = mock('Ftp Server', :null_objects => true)
    Net::FTP.should_receive(:new).and_return(ftp)
    ftp.should_receive(:connect).with('host', 21)
    ftp.should_receive(:login).with('user', 'passwd', 'acct')
    AuFtp.open_ftp_connection('host', 21, 'user', 'passwd', 'acct')
  end

  it "should upload a file via ftp" do
    ftp = Net::FTP.new
    ftp.should_receive(:pwd)
    ftp.should_receive(:chdir).with('test_dir')
    ftp.should_receive(:putbinaryfile).with('test_file')
    ftp.should_receive(:chdir)
    transfer_via_ftp(ftp, 'test_dir', 'test_file')
  end

  it "should upload multiple files" do
    ftp = Net::FTP.new
    ftp.should_receive(:pwd)
    ftp.should_receive(:chdir).with('test_dir')
    ftp.should_receive(:putbinaryfile).with('file1')
    ftp.should_receive(:putbinaryfile).with('file2')
    ftp.should_receive(:chdir)
    transfer_via_ftp(ftp, 'test_dir', %w[file1 file2])
  end

  it "should not upload on an empty file string" do
    ftp = Net::FTP.new
    ftp.should_receive(:pwd)
    ftp.should_receive(:chdir).with('test_dir')
    ftp.should_not_receive(:putbinaryfile)
    ftp.should_receive(:chdir)
    transfer_via_ftp(ftp, 'test_dir', '')
  end

  it "should not upload on an empty array" do
    ftp = Net::FTP.new
    ftp.should_receive(:pwd)
    ftp.should_receive(:chdir).with('test_dir')
    ftp.should_not_receive(:putbinaryfile).with([])
    ftp.should_receive(:chdir)
    transfer_via_ftp(ftp, 'test_dir', [])
  end

  it "should close an ftp connection" do
    ftp = Net::FTP.new
    ftp.should_receive(:close)
    close_ftp_connection(ftp)
  end
end